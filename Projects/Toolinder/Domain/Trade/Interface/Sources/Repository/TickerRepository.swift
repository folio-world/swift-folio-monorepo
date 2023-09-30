//
//  TickerRepository.swift
//  ToolinderDomainTradeInterface
//
//  Created by 송영모 on 2023/09/26.
//

import Foundation
import SwiftData

public protocol TickerRepositoryInterface {
    func fetchTickers(descriptor: FetchDescriptor<Ticker>) -> Result<[Ticker], TickerError>
    func saveTicker(_ ticker: Ticker) -> Result<Ticker, TickerError>
    func updateTicker(_ ticker: Ticker, new newTicker: TickerDTO) -> Result<Ticker, TickerError>
    func deleteTicker(_ ticker: Ticker) -> Result<Ticker, TickerError>
    
    func isValidatedSaveTicker(_ ticker: Ticker) -> Bool
    func isValidatedUpdateTicker(_ ticker: Ticker, new newTicker: TickerDTO) -> Bool
    func isValidatedDeleteTicker(_ ticker: Ticker) -> Bool
}

public class TickerRepository: TickerRepositoryInterface {
    private var context: ModelContext? = StorageContainer.shared.context
    
    public init() { }
    
    public func fetchTickers(descriptor: FetchDescriptor<Ticker>) -> Result<[Ticker], TickerError> {
        if let tickers = try? context?.fetch(descriptor) {
            return .success(tickers)
        } else {
            return .failure(.unknown)
        }
    }
    
    public func saveTicker(_ ticker: Ticker) -> Result<Ticker, TickerError> {
        if isValidatedSaveTicker(ticker) {
            context?.insert(ticker)
            return .success(ticker)
        } else {
            return .failure(.unknown)
        }
    }
    
    public func updateTicker(_ ticker: Ticker, new newTicker: TickerDTO) -> Result<Ticker, TickerError> {
        if isValidatedUpdateTicker(ticker, new: newTicker) {
            ticker.type = newTicker.type
            ticker.currency = newTicker.currency
            ticker.name = newTicker.name
            return .success(ticker)
        } else {
            return .failure(.unknown)
        }
    }
    
    public func deleteTicker(_ ticker: Ticker) -> Result<Ticker, TickerError> {
        if isValidatedDeleteTicker(ticker) {
            context?.delete(ticker)
            return .success(ticker)
        } else {
            return .failure(.unknown)
        }
    }
    
    public func isValidatedSaveTicker(_ ticker: Ticker) -> Bool {
        return true
    }
    
    public func isValidatedUpdateTicker(_ ticker: Ticker, new newTicker: TickerDTO) -> Bool {
        if !newTicker.name.isEmpty {
            return true
        }
        return false
    }
    
    public func isValidatedDeleteTicker(_ ticker: Ticker) -> Bool {
        return true
    }
}
