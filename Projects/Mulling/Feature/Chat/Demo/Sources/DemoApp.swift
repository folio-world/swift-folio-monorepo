//
//  DemoApp.swift
//  DyingFeatureHomeDemo
//
//  Created by 송영모 on 2023/08/03.
//

import SwiftUI

import MullingFeatureChatInterface

@main
struct RootApp: App {
    var body: some Scene {
        WindowGroup {
            ChatView(viewModel: .init(wrappedValue: .init()))
        }
    }
}
