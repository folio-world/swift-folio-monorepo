//
//  TradeClient.swift
//  ToolinderDomainTradeInterface
//
//  Created by 송영모 on 2023/09/11.
//

import Foundation
import SwiftData

import ComposableArchitecture

public enum TradeError: Error {
    case unknown
}

public struct TradeClient {
    public static let tradeRepository: TradeRepositoryInterface = TradeRepository.shared
    
    public var fetchTickers: @Sendable () -> Result<[Ticker], TradeError>
    public var saveTicker: @Sendable (Ticker) -> Result<Ticker, TradeError>
    public var updateTicker: @Sendable (Ticker, TickerDTO) -> Result<Ticker, TradeError>
    public var deleteTicker: @Sendable (Ticker) -> Result<Ticker, TradeError>
    
    public var fetchTrades: @Sendable () -> Result<[Trade], TradeError>
    public var saveTrade: @Sendable (Trade) -> Result<Trade, TradeError>
    public var updateTrade: @Sendable (Trade, TradeDTO) -> Result<Trade, TradeError>
    public var deleteTrade: @Sendable (Trade) -> Result<Trade, TradeError>
    
    public init(
        fetchTickers: @Sendable @escaping () -> Result<[Ticker], TradeError>,
        saveTicker: @Sendable @escaping (Ticker) -> Result<Ticker, TradeError>,
        updateTicker: @Sendable @escaping (Ticker, TickerDTO) -> Result<Ticker, TradeError>,
        deleteTicker: @Sendable @escaping (Ticker) -> Result<Ticker, TradeError>,
        fetchTrades: @Sendable @escaping () -> Result<[Trade], TradeError>,
        saveTrade: @Sendable @escaping (Trade) -> Result<Trade, TradeError>,
        updateTrade: @Sendable @escaping (Trade, TradeDTO) -> Result<Trade, TradeError>,
        deleteTrade: @Sendable @escaping (Trade) -> Result<Trade, TradeError>
        
    ) {
        self.fetchTickers = fetchTickers
        self.saveTicker = saveTicker
        self.updateTicker = updateTicker
        self.deleteTicker = deleteTicker
        
        self.fetchTrades = fetchTrades
        self.saveTrade = saveTrade
        self.updateTrade = updateTrade
        self.deleteTrade = deleteTrade
    }
}

extension TradeClient: TestDependencyKey {
    public static var previewValue: TradeClient = Self(
        fetchTickers: { return .failure(.unknown) },
        saveTicker: { _ in return .failure(.unknown) },
        updateTicker: { _, _ in return .failure(.unknown) },
        deleteTicker: { _ in return .failure(.unknown) },
        fetchTrades: { return .failure(.unknown) },
        saveTrade: { _ in return .failure(.unknown) },
        updateTrade: { _, _ in return .failure(.unknown) },
        deleteTrade: { _ in return .failure(.unknown) }
    )
    
    public static var testValue = Self(
        fetchTickers: unimplemented("\(Self.self).fetchTickers"),
        saveTicker: unimplemented("\(Self.self).saveTicker"),
        updateTicker: unimplemented("\(Self.self).updateTicker"),
        deleteTicker: unimplemented("\(Self.self).deleteTicker"),
        fetchTrades: unimplemented("\(Self.self).fetchTrades"),
        saveTrade: unimplemented("\(Self.self).saveTrade"),
        updateTrade: unimplemented("\(Self.self).updateTrade"),
        deleteTrade: unimplemented("\(Self.self).deleteTrade")
    )
}

public extension DependencyValues {
    var tradeClient: TradeClient {
        get { self[TradeClient.self] }
        set { self[TradeClient.self] = newValue }
    }
}

extension TradeClient: DependencyKey {
    public static var liveValue = TradeClient(
        fetchTickers: { tradeRepository.fetchTickers(descriptor: .init()) },
        saveTicker: { tradeRepository.saveTicker(ticker: $0) },
        updateTicker: { tradeRepository.updateTicker(model: $0, dto: $1) },
        deleteTicker: { tradeRepository.deleteTicker(ticker: $0) },
        fetchTrades: { tradeRepository.fetchTrades(descriptor: .init()) },
        saveTrade: { tradeRepository.saveTrade(trade: $0) },
        updateTrade: { tradeRepository.updateTrade(model:$0, dto: $1) },
        deleteTrade: { tradeRepository.deleteTrade(trade: $0) }
    )
}
