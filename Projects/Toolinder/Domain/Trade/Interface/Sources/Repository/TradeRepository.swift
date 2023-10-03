//
//  TradeContainer.swift
//  ToolinderDomainTradeInterface
//
//  Created by 송영모 on 2023/09/11.
//

import Foundation
import SwiftData

public protocol TradeRepositoryInterface {
    func fetchTrades(descriptor: FetchDescriptor<Trade>) -> Result<[Trade], TradeError>
    func saveTrade(_ trade: TradeDTO) -> Result<Trade, TradeError>
    func updateTrade(_ trade: Trade, new newTrade: TradeDTO) -> Result<Trade, TradeError>
    func deleteTrade(_ trade: Trade) -> Result<Trade, TradeError>
    
    func isValidatedSaveTrade(_ trade: TradeDTO) -> Bool
    func isValidatedUpdateTrade(_ trade: Trade, new newTrade: TradeDTO) -> Bool
    func isValidatedDeleteTrade(_ trade: Trade) -> Bool
}

public class TradeRepository: TradeRepositoryInterface {
    private var context: ModelContext? = StorageContainer.shared.context
    
    public init() { }
    
    public func fetchTrades(descriptor: FetchDescriptor<Trade>) -> Result<[Trade], TradeError> {
        if let trades = try? context?.fetch(descriptor) {
            return .success(trades)
        } else {
            return .failure(.unknown)
        }
    }
    
    public func saveTrade(_ trade: TradeDTO) -> Result<Trade, TradeError> {
        if isValidatedSaveTrade(trade) {
            let trade = trade.toDomain()
            context?.insert(trade)
            return .success(trade)
        } else {
            return .failure(.unknown)
        }
    }
    
    public func updateTrade(_ trade: Trade, new newTrade: TradeDTO) -> Result<Trade, TradeError> {
        if isValidatedUpdateTrade(trade, new: newTrade) {
            let trade = trade
            trade.ticker = newTrade.ticker
            trade.date = newTrade.date
            trade.side = newTrade.side
            trade.price = newTrade.price
            trade.quantity = newTrade.quantity
            trade.images = newTrade.images
            trade.note = newTrade.note
            return .success(trade)
        } else {
            return .failure(.unknown)
        }
    }
    
    public func deleteTrade(_ trade: Trade) -> Result<Trade, TradeError> {
        if isValidatedDeleteTrade(trade) {
            context?.delete(trade)
            return .success(trade)
        } else {
            return .failure(.unknown)
        }
    }
    
    public func isValidatedSaveTrade(_ trade: TradeDTO) -> Bool {
        if trade.side == .buy { return true }
        guard let trades = try? fetchTrades(descriptor: .init()).get().filter({ $0.ticker == trade.ticker }).sorted(by: { $0.date < $1.date })
        else { return false }
        
        let currentVolume = trades.reduce(0) { (result, trade) in
            if trade.side == .buy {
                return result + trade.quantity
            } else {
                return result - trade.quantity
            }
        }
        
        return currentVolume - trade.quantity >= 0
    }
    
    public func isValidatedUpdateTrade(_ trade: Trade, new newTrade: TradeDTO) -> Bool {
        if trade.side == .sell && newTrade.side == .buy { return true }
        guard let trades = try? fetchTrades(descriptor: .init()).get().filter({ $0.ticker == trade.ticker }).sorted(by: { $0.date < $1.date })
        else { return false }
        
        var currentVolume = 0.0
        for tmpTrade in trades {
            if trade.side == .buy {
                currentVolume += tmpTrade == trade ? newTrade.quantity : tmpTrade.quantity
            } else {
                currentVolume -= tmpTrade == trade ? newTrade.quantity : tmpTrade.quantity
            }
            
            if currentVolume < 0 {
                return false
            }
        }
        return true
    }
    
    public func isValidatedDeleteTrade(_ trade: Trade) -> Bool {
        if trade.side == .sell { return true }
        
        guard let trades = try? fetchTrades(descriptor: .init(sortBy: [.init(\.date)])).get().filter({ $0.ticker == trade.ticker })
        else { return false }
        
        var currentVolume = 0.0
        for tmpTrade in trades {
            if trade.side == .buy {
                currentVolume += tmpTrade == trade ? 0 : tmpTrade.quantity
            } else {
                currentVolume -= tmpTrade == trade ? 0 : tmpTrade.quantity
            }
            
            if currentVolume < 0 {
                return false
            }
        }
        return true
    }
}
