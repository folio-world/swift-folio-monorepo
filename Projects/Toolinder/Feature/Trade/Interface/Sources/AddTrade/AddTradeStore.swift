//
//  AddPriceStore.swift
//  ToolinderFeatureCalendarDemo
//
//  Created by 송영모 on 2023/09/08.
//

import SwiftUI
import PhotosUI

import ComposableArchitecture

import ToolinderDomain

public struct EditTradeStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public var trade: Trade?
        public var ticker: Ticker
        
        public var count: Double = .zero
        public var price: Double = .zero
        public var selectedDate: Date = .now
        public var selectedTradeSide: TradeSide = .buy
        public var note: String = ""
        public var images: [Data] = []
        
        public var selectedPhotosPickerItems: [PhotosPickerItem] = []
        
        public init(ticker: Ticker) {
            self.ticker = ticker
        }
        
        public init(trade: Trade, ticker: Ticker) {
            self.trade = trade
            self.ticker = ticker
            self.count = trade.volume ?? 0
            self.price = trade.price ?? 0
            self.selectedDate = trade.date
            self.selectedTradeSide = trade.side ?? .buy
            self.note = trade.note ?? ""
            self.images = trade.images
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case setCount(Double)
        case setPrice(Double)
        case selectDate(Date)
        case selectTradeSide(TradeSide)
        case setNote(String)
        case setPhotoPickerItems([PhotosPickerItem])
        case dismissButtonTapped
        case cancleButtonTapped
        case saveButtonTapped
        case deleteButtonTapped
        
        case photoToDataResponse([Data])
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case dismiss
            case cancel(Ticker)
            case save(Trade)
            case delete(Trade)
        }
    }
    
    @Dependency(\.tradeClient) var tradeClient
    @Dependency(\.photoClient) var photoClient
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action>  {
        switch action {
        case .onAppear:
            return .none
            
        case let .setCount(count):
            state.count = count
            return .none
            
        case let .setPrice(price):
            state.price = price
            return .none
            
        case let .selectDate(date):
            state.selectedDate = date
            return .none
            
        case let .selectTradeSide(tradeSide):
            state.selectedTradeSide = tradeSide
            return .none
            
        case let .setNote(note):
            state.note = note
            return .none
            
        case let .setPhotoPickerItems(photosPickerItems):
            state.selectedPhotosPickerItems = photosPickerItems

            return .run { send in
                if let data = try? await photoClient.toDataList(photosPickerItems).get() {
                    return await send(.photoToDataResponse(data))
                }
            }
            
        case .dismissButtonTapped:
            return .send(.delegate(.cancel(state.ticker)))
            
        case .cancleButtonTapped:
            return .send(.delegate(.dismiss))
            
        case .saveButtonTapped:
            return validateAndSaveTradeEffect(
                trade: state.trade,
                side: state.selectedTradeSide,
                price: state.price,
                volume: state.count,
                images: state.images,
                note: state.note,
                date: state.selectedDate,
                ticker: state.ticker
            )
            
        case .deleteButtonTapped:
            if let trade = state.trade, let _ = try? tradeClient.deleteTrade(trade).get() {
                return .send(.delegate(.delete(trade)))
            }
            return .none
            
        case let .photoToDataResponse(data):
            state.images = data
            return .none
            
        default:
            return .none
        }
    }
    
    private func validateAndSaveTradeEffect(
        trade: Trade? = nil,
        side: TradeSide,
        price: Double,
        volume: Double,
        images: [Data],
        note: String,
        date: Date,
        ticker: Ticker
    ) -> Effect<EditTradeStore.Action> {
        guard !price.isZero else { return .none }
        guard !volume.isZero else { return .none }
        
        if let unSavedTrade = trade {
            if let trade = try? tradeClient.updateTrade(unSavedTrade, .init(
                side: side,
                price: price,
                volume: volume,
                images: images,
                note: note,
                date: date,
                ticker: ticker
            )).get() {
                return .send(.delegate(.save(trade)))
            }
        } else {
            if let trade = try? tradeClient.saveTrade(.init(
                side: side,
                price: price,
                volume: volume,
                images: images,
                note: note,
                date: date,
                ticker: ticker
            )).get() {
                return .send(.delegate(.save(trade)))
            }
        }
        return .none
    }
}
