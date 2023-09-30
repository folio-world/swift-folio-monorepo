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
    
    public var fetchTickers: () -> Result<[Ticker], TickerError>
    public var saveTicker: (Ticker) -> Result<Ticker, TickerError>
    public var updateTicker: (Ticker, TickerDTO) -> Result<Ticker, TickerError>
    public var deleteTicker: (Ticker) -> Result<Ticker, TickerError>
    
    public init(
        fetchTickers: @escaping () -> Result<[Ticker], TickerError>,
        saveTicker: @escaping (Ticker) -> Result<Ticker, TickerError>,
        updateTicker: @escaping (Ticker, TickerDTO) -> Result<Ticker, TickerError>,
        deleteTicker: @escaping (Ticker) -> Result<Ticker, TickerError>
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
        saveTicker: { tickerRepository.saveTicker($0) },
        updateTicker: { tickerRepository.updateTicker($0, new: $1) },
        deleteTicker: { tickerRepository.deleteTicker($0) }
    )
}
