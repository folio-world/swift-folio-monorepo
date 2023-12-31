//
//  Rewarded.swift
//  MullingSharedUtil
//
//  Created by 송영모 on 2023/08/24.
//
import SwiftUI

import GoogleMobileAds

public final class Rewarded: NSObject {
    let rewardedId: String
    var rewardedAd: GADRewardedAd?
    
    var rewarded: ((GADAdReward) -> Void)?
    
    public init(id: String) {
        self.rewardedId = id
        super.init()
        load()
    }
    
    private func load(){
        let request = GADRequest()
        GADRewardedAd.load(
            withAdUnitID: rewardedId,
            request: request,
            completionHandler: { [self] ad, error in
                if let error = error {
                    print("Failed to load rewarded ad with error: \(error.localizedDescription)")
                    return
                }
                rewardedAd = ad
                print("Rewarded ad loaded.")
            }
        )
    }
    
    public func show(rewarded: @escaping (GADAdReward) -> Void){
        self.rewarded = rewarded
        
        if let ad = rewardedAd,
           let root = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController {
            ad.present(fromRootViewController: root) {
                let reward = ad.adReward
                self.rewarded?(reward)
                print("Reward received with currency \(reward.amount), amount \(reward.amount.doubleValue)")
            }
        } else {
            print("Ad wasn't ready")
        }
    }
}
