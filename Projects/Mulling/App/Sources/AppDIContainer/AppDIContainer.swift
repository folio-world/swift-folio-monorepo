//
//  AppDIContainer.swift
//  MullingIOS
//
//  Created by 송영모 on 2023/08/21.
//  Copyright © 2023 folio.world. All rights reserved.
//

import Foundation


final class AppDIContainer: AppDIContainerInterface {
    func 
    func appSearchDependencies() -> AppSearchViewModel {
        let dataSource : AppSearchDataSourceInterface = AppSearchDataSource(networkProvider: NetworkProvider())
        let repository : AppSearchRepositoryInterface = AppSearchRepository(dataSource: dataSource)
        let useCase : AppSearchUseCaseInterface = AppSearchUseCase(searchRepository: repository, recentKeywordRepository: getRecentKeywordDependencies())
        let viewModel : AppSearchViewModel = AppSearchViewModel(useCase: useCase)
        
        return viewModel
    }
    
    private func getRecentKeywordDependencies() -> RecentKeywordRepositoryInterface {
        let recentKeywordStorage: RecentKeywordStorageInterface = RecentKeywordStorage()
        let recentKeywordRepository: RecentKeywordRepositoryInterface = RecentKeywordRepository(recentKeywordStorage: recentKeywordStorage)
        
        return recentKeywordRepository
    }
}
