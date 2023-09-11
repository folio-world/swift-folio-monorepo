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
    public var fetchTrades: @Sendable () -> Result<[Trade], TradeError>
    public var saveTrade: @Sendable (Trade) -> Result<Trade, TradeError>
    public var saveTicker: @Sendable (Ticker) -> Result<Ticker, TradeError>
    
    public init(
        fetchTickers: @Sendable @escaping () -> Result<[Ticker], TradeError>,
        fetchTrades: @Sendable @escaping () -> Result<[Trade], TradeError>,
        saveTicker: @Sendable @escaping (Ticker) -> Result<Ticker, TradeError>,
        saveTrade: @Sendable @escaping (Trade) -> Result<Trade, TradeError>
        
    ) {
        self.fetchTickers = fetchTickers
        self.fetchTrades = fetchTrades
        self.saveTicker = saveTicker
        self.saveTrade = saveTrade
    }
}

extension TradeClient: TestDependencyKey {
    public static var previewValue: TradeClient = Self(
        fetchTickers: { return .failure(.unknown) },
        fetchTrades: { return .failure(.unknown) },
        saveTicker: { _ in return .failure(.unknown) },
        saveTrade: { _ in return .failure(.unknown) }
    )
    
    public static var testValue = Self(
        fetchTickers: unimplemented("\(Self.self).fetchTickers"),
        fetchTrades: unimplemented("\(Self.self).fetchTrades"),
        saveTicker: unimplemented("\(Self.self).saveTicker"),
        saveTrade: unimplemented("\(Self.self).saveTrade")
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
        fetchTrades: { tradeRepository.fetchTrades(descriptor: .init()) },
        saveTicker: { tradeRepository.saveTicker(ticker: $0) },
        saveTrade: { tradeRepository.saveTrade(trade: $0) }
    )
}
