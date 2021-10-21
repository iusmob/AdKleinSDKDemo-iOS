//
//  BannerVC.swift
//  SwiftDemo
//
//  Created by mirari on 2021/9/16.
//  Copyright © 2021 MobiusAd. All rights reserved.
//

import SwiftUI

class BannerAdVC: BaseViewController, AdKleinSDKBannerAdViewDelegate {
    var adView: AdKleinSDKBannerAdView?
    var removeBtn: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slotIdTextField.text = Constant.BANNER_ID;
        
        showBtn.isHidden = true;
        
        removeBtn = UIButton(frame: CGRect(x: 20, y: 320, width: Constant.ScreenWidth - 40, height: 40))
        removeBtn?.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.3)
        removeBtn?.setTitle("remove", for: .normal)
        removeBtn?.addTarget(self, action: #selector(self.removeClick), for: .touchUpInside)
        view.addSubview(removeBtn!)

    }

    override func loadClick() {
        if (adView != nil) {
            adView?.removeFromSuperview()
            adView = nil
        }
        adView = AdKleinSDKBannerAdView(placementId: slotIdTextField.text!, viewController: self)
        adView?.delegate = self
        adView?.frame = CGRect(x: 0, y: 400, width: Constant.ScreenWidth, height: Constant.ScreenWidth / 2)
//        adView?.animated = true
//        adView?.autoSwitchInterval = 60
        view.addSubview(adView!)
        adView?.load()
    }
    
    @objc func removeClick() {
        if (adView != nil) {
            adView?.removeFromSuperview()
            adView = nil
        }
    }
        
    func ak_bannerAdDidLoad(_ bannerAd: AdKleinSDKBannerAdView) {
        showString(#function)
    }

    func ak_bannerAdDidFail(_ bannerAd: AdKleinSDKBannerAdView, withError error: Error) {
        showError(error)
    }
    
    func ak_bannerAdDidShow(_ bannerAd: AdKleinSDKBannerAdView) {
        showString(#function)
    }
    
    func ak_bannerAdDidClick(_ bannerAd: AdKleinSDKBannerAdView) {
        showString(#function)
    }

    func ak_bannerAdDidClose(_ bannerAd: AdKleinSDKBannerAdView) {
        showString(#function)
    }
}

