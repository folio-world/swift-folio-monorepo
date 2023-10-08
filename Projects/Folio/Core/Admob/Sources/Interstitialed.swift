//
//  Interstitialed.swift
//  FolioCoreAdmob
//
//  Created by 송영모 on 10/8/23.
//

import SwiftUI

import GoogleMobileAds

public final class Interstitialed: NSObject {
    let id: String
    var interstitialAd: GADInterstitialAd?
    
    var interstitialed: (() -> Void)?
    
    public init(id: String) {
        self.id = id
        super.init()
        load()
    }
    
    private func load(){
        let request = GADRequest()
        GADInterstitialAd.load(
            withAdUnitID: id,
            request: request,
            completionHandler: { [weak self] ad, errorOrNil in
                if let error = errorOrNil {
                    print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                    return
                }
                
                self?.interstitialAd = ad
            }
        )
    }
    
    public func show(interstitialed: @escaping () -> Void) {
        if let ad = interstitialAd,
           let root = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController {
            ad.present(fromRootViewController: root)
            interstitialed()
        } else {
            print("Ad wasn't ready")
            interstitialed()
        }
    }
}
