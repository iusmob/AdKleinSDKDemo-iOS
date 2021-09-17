//
//  SplashVC.swift
//  SwiftDemo
//
//  Created by mirari on 2021/9/13.
//  Copyright © 2021 MobiusAd. All rights reserved.
//

import SwiftUI

class SplashAdVC: BaseViewController, AdKleinSDKSplashAdDelegate {
    var splashAd: AdKleinSDKSplashAd?
    
    var bottomView: UIImageView?
    var skipView: UIButton?
    var isBottom = false
    var bottomLabel: UILabel?
    var customBottomSwitch: UISwitch?
    var isSkip = false
    var skipLabel: UILabel?
    var customSkipSwitch: UISwitch?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showBtn.isHidden = true;
        
        customSkipSwitch = UISwitch(frame: CGRect(x: 150, y: loadBtn.frame.origin.y + 100, width: 50, height: 40))
        customSkipSwitch?.isOn = false
        customSkipSwitch?.addTarget(self, action: #selector(self.customSkipSwitchClick(_:)), for: .touchUpInside)
        view.addSubview(customSkipSwitch!)
        skipLabel = UILabel(frame: CGRect(x: 50, y: loadBtn.frame.origin.y + 100, width: 80, height: 40))
        skipLabel?.text = "跳过按钮"
        view.addSubview(skipLabel!)
        
        customBottomSwitch = UISwitch(frame: CGRect(x: 150, y: loadBtn.frame.origin.y + 200, width: 50, height: 40))
        customBottomSwitch?.isOn = false
        customBottomSwitch?.addTarget(self, action: #selector(self.customBottomSwitchClick(_:)), for: .touchUpInside)
        view.addSubview(customBottomSwitch!)
        bottomLabel = UILabel(frame: CGRect(x: 50, y: loadBtn.frame.origin.y + 200, width: 80, height: 40))
        bottomLabel?.text = "底部View"
        view.addSubview(bottomLabel!)
    }

    override func loadClick() {
        if splashAd == nil {
            splashAd = AdKleinSDKSplashAd(placementId: Constant.SPLASH_ID, window: UIApplication.shared.keyWindow!)
            splashAd?.delegate = self
            
            if isSkip {
                //自定义跳过按钮  非必须
                skipView = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width - 80, y: UIScreen.main.bounds.size.height - 80, width: 60, height: 30))
                skipView?.addTarget(self, action: #selector(self.skipViewClick), for: .touchUpInside)
                skipView?.setTitle("跳过", for: .normal)
                skipView?.setTitleColor(UIColor.white, for: .normal)
                skipView?.layer.cornerRadius = 15.0
                skipView?.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
                skipView?.backgroundColor = UIColor.black.withAlphaComponent(0.7)
                splashAd?.skipView = skipView
            }
            if isBottom {
                //自定义底部view  非必须
                bottomView = UIImageView(frame: CGRect(x: 0, y: 0, width: Constant.ScreenWidth, height: Constant.ScreenHeight * 0.25))
                bottomView?.image = UIImage(named: "bottom")
                bottomView?.contentMode = .scaleAspectFill
                splashAd?.bottomView = bottomView
            }
        }
        splashAd?.load()
    }
    
    @objc func skipViewClick() {
        splashAd?.remove()
    }
    
    @objc func customSkipSwitchClick(_ sw: UISwitch?) {
        if sw?.isOn ?? false {
            isSkip = true
        } else {
            isSkip = false
        }
    }

    @objc func customBottomSwitchClick(_ sw: UISwitch?) {
        if sw?.isOn ?? false {
            isBottom = true
        } else {
            isBottom = false
        }
    }
    
    func ak_splashAdDidLoad(_ splashAd: AdKleinSDKSplashAd) {
        showString(#function)
    }

    func ak_splashAdDidFail(_ splashAd: AdKleinSDKSplashAd, withError error: Error) {
        showError(error)
    }
    
    func ak_splashAdDidShow(_ splashAd: AdKleinSDKSplashAd) {
        showString(#function)
    }
    
    func ak_splashAdDidClick(_ splashAd: AdKleinSDKSplashAd) {
        showString(#function)
    }

    func ak_splashAdDidClose(_ splashAd: AdKleinSDKSplashAd) {
        showString(#function)
    }
}
