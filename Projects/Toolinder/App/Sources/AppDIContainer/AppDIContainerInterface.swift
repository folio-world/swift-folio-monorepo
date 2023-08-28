//
//  AppDIContainerInterface.swift
//  MullingIOS
//
//  Created by 송영모 on 2023/08/21.
//  Copyright © 2023 folio.world. All rights reserved.
//

import Foundation
import MullingFeature

protocol AppDIContainerInterface {
    func makeChatSceneDIContainer() -> ChatSceneDIContainer
}
