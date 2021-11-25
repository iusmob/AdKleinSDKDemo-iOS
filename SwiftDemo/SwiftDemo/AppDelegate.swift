//
//  AppDelegate.swift
//  SwiftDemo
//
//  Created by Grand on 2020/10/12.
//  Copyright © 2020 MobiusAd. All rights reserved.
//

import UIKit
#if canImport(AppTrackingTransparency)
    import AppTrackingTransparency
#endif
import AdSupport
import Bugly

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AdKleinSDKSplashAdDelegate {

    var window: UIWindow?
    var splashAd: AdKleinSDKSplashAd?
    var placeholderView: UIView?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let nav = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = nav
        window?.makeKeyAndVisible()

        createPlaceholder()
        initSDK()
        return true
    }
        
    func initSDK() {
        initBugly()

        let userDefault = UserDefaults.standard
        if userDefault.object(forKey: "inited") as? String == "YES" {
            initAdKleinSDK()
        } else {
            showPrivacyAlert()
        }
    }
    
    func initBugly() {
        let config = BuglyConfig()
        config.unexpectedTerminatingDetectionEnable = true //非正常退出事件记录开关，默认关闭
        config.reportLogLevel = BuglyLogLevel.warn //报告级别
        config.blockMonitorEnable = true //开启卡顿监控
        config.blockMonitorTimeout = 5 //卡顿监控判断间隔，单位为秒
        Bugly.start(withAppId: "b393fcad77")
    }
    
    func showPrivacyAlert() {
        let alert = PrivacyAlert()
        alert.show(onComplete: { [self] result in
            if result {
                let userDefault = UserDefaults.standard
                userDefault.set("YES", forKey: "inited")
                userDefault.synchronize()
                if #available(iOS 14.0, *) {
                    ATTrackingManager.requestTrackingAuthorization(completionHandler: { [unowned self] status in
                        DispatchQueue.main.async(execute: { [unowned self] in
                            initAdKleinSDK()
                        })
                    })
                } else {
                    initAdKleinSDK()
                }
            } else {
                UIView.animate(withDuration: 0.5, animations: { [unowned self] in
                    window?.alpha = 0
                    window?.frame = CGRect(x: 0, y: Constant.ScreenHeight / 2, width: Constant.ScreenWidth, height: 0.5)
                }) { finished in
                    exit(0)
                }
            }
        })
    }
    
    func initAdKleinSDK() {
        AdKleinSDKConfig.debugMode()
//        AdKleinSDKConfig.initMediaId(Constant.MEDIA_ID)
        AdKleinSDKConfig.initMediaId(Constant.MEDIA_ID, onComplete: { error in
            if error != nil {
                print("SDK 初始化失败")
            } else {
                print("SDK 初始化成功")
            }
        })
        loadSplashAd()
        //SDK版本号，如：3.0.0
        print(AdKleinSDKConfig.sdkVersion())
        //SDK数字版本号，如：30001
        print(AdKleinSDKConfig.sdkVersionCode())
    }

    func loadSplashAd() {        
        if (splashAd == nil) {
            splashAd = AdKleinSDKSplashAd(placementId: Constant.SPLASH_ID, window: window!)
            splashAd?.delegate = self
        }
        splashAd?.load()
    }
    
    func createPlaceholder() {
        let lsname = Bundle.main.infoDictionary?["UILaunchStoryboardName"] as! String
        let vc = UIStoryboard(name: lsname, bundle: nil).instantiateInitialViewController()
        vc?.view.frame = window!.bounds
        if let view = vc?.view {
            window?.addSubview(view)
        }
        placeholderView = vc?.view
    }
    
    func removePlaceholder() {
        if (placeholderView != nil) {
            placeholderView?.removeFromSuperview()
        }
    }
    
    // MARK: - AdKleinSDKSplashAdDelegate
    func ak_splashAdDidLoad(_ splashAd: AdKleinSDKSplashAd) {
    }

    func ak_splashAdDidFail(_ splashAd: AdKleinSDKSplashAd, withError error: Error) {
        self.removePlaceholder()
    }
    
    func ak_splashAdDidShow(_ splashAd: AdKleinSDKSplashAd) {
        self.removePlaceholder()
    }
    
    func ak_splashAdDidClick(_ splashAd: AdKleinSDKSplashAd) {
    }

    func ak_splashAdDidClose(_ splashAd: AdKleinSDKSplashAd) {
    }
}

