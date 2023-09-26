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
    func saveTicker(ticker: Ticker) -> Result<Ticker, TickerError>
    func updateTicker(model: Ticker, dto: TickerDTO) -> Result<Ticker, TickerError>
    func deleteTicker(ticker: Ticker) -> Result<Ticker, TickerError>
    
    func isValidatedSaveTicker(new: Ticker) -> Bool
    func isValidatedUpdateTicker(origin: Ticker, new: TickerDTO) -> Bool
    func isValidatedDeleteTicker(origin: Ticker) -> Bool
}

public class TickerRepository: TickerRepositoryInterface {
    private var container: ModelContainer?
    private var context: ModelContext?
    
    public init() {
        do {
            container = try ModelContainer(for: Ticker.self, Trade.self)
            
            if let container {
                context = ModelContext(container)
            }
        } catch {
            print(error)
        }
    }
    
    public func fetchTickers(descriptor: FetchDescriptor<Ticker>) -> Result<[Ticker], TickerError> {
        if let tickers = try? context?.fetch(descriptor) {
            return .success(tickers)
        } else {
            return .failure(.unknown)
        }
    }
    
    public func saveTicker(ticker: Ticker) -> Result<Ticker, TickerError> {
        if isValidatedSaveTicker(new: ticker) {
            context?.insert(ticker)
            return .success(ticker)
        } else {
            return .failure(.unknown)
        }
    }
    
    public func updateTicker(model: Ticker, dto: TickerDTO) -> Result<Ticker, TickerError> {
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
    
    public func deleteTicker(ticker: Ticker) -> Result<Ticker, TickerError> {
        if isValidatedDeleteTicker(origin: ticker) {
            context?.delete(ticker)
            return .success(ticker)
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
}
