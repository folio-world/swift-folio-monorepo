//
//  RootApp.swift
//  MullingIOS
//
//  Created by 송영모 on 2023/08/21.
//  Copyright © 2023 folio.world. All rights reserved.
//

import SwiftUI

@main
struct RootApp: App {
    let appDIContainer: AppDIContainerInterface = AppDIContainer()
    
    var body: some Scene {
        WindowGroup {
            AppSearchView(viewModel: appDIContainer.appSearchDependencies())
        }
    }
}
