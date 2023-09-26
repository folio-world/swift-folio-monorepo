//
//  TickerClient.swift
//  ToolinderDomainTradeInterface
//
//  Created by 송영모 on 2023/09/26.
//

import Foundation
import SwiftData

import ComposableArchitecture

public enum TickerError: Error {
    case unknown
}

public struct TickerClient {
    public static let tickerRepository: TickerRepositoryInterface = TickerRepository()
    
    public var fetchTickers: @Sendable () -> Result<[Ticker], TickerError>
    public var saveTicker: @Sendable (Ticker) -> Result<Ticker, TickerError>
    public var updateTicker: @Sendable (Ticker, TickerDTO) -> Result<Ticker, TickerError>
    public var deleteTicker: @Sendable (Ticker) -> Result<Ticker, TickerError>
    
    public init(
        fetchTickers: @Sendable @escaping () -> Result<[Ticker], TickerError>,
        saveTicker: @Sendable @escaping (Ticker) -> Result<Ticker, TickerError>,
        updateTicker: @Sendable @escaping (Ticker, TickerDTO) -> Result<Ticker, TickerError>,
        deleteTicker: @Sendable @escaping (Ticker) -> Result<Ticker, TickerError>
    ) {
        self.fetchTickers = fetchTickers
        self.saveTicker = saveTicker
        self.updateTicker = updateTicker
        self.deleteTicker = deleteTicker
    }
}

extension TickerClient: TestDependencyKey {
    public static var previewValue: TickerClient = Self(
        fetchTickers: { return .failure(.unknown) },
        saveTicker: { _ in return .failure(.unknown) },
        updateTicker: { _, _ in return .failure(.unknown) },
        deleteTicker: { _ in return .failure(.unknown) }
    )
    
    public static var testValue = Self(
        fetchTickers: unimplemented("\(Self.self).fetchTickers"),
        saveTicker: unimplemented("\(Self.self).saveTicker"),
        updateTicker: unimplemented("\(Self.self).updateTicker"),
        deleteTicker: unimplemented("\(Self.self).deleteTicker")
    )
}

public extension DependencyValues {
    var tickerClient: TickerClient {
        get { self[TickerClient.self] }
        set { self[TickerClient.self] = newValue }
    }
}

extension TickerClient: DependencyKey {
    public static var liveValue = TickerClient(
        fetchTickers: { tickerRepository.fetchTickers(descriptor: .init()) },
        saveTicker: { tickerRepository.saveTicker(ticker: $0) },
        updateTicker: { tickerRepository.updateTicker(model: $0, dto: $1) },
        deleteTicker: { tickerRepository.deleteTicker(ticker: $0) }
    )
}
