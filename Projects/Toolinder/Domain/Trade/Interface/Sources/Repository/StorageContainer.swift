//
//  StorageRepository.swift
//  ToolinderDomainTradeInterface
//
//  Created by 송영모 on 2023/09/26.
//

import Foundation
import SwiftData

public class StorageContainer {
    public static let shared = StorageContainer()
    
    private var container: ModelContainer?
    public var context: ModelContext?
    
    private init() {
        do {
            container = try ModelContainer(for: Ticker.self, Trade.self, Tag.self)
            if let container {
                context = ModelContext(container)
            }
        } catch {
            print(error)
        }
    }
}
