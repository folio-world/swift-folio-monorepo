//
//  ChatNavigationViewModel.swift
//  MullingFeatureChatDemo
//
//  Created by 송영모 on 2023/08/22.
//

import SwiftUI

public protocol ChatFlowCoordinatorDependencies {
    func makeChatViewModel() -> ChatViewModel
    func makeChatResultViewModel(chats: [String]) -> ChatResultViewModel
}

public final class ChatFlowCoordinator: ObservableObject {
    public let dependencies: ChatFlowCoordinatorDependencies
    
    init(dependencies: ChatFlowCoordinatorDependencies) {
        self.dependencies = dependencies
    }
    
    public enum Scene: Hashable {
        case chatResult([String])
    }
    
    @Published public var path = NavigationPath()
    
    public func navigate(_ scene: Scene) {
        path.append(scene)
    }
    
    public func pop() {
        path.removeLast()
    }
}