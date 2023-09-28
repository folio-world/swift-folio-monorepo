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

public struct TradeEditStore: Reducer {
    public init() {}
    
    public enum Mode {
        case add
        case bypassAdd
        case edit
    }
    
    public struct State: Equatable {
        public let mode: Mode
        public var selectedTicker: Ticker
        public var selectedTrade: Trade?
        
        public var price: Double
        public var volume: Double
        public var fee: Double
        public var selectedDate: Date = .now
        public var selectedTradeSide: TradeSide = .buy
        public var note: String = ""
        public var images: [Data] = []
        
        public var selectedPhotosPickerItems: [PhotosPickerItem] = []
        
        @PresentationState var alert: AlertState<Action.Alert>?
        
        public init(
            mode: Mode = .add,
            selectedTicker: Ticker,
            selectedTrade: Trade? = nil,
            selectedDate: Date = .now
        ) {
            self.mode = mode
            self.selectedTicker = selectedTicker
            self.selectedTrade = selectedTrade
            self.price = selectedTrade?.price ?? 0
            self.volume = selectedTrade?.volume ?? 0
            self.fee = selectedTrade?.fee ?? 0
            self.selectedDate = selectedTrade?.date ?? selectedDate
            self.note = selectedTrade?.note ?? ""
            self.images = selectedTrade?.images ?? []
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case setPrice(Double)
        case setVolume(Double)
        case setFee(Double)
        case selectDate(Date)
        case selectTradeSide(TradeSide)
        case setNote(String)
        case setPhotoPickerItems([PhotosPickerItem])
        case dismissButtonTapped
        case saveButtonTapped
        case deleteButtonTapped
        
        case photoToDataResponse([Data])
        
        case alert(PresentationAction<Alert>)
        case delegate(Delegate)
        
        public enum Alert: Equatable {
            case confirmDeletion
        }
        
        public enum Delegate: Equatable {
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
            
        case let .setPrice(price):
            state.price = price
            return .none
            
        case let .setVolume(volume):
            state.volume = volume
            return .none
            
        case let .setFee(fee):
            state.fee = fee
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
            return .send(.delegate(.cancel(state.selectedTicker)))
            
        case .saveButtonTapped:
            return validateAndSaveTradeEffect(
                trade: state.selectedTrade,
                side: state.selectedTradeSide,
                price: state.price,
                volume: state.volume,
                fee: state.fee,
                images: state.images,
                note: state.note,
                date: state.selectedDate,
                ticker: state.selectedTicker
            )
            
        case .deleteButtonTapped:
            state.alert = AlertState {
                TextState("Are you sure?")
            } actions: {
                ButtonState(role: .destructive, action: .confirmDeletion) {
                    TextState("Delete")
                }
            }
            return .none
            
        case let .photoToDataResponse(data):
            state.images = data
            return .none
            
        case .alert(.presented(.confirmDeletion)):
            if let trade = state.selectedTrade, let _ = try? tradeClient.deleteTrade(trade).get() {
                return .send(.delegate(.delete(trade)))
            }
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
        fee: Double,
        images: [Data],
        note: String,
        date: Date,
        ticker: Ticker
    ) -> Effect<TradeEditStore.Action> {
        guard !price.isZero else { return .none }
        guard !volume.isZero else { return .none }
        guard fee < 100 else { return .none }
        
        if let unSavedTrade = trade {
            if let trade = try? tradeClient.updateTrade(unSavedTrade, .init(
                side: side,
                price: price,
                volume: volume,
                fee: fee,
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
                fee: fee,
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
