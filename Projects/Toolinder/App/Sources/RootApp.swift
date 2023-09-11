//
//  RootApp.swift
//  Dying
//
//  Created by 송영모 on 2023/07/19.
//  Copyright © 2023 folio.world. All rights reserved.
//

import SwiftUI
import SwiftData

import ComposableArchitecture

//import ToolinderFeature
import ToolinderDomain

@main
struct RootApp: App {
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: Ticker.self, Trade.self)
        } catch {
            fatalError("Could not initialize ModelContainer \(error)")
        }
    }
    var body: some Scene {
        WindowGroup {
            RootView(
                store: Store(initialState: RootStore.State()) {
                    RootStore()
                        ._printChanges()
                }
            )
            .onAppear(perform: UIApplication.shared.hideKeyboard)
        }
        .modelContainer(modelContainer)
    }
}
