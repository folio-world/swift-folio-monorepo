//
//  ChatSceneDIContainer.swift
//  MullingFeatureChatInterface
//
//  Created by 송영모 on 2023/08/22.
//

import Foundation

import MullingDomain
import MullingCore

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
    
    public func makeChatViewModel(dependencies: ChatViewModel.Dependencies) -> ChatViewModel {
        let openAIRepository: OPENAIRepositoryInterface = OPENAIRepository()
        let chatUseCase: ChatUseCaseInterface = ChatUseCase(openAIRepository: openAIRepository)
        
        return .init(
            dependencies: dependencies,
            chatUseCase: chatUseCase
        )
    }
    
    public func makeChatResultViewModel(
        dependencies: ChatResultViewModel.Dependencies
    ) -> ChatResultViewModel {
        let openAIRepository: OPENAIRepositoryInterface = OPENAIRepository()
        let chatUseCase: ChatUseCaseInterface = ChatUseCase(openAIRepository: openAIRepository)
        
        return .init(
            dependencies: dependencies,
            chatUseCase: chatUseCase
        )
    }
}
