//
//  RootApp.swift
//  Dying
//
//  Created by 송영모 on 2023/07/19.
//  Copyright © 2023 folio.world. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

@main
struct RootApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(
                store: Store(initialState: RootStore.State()) {
                    RootStore()
                        ._printChanges()
                }
            )
        }
    }
}
