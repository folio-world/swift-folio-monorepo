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
//if ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
//
//} else {
//    ATTrackingManager.requestTrackingAuthorization { status in
//        AdmobManager.shared.start()
//    }
//}
@main
struct RootApp: App {
    @UIApplicationDelegateAdaptor var delegate: AppDelegate
    let appDIContainer: AppDIContainerInterface = AppDIContainer()
    
    init() {
        
    }
    
    var body: some Scene {
        WindowGroup {
            ChatScene(chatSceneDIContainer: appDIContainer.makeChatSceneDIContainer())
        }
    }
}
