//
//  TradeContainer.swift
//  ToolinderDomainTradeInterface
//
//  Created by 송영모 on 2023/09/11.
//

import Foundation
import SwiftData

public protocol TradeRepositoryInterface {
    func fetchTickers(descriptor: FetchDescriptor<Ticker>) -> Result<[Ticker], TradeError>
    func saveTicker(ticker: Ticker) -> Result<Ticker, TradeError>
    func updateTicker(model: Ticker, dto: TickerDTO) -> Result<Ticker, TradeError>
    func deleteTicker(ticker: Ticker) -> Result<Ticker, TradeError>
    
    func fetchTrades(descriptor: FetchDescriptor<Trade>) -> Result<[Trade], TradeError>
    func saveTrade(trade: Trade) -> Result<Trade, TradeError>
    func updateTrade(model: Trade, dto: TradeDTO) -> Result<Trade, TradeError>
    func deleteTrade(trade: Trade) -> Result<Trade, TradeError>
    
    func isValidatedSaveTicker(new: Ticker) -> Bool
    func isValidatedUpdateTicker(origin: Ticker, new: TickerDTO) -> Bool
    func isValidatedDeleteTicker(origin: Ticker) -> Bool
    
    func isValidatedSaveTrade(trade: Trade) -> Bool
    func isValidatedUpdateTrade(origin: Trade, new: TradeDTO) -> Bool
    func isValidatedDeleteTrade(origin: Trade) -> Bool
}

public class TradeRepository: TradeRepositoryInterface {
    public static var shared: TradeRepositoryInterface = TradeRepository()
    
    private var container: ModelContainer?
    private var context: ModelContext?
    
    private init() {
        do {
            container = try ModelContainer(for: Ticker.self, Trade.self)
            
            if let container {
                context = ModelContext(container)
            }
        } catch {
            print(error)
        }
    }
    
    public func fetchTickers(descriptor: FetchDescriptor<Ticker>) -> Result<[Ticker], TradeError> {
        if let tickers = try? context?.fetch(descriptor) {
            return .success(tickers)
        } else {
            return .failure(.unknown)
        }
    }
    
    public func saveTicker(ticker: Ticker) -> Result<Ticker, TradeError> {
        if isValidatedSaveTicker(new: ticker) {
            context?.insert(ticker)
            return .success(ticker)
        } else {
            return .failure(.unknown)
        }
    }
    
    public func updateTicker(model: Ticker, dto: TickerDTO) -> Result<Ticker, TradeError> {
        if isValidatedUpdateTicker(origin: model, new: dto) {
            let ticker = model
            ticker.type = dto.type
            ticker.currency = dto.currency
            ticker.name = dto.name
            return .success(ticker)
        } else {
            return .failure(.unknown)
        }
    }
    
    public func deleteTicker(ticker: Ticker) -> Result<Ticker, TradeError> {
        if isValidatedDeleteTicker(origin: ticker) {
            context?.delete(ticker)
            return .success(ticker)
        } else {
            return .failure(.unknown)
        }
    }
    
    public func fetchTrades(descriptor: FetchDescriptor<Trade>) -> Result<[Trade], TradeError> {
        if let trades = try? context?.fetch(descriptor) {
            return .success(trades)
        } else {
            return .failure(.unknown)
        }
    }
    
    public func saveTrade(trade: Trade) -> Result<Trade, TradeError> {
        if isValidatedSaveTrade(trade: trade) {
            context?.insert(trade)
            return .success(trade)
        } else {
            return .failure(.unknown)
        }
    }
    
    public func updateTrade(model: Trade, dto: TradeDTO) -> Result<Trade, TradeError> {
        if isValidatedUpdateTrade(origin: model, new: dto) {
            let trade = model
            trade.ticker = dto.ticker
            trade.date = dto.date
            trade.side = dto.side
            trade.price = dto.price
            trade.volume = dto.volume
            trade.images = dto.images
            trade.note = dto.note
            return .success(trade)
        } else {
            return .failure(.unknown)
        }
    }
    
    public func deleteTrade(trade: Trade) -> Result<Trade, TradeError> {
        if isValidatedDeleteTrade(origin: trade) {
            context?.delete(trade)
            return .success(trade)
        } else {
            return .failure(.unknown)
        }
    }
    
    public func isValidatedSaveTicker(new: Ticker) -> Bool {
        return true
    }
    
    public func isValidatedUpdateTicker(origin: Ticker, new: TickerDTO) -> Bool {
        if new.type != nil && new.currency != nil && new.name?.isEmpty == false {
            return true
        }
        return false
    }
    
    public func isValidatedDeleteTicker(origin: Ticker) -> Bool {
        return true
    }
    
    public func isValidatedSaveTrade(trade: Trade) -> Bool {
        if trade.side == .buy { return true }
        
        guard let trades = try? fetchTrades(descriptor: .init(sortBy: [.init(\.date)])).get().filter({ $0.ticker == trade.ticker })
        else { return false }
        
        let currentVolume = trades.reduce(0) { (result, trade) in
            if trade.side == .buy {
                return result + (trade.volume ?? 0)
            } else {
                return result - (trade.volume ?? 0)
            }
        }
        
        return currentVolume - (trade.volume ?? 0) > 0
    }
    
    public func isValidatedUpdateTrade(origin: Trade, new: TradeDTO) -> Bool {
        if origin.side == .sell && new.side == .buy { return true }
        
        guard let trades = try? fetchTrades(descriptor: .init(sortBy: [.init(\.date)])).get().filter({ $0.ticker == origin.ticker })
        else { return false }
        
        var currentVolume = 0.0
        for trade in trades {
            if trade.side == .buy {
                currentVolume += trade == origin ? (new.volume ?? 0) : (trade.volume ?? 0)
            } else {
                currentVolume -= trade == origin ? (new.volume ?? 0) : (trade.volume ?? 0)
            }
            
            if currentVolume < 0 {
                return false
            }
        }
        
        return true
    }
    
    public func isValidatedDeleteTrade(origin: Trade) -> Bool {
        if origin.side == .sell { return true }
        
        guard let trades = try? fetchTrades(descriptor: .init(sortBy: [.init(\.date)])).get().filter({ $0.ticker == origin.ticker })
        else { return false }
        
        var currentVolume = 0.0
        for trade in trades {
            if trade.side == .buy {
                currentVolume += trade == origin ? 0 : (trade.volume ?? 0)
            } else {
                currentVolume -= trade == origin ? 0 : (trade.volume ?? 0)
            }
            
            if currentVolume < 0 {
                return false
            }
        }
        
        return true
    }
}
