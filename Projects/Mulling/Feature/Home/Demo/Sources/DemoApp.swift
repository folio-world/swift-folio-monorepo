//
//  DemoApp.swift
//  DyingFeatureHomeDemo
//
//  Created by 송영모 on 2023/08/03.
//

import SwiftUI

@main
struct RootApp: App {
    var body: some Scene {
        WindowGroup {
            HomeNavigationStackView(store: Store(initialState: HomeNavigationStackStore.State()) {
                HomeNavigationStackStore()._printChanges()
            })
        }
    }
}
