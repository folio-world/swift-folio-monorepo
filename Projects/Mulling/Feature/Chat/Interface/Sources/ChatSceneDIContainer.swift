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
        return ChatViewModel()
    }
    
    public func makeChatResultViewModel() -> ChatResultViewModel {
        return ChatResultViewModel()
    }
}
