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
    public var updateTrade: @Sendable (Trade, TradeDTO) -> Result<Trade, TradeError>
    public var deleteTrade: @Sendable (Trade) -> Result<Trade, TradeError>
    
    public init(
        fetchTickers: @Sendable @escaping () -> Result<[Ticker], TradeError>,
        fetchTrades: @Sendable @escaping () -> Result<[Trade], TradeError>,
        saveTicker: @Sendable @escaping (Ticker) -> Result<Ticker, TradeError>,
        saveTrade: @Sendable @escaping (Trade) -> Result<Trade, TradeError>,
        updateTrade: @Sendable @escaping (Trade, TradeDTO) -> Result<Trade, TradeError>,
        deleteTrade: @Sendable @escaping (Trade) -> Result<Trade, TradeError>
        
    ) {
        self.fetchTickers = fetchTickers
        self.fetchTrades = fetchTrades
        self.saveTicker = saveTicker
        self.saveTrade = saveTrade
        self.updateTrade = updateTrade
        self.deleteTrade = deleteTrade
    }
}

extension TradeClient: TestDependencyKey {
    public static var previewValue: TradeClient = Self(
        fetchTickers: { return .failure(.unknown) },
        fetchTrades: { return .failure(.unknown) },
        saveTicker: { _ in return .failure(.unknown) },
        saveTrade: { _ in return .failure(.unknown) },
        updateTrade: { _, _ in return .failure(.unknown) },
        deleteTrade: { _ in return .failure(.unknown) }
    )
    
    public static var testValue = Self(
        fetchTickers: unimplemented("\(Self.self).fetchTickers"),
        fetchTrades: unimplemented("\(Self.self).fetchTrades"),
        saveTicker: unimplemented("\(Self.self).saveTicker"),
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
        fetchTrades: { tradeRepository.fetchTrades(descriptor: .init()) },
        saveTicker: { tradeRepository.saveTicker(ticker: $0) },
        saveTrade: { tradeRepository.saveTrade(trade: $0) },
        updateTrade: { tradeRepository.updateTrade(model:$0, dto: $1) },
        deleteTrade: { tradeRepository.deleteTrade(trade: $0) }
    )
}
