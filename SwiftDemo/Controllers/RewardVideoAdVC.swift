//
//  RewardVideoAdVC.swift
//  SwiftDemo
//
//  Created by mirari on 2021/9/16.
//  Copyright © 2021 MobiusAd. All rights reserved.
//

import SwiftUI

class RewardVideoAdVC: BaseViewController, AdKleinSDKRewardVideoAdDelegate {
    var adLoader: AdKleinSDKRewardVideoAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadClick() {
        adLoader = AdKleinSDKRewardVideoAd(placementId: Constant.REWARD_VIDEO_ID, viewController: self)
        adLoader?.delegate = self
        adLoader?.load()
    }
    
    override func showClick() {
        adLoader?.show()
    }
            
    func ak_rewardVideoAdDidLoad(_ rewardVideoAd: AdKleinSDKRewardVideoAd) {
        showString(#function)
        adLoader?.show()
    }

    func ak_rewardVideoAdDidFail(_ rewardVideoAd: AdKleinSDKRewardVideoAd, withError error: Error) {
        showError(error)
    }
    
    func ak_rewardVideoAdDidDownload(_ rewardVideoAd: AdKleinSDKRewardVideoAd) {
        showString(#function)
        adLoader?.show()
    }
    
    func ak_rewardVideoAdDidRenderFail(_ rewardVideoAd: AdKleinSDKRewardVideoAd, withError error: Error) {
        showError(error)
    }
    
    func ak_rewardVideoAdDidShow(_ rewardVideoAd: AdKleinSDKRewardVideoAd) {
        showString(#function)
    }
    
    func ak_rewardVideoAdDidClick(_ rewardVideoAd: AdKleinSDKRewardVideoAd) {
        showString(#function)
    }

    func ak_rewardVideoAdDidClose(_ rewardVideoAd: AdKleinSDKRewardVideoAd) {
        showString(#function)
    }
    
    func ak_rewardVideoAdDidRewardEffective(_ rewardVideoAd: AdKleinSDKRewardVideoAd) {
        showString(#function)
    }
    
    func ak_rewardVideoAdDidComplete(_ rewardVideoAd: AdKleinSDKRewardVideoAd) {
        showString(#function)
    }
    
    func ak_rewardVideoAdDidSkip(_ rewardVideoAd: AdKleinSDKRewardVideoAd) {
        showString(#function)
    }
}
