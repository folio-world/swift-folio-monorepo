//
//  ChatSceneDIContainer.swift
//  MullingFeatureChatInterface
//
//  Created by 송영모 on 2023/08/22.
//

import Foundation

import MullingDomain

public final class ChatSceneDIContainer: ChatFlowCoordinatorDependencies {
    public init() {
        
    }
    
    public func makeChatFlowCoordinator() -> ChatFlowCoordinator {
        return ChatFlowCoordinator(dependencies: self)
    }
    //    func appSearchDependencies() -> AppSearchViewModel {
    //        let dataSource : AppSearchDataSourceInterface = AppSearchDataSource(networkProvider: NetworkProvider())
    //        let repository : AppSearchRepositoryInterface = AppSearchRepository(dataSource: dataSource)
    //        let useCase : AppSearchUseCaseInterface = AppSearchUseCase(searchRepository: repository, recentKeywordRepository: getRecentKeywordDependencies())
    //        let viewModel : AppSearchViewModel = AppSearchViewModel(useCase: useCase)
    //
    //        return viewModel
    //    }
    
    public func makeChatViewModel() -> ChatViewModel {
        let dependencies: ChatViewModel.Dependencies = .init()
        let chatGPTRepository: ChatGPTRepositoryInterface = ChatGPTRepository()
        return ChatViewModel(dependencies: dependencies, chatGPTRepository: chatGPTRepository)
    }
    
    public func makeChatResultViewModel(chats: [String]) -> ChatResultViewModel {
        let dependencies: ChatResultViewModel.Dependencies = .init(chats: chats)
        let chatGPTRepository: ChatGPTRepositoryInterface = ChatGPTRepository()
        return ChatResultViewModel(dependencies: dependencies, chatGPTRepository: chatGPTRepository)
    }
}
