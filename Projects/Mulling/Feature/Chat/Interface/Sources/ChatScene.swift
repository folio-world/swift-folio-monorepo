//
//  ChatScene.swift
//  MullingFeatureChatInterface
//
//  Created by 송영모 on 2023/08/22.
//

import SwiftUI

import MullingShared

public struct ChatScene: View {
    private let chatSceneDIContainer: ChatSceneDIContainer
    
    @StateObject private var chatFlowCoordinator: ChatFlowCoordinator
    
    public init(chatSceneDIContainer: ChatSceneDIContainer) {
        self.chatSceneDIContainer = chatSceneDIContainer
        self._chatFlowCoordinator = .init(
            wrappedValue: chatSceneDIContainer.makeChatFlowCoordinator()
        )
    }
    
    public var body: some View {
        NavigationStack(path: $chatFlowCoordinator.path) {
            ChatView(viewModel: chatSceneDIContainer.makeChatViewModel(dependencies: .init()))
                .environmentObject(chatFlowCoordinator)
                .navigationDestination(for: ChatFlowCoordinator.Scene.self) { scene in
                    switch scene {
                    case let .chatResult(dependencies):
                        ChatResultView(
                            viewModel: chatSceneDIContainer.makeChatResultViewModel(dependencies: dependencies)
                        )
                        .environmentObject(chatFlowCoordinator)
                    }
                }
        }
    }
}

struct ChatScene_Previews: PreviewProvider {
    static var previews: some View {
        ChatScene(chatSceneDIContainer: .init())
    }
}
