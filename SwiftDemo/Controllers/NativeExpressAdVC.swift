//
//  NativeExpressAdVC.swift
//  SwiftDemo
//
//  Created by mirari on 2021/9/16.
//  Copyright © 2021 MobiusAd. All rights reserved.
//

import SwiftUI

class NativeExpressAdVC: BaseViewController, AdKleinSDKNativeExpressAdDelegate, UITableViewDelegate, UITableViewDataSource {
    var adLoader: AdKleinSDKNativeExpressAd?
    var dataArray:Array = Array<Any>.init()
    var tableView: UITableView?
    var adSize = CGSize.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showBtn.isHidden = true;
        
        let size = view.frame.size
        tableView = UITableView(frame: CGRect(x: 0, y: 100, width: size.width, height: size.height - 100))
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView?.backgroundColor = UIColor.clear
        view.addSubview(tableView!)
        view.sendSubviewToBack(tableView!)
    }

    override func loadClick() {
        if (adLoader == nil) {
            adSize = CGSize(width: view.frame.size.width, height: 0)

            adLoader = AdKleinSDKNativeExpressAd(placementId: Constant.NATIVE_EXPRESS_ID, viewController: self)
            adLoader?.delegate = self
            adLoader?.adSize = adSize
            adLoader?.videoMuted = false
            adLoader?.adCount = 3
        }

        adLoader?.load()
    }
        
    func ak_nativeExpressAdDidLoad(_ nativeAd: AdKleinSDKNativeExpressAd, withAdViews adViews: [UIView & AdKleinSDKNativeExpressAdViewDelegate]){
        // 将获取到的广告视图进行模板渲染
        for adView in adViews {
            adView.render()
        }
        showString(#function)
    }

    func ak_nativeExpressAdDidFail(_ nativeAd: AdKleinSDKNativeExpressAd, withError error: Error) {
        showError(error)
    }
    
    func ak_nativeExpressAdDidRenderSuccess(_ nativeAd: AdKleinSDKNativeExpressAd, adView: UIView & AdKleinSDKNativeExpressAdViewDelegate){
        // 渲染成功才能拿到真实的高度
        DispatchQueue.main.async(execute: { [self] in
            for _ in 0..<6 {
                dataArray.append(NSNull())
            }
            dataArray.append(adView)
            tableView?.reloadData()
        })
        showString(#function)
    }
    
    func ak_nativeExpressAdDidRenderFail(_ nativeAd: AdKleinSDKNativeExpressAd, adView: UIView & AdKleinSDKNativeExpressAdViewDelegate){
        showString(#function)
    }
    
    func ak_nativeExpressAdDidShow(_ nativeAd: AdKleinSDKNativeExpressAd, adView: UIView & AdKleinSDKNativeExpressAdViewDelegate){
        showString(#function)
    }
    
    func ak_nativeExpressAdDidClick(_ nativeAd: AdKleinSDKNativeExpressAd, adView: UIView & AdKleinSDKNativeExpressAdViewDelegate){
        showString(#function)
    }
    
    func ak_nativeExpressAdDidClose(_ nativeAd: AdKleinSDKNativeExpressAd, adView: UIView & AdKleinSDKNativeExpressAdViewDelegate){
        showString(#function)
    }
    
    // MARK: - tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")

        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = ""
        
        if dataArray[indexPath.row] is AdKleinSDKNativeExpressAdViewDelegate {
            let view = dataArray[indexPath.row] as! UIView
            cell.contentView.addSubview(view)
        } else {
            cell.textLabel?.text = String(format: "%ld", indexPath.row)
            cell.backgroundColor = UIColor.gray
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dataArray[indexPath.row] is AdKleinSDKNativeExpressAdViewDelegate {
            let view = dataArray[indexPath.row] as! UIView
            let height = view.frame.size.height
            print("rowHeight = \(height)")
            return height
        } else {
            return 50
        }
    }
}

