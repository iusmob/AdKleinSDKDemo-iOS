//
//  NativeAdVC.swift
//  SwiftDemo
//
//  Created by mirari on 2021/9/16.
//  Copyright © 2021 MobiusAd. All rights reserved.
//

import SwiftUI

class NativeAdVC: BaseViewController, AdKleinSDKNativeAdDelegate {
    var adLoader: AdKleinSDKNativeAd?
    
    var scrollView: UIScrollView?
    var adY: CGFloat = 0.0
    var adViews: [UIView & AdKleinSDKNativeAdViewDelegate] = []
    var removeBtn: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showBtn.isHidden = true;
        
        removeBtn = UIButton(frame: CGRect(x: 50, y: 300, width: Constant.ScreenWidth - 100, height: 50))
        removeBtn?.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.3)
        removeBtn?.setTitle("remove", for: .normal)
        removeBtn?.addTarget(self, action: #selector(self.removeClick), for: .touchUpInside)
        view.addSubview(removeBtn!)
        
        adY = 50
        adViews = []
        let size = view.frame.size
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 100, width: size.width, height: size.height - 100))
        view.addSubview(scrollView!)
        view.sendSubviewToBack(scrollView!)
    }

    override func loadClick() {
        if (adLoader == nil) {
            adLoader = AdKleinSDKNativeAd(placementId: Constant.NATIVE_ID, viewController: self)
            adLoader?.delegate = self
            adLoader?.adCount = 3
        }
        adLoader?.load()
    }
    
    @objc func removeClick() {
        for adView in adViews {
            adView.ak_unRegistView()
            adView.removeFromSuperview()
        }
        adViews = []
        adY = 50
    }
        
    func ak_nativeAdDidLoad(_ nativeAd: AdKleinSDKNativeAd, withAdViews adViews: [UIView & AdKleinSDKNativeAdViewDelegate]){
        // 将获取到的广告视图进行模板渲染
        for adView in adViews {
            self.adViews.append(adView)
            
            let width = Constant.ScreenWidth
            let height: CGFloat = 300
            adView.frame = CGRect(x: 0, y: adY, width: width, height: height)
            adView.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.9, alpha: 0.3)
            scrollView?.addSubview(adView)
            adY += height + 20
            scrollView?.contentSize = CGSize(width: width, height: adY + 100)
            
            let nativeAdData = adView.data
            let title = UILabel(frame: CGRect(x: 15, y: 0, width: width - 30, height: 20))
            title.text = nativeAdData.title
            adView.addSubview(title)

            let desc = UILabel(frame: CGRect(x: 15, y: 30, width: width - 30, height: 40))
            desc.text = nativeAdData.desc
            adView.addSubview(desc)
            
            // 展示关闭按钮
            let closeButton = UIButton()
            adView.addSubview(closeButton)
            adView.bringSubviewToFront(closeButton)
            closeButton.frame = CGRect(x: width - 80, y: 0, width: 80, height: 44)
            closeButton.setTitle("remove", for: .normal)
            closeButton.addTarget(adView, action: #selector(AdKleinSDKNativeAdViewDelegate.ak_close), for: .touchUpInside)

            print("AdKleinSDKDemo: NativeAd Mode = \(nativeAdData.imageMode)")
            
            switch nativeAdData.imageMode {
            case AK_NATIVE_AD_TYPE.LARGE_IMAGE:
                let single = UIImageView(frame: CGRect(x: 15, y: 70, width: width - 30, height: 200))
                adView.addSubview(single)
                
                let url : URL = URL.init(string: nativeAdData.images![0])!
                let data : NSData! = NSData(contentsOf: url)
                if data != nil {
                    single.image = UIImage(data: data as Data)
                }

                adView.ak_registViews([title, desc, single])
                break
            case AK_NATIVE_AD_TYPE.SMALL_IMAGE:
                let single = UIImageView(frame: CGRect(x: 15, y: 70, width: width - 30, height: 200))
                adView.addSubview(single)
                
                let url = URL.init(string: nativeAdData.images![0])!
                let data = NSData(contentsOf: url)
                if data != nil {
                    single.image = UIImage(data: data! as Data)
                }

                adView.ak_registViews([title, desc, single])
                break
            case AK_NATIVE_AD_TYPE.THREE_SMALL:
                let imageWidth: CGFloat = (width - 16) / 3
                let imageRate: CGFloat = 228 / 150.0 // 三小图默认比例
                let imageView0 = UIImageView(frame: CGRect(x: 8, y: 84, width: imageWidth, height: imageWidth / imageRate))
                let imageView1 = UIImageView(frame: CGRect(x: 16 + imageWidth, y: 84, width: imageWidth, height: imageWidth / imageRate))
                let imageView2 = UIImageView(frame: CGRect(x: 24 + imageWidth * 2, y: 84, width: imageWidth, height: imageWidth / imageRate))
                
                let url0 = URL.init(string: nativeAdData.images![0])!
                let data0 = NSData(contentsOf: url0)
                if data0 != nil {
                    imageView0.image = UIImage(data: data0! as Data)
                }
                let url1 = URL.init(string: nativeAdData.images![1])!
                let data1 = NSData(contentsOf: url1)
                if data1 != nil {
                    imageView1.image = UIImage(data: data1! as Data)
                }
                let url2 = URL.init(string: nativeAdData.images![2])!
                let data2 = NSData(contentsOf: url2)
                if data2 != nil {
                    imageView2.image = UIImage(data: data2! as Data)
                }
                
                adView.ak_registViews([title, desc, imageView0, imageView1, imageView2])
                break
            case AK_NATIVE_AD_TYPE.VIDEO:
                let video = adView.mediaView
                video.frame = CGRect(x: 15, y: 70, width: width - 30, height: 200)
                adView.addSubview(video)
                adView.ak_registViews([title, desc, video])
                break
            default:
                break
            }
        }
        showString(#function)
    }

    func ak_nativeAdDidFail(_ nativeAd: AdKleinSDKNativeAd, withError error: Error) {
        showError(error)
    }
    
    func ak_nativeAdDidShow(_ nativeAd: AdKleinSDKNativeAd, adView: UIView & AdKleinSDKNativeAdViewDelegate){
        showString(#function)
    }
    
    func ak_nativeAdDidClick(_ nativeAd: AdKleinSDKNativeAd, adView: UIView & AdKleinSDKNativeAdViewDelegate){
        showString(#function)
    }
    
    func ak_nativeAdDidClose(_ nativeAd: AdKleinSDKNativeAd, adView: UIView & AdKleinSDKNativeAdViewDelegate){
        adViews.removeAll{$0 == adView}
        showString(#function)
    }
}

