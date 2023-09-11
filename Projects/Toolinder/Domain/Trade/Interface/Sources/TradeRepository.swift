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
    func fetchTrades(descriptor: FetchDescriptor<Trade>) -> Result<[Trade], TradeError>
    func saveTicker(ticker: Ticker) -> Result<Ticker, TradeError>
    func saveTrade(trade: Trade) -> Result<Trade, TradeError>
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
    
    public func fetchTrades(descriptor: FetchDescriptor<Trade>) -> Result<[Trade], TradeError> {
        if let trades = try? context?.fetch(descriptor) {
            return .success(trades)
        } else {
            return .failure(.unknown)
        }
    }
    
    public func saveTicker(ticker: Ticker) -> Result<Ticker, TradeError> {
        context?.insert(ticker)
        return .success(ticker)
    }
    
    public func saveTrade(trade: Trade) -> Result<Trade, TradeError> {
        context?.insert(trade)
        return .success(trade)
    }
}
