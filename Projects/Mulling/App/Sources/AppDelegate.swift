//
//  AppDelegate.swift
//  MullingIOS
//
//  Created by 송영모 on 2023/08/24.
//  Copyright © 2023 folio.world. All rights reserved.
//

import UIKit

import GoogleMobileAds

import AppTrackingTransparency

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("hello")
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        if ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
        
        } else {
            ATTrackingManager.requestTrackingAuthorization { status in
                print("ddd")
                
            }
        }


      return true
    }
}
