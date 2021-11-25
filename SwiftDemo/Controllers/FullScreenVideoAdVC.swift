//
//  FullScreenVideoAdVC.swift
//  SwiftDemo
//
//  Created by mirari on 2021/9/16.
//  Copyright © 2021 MobiusAd. All rights reserved.
//

import SwiftUI

class FullScreenVideoAdVC: BaseViewController, AdKleinSDKFullScreenVideoAdDelegate {
    var adLoader: AdKleinSDKFullScreenVideoAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slotIdTextField.text = Constant.FULLSCREEN_ID;
    }

    override func loadClick() {
        adLoader = AdKleinSDKFullScreenVideoAd(placementId: slotIdTextField.text!, viewController: self)
        adLoader?.delegate = self
        adLoader?.detailPageVideoMuted = true
        adLoader?.videoAutoPlayOnWWAN = true
        adLoader?.minVideoDuration = 5
        adLoader?.maxVideoDuration = 100 * 1000
        adLoader?.load()
    }
    
    override func showClick() {
        adLoader?.show()
    }
            
    func ak_fullScreenVideoAdDidLoad(_ fullScreenVideoAd: AdKleinSDKFullScreenVideoAd) {
        showString(#function)
    }

    func ak_fullScreenVideoAdDidFail(_ fullScreenVideoAd: AdKleinSDKFullScreenVideoAd, withError error: Error) {
        showError(error)
    }
    
    func ak_fullScreenVideoAdDidDownload(_ fullScreenVideoAd: AdKleinSDKFullScreenVideoAd) {
        showString(#function)
        adLoader?.show()
    }
    
    func ak_fullScreenVideoAdDidRenderSuccess(_ fullScreenVideoAd: AdKleinSDKFullScreenVideoAd) {
        showString(#function)
    }
    
    func ak_fullScreenVideoAdDidRenderFail(_ fullScreenVideoAd: AdKleinSDKFullScreenVideoAd, withError error: Error) {
        showError(error)
    }
    
    func ak_fullScreenVideoAdDidShow(_ fullScreenVideoAd: AdKleinSDKFullScreenVideoAd) {
        showString(#function)
    }
    
    func ak_fullScreenVideoAdDidClick(_ fullScreenVideoAd: AdKleinSDKFullScreenVideoAd) {
        showString(#function)
    }

    func ak_fullScreenVideoAdDidClose(_ fullScreenVideoAd: AdKleinSDKFullScreenVideoAd) {
        showString(#function)
    }
        
    func ak_fullScreenVideoAdDidComplete(_ fullScreenVideoAd: AdKleinSDKFullScreenVideoAd) {
        showString(#function)
    }
    
    func ak_fullScreenVideoAdDidSkip(_ fullScreenVideoAd: AdKleinSDKFullScreenVideoAd) {
        showString(#function)
    }
}
