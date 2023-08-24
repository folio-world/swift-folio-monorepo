//
//  RootApp.swift
//  MullingIOS
//
//  Created by 송영모 on 2023/08/21.
//  Copyright © 2023 folio.world. All rights reserved.
//

import SwiftUI
import AppTrackingTransparency

import MullingFeature

@main
struct RootApp: App {
    @UIApplicationDelegateAdaptor var delegate: AppDelegate
    let appDIContainer: AppDIContainerInterface = AppDIContainer()
    
    init() {
        
    }
    
    var body: some Scene {
        WindowGroup {
            ChatScene(chatSceneDIContainer: appDIContainer.makeChatSceneDIContainer())
                .onAppear(perform : UIApplication.shared.hideKeyboard)
        }
    }
}
