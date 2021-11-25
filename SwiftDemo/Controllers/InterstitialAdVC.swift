//
//  InterstitialVC.swift
//  SwiftDemo
//
//  Created by mirari on 2021/9/16.
//  Copyright © 2021 MobiusAd. All rights reserved.
//

import SwiftUI

class InterstitialAdVC: BaseViewController, AdKleinSDKInterstitialAdDelegate {
    var adLoader: AdKleinSDKInterstitialAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slotIdTextField.text = Constant.INTERSTITIAL_ID;
        
        showBtn.isHidden = true;
    }

    override func loadClick() {
        adLoader = AdKleinSDKInterstitialAd(placementId: slotIdTextField.text!, viewController: self)
        adLoader?.delegate = self
        adLoader?.adSize = CGSize(width: 300, height: 400)
        adLoader?.load()
    }
        
    func ak_interstitialAdDidLoad(_ interstitialAd: AdKleinSDKInterstitialAd) {
        showString(#function)
    }

    func ak_interstitialAdDidFail(_ interstitialAd: AdKleinSDKInterstitialAd, withError error: Error) {
        showError(error)
    }
    
    func ak_interstitialAdDidDownload(_ interstitialAd: AdKleinSDKInterstitialAd) {
        showString(#function)
        adLoader?.show()
    }
    
    func ak_interstitialAdDidRenderSuccess(_ interstitialAd: AdKleinSDKInterstitialAd) {
        showString(#function)
    }
    
    func ak_interstitialAdDidRenderFail(_ interstitialAd: AdKleinSDKInterstitialAd, withError error: Error) {
        showError(error)
    }
    
    func ak_interstitialAdDidShow(_ interstitialAd: AdKleinSDKInterstitialAd) {
        showString(#function)
    }
    
    func ak_interstitialAdDidClick(_ interstitialAd: AdKleinSDKInterstitialAd) {
        showString(#function)
    }

    func ak_interstitialAdDidClose(_ interstitialAd: AdKleinSDKInterstitialAd) {
        showString(#function)
    }
}
