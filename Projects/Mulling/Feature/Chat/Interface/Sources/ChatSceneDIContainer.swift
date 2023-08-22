//
//  ChatSceneDIContainer.swift
//  MullingFeatureChatInterface
//
//  Created by 송영모 on 2023/08/22.
//

import Foundation

public final class ChatSceneDIContainer: ChatFlowCoordinatorDependencies {
    public init() {
        
    }
    
    public func makeChatFlowCoordinator() -> ChatFlowCoordinator {
        return ChatFlowCoordinator(dependencies: self)
    }
    
    public func makeChatViewModel() -> ChatViewModel {
        let dependencies: ChatViewModel.Dependencies = .init()
        return ChatViewModel(dependencies: dependencies)
    }
    
    public func makeChatResultViewModel() -> ChatResultViewModel {
        let dependencies: ChatResultViewModel.Dependencies = .init()
        return ChatResultViewModel(dependencies: dependencies)
    }
}
