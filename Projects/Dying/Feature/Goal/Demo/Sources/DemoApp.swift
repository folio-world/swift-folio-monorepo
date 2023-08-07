//
//  DemoApp.swift
//  DyingFeatureGoalDemo
//
//  Created by 송영모 on 2023/08/03.
//

import SwiftUI

import ComposableArchitecture

import DyingFeatureGoalInterface

@main
struct RootApp: App {
    var body: some Scene {
        WindowGroup {
            GoalNavigationStackView(
                store: Store(initialState: GoalNavigationStackStore.State()) {
                    GoalNavigationStackStore()._printChanges()
                }
            )
        }
    }
}
