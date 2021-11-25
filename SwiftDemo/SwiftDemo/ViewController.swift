//
//  ViewController.swift
//  SwiftDemo
//
//  Created by Grand on 2020/10/12.
//  Copyright © 2020 MobiusAd. All rights reserved.
//

import UIKit

//class ViewController: UINavigationController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        self.view.backgroundColor = UIColor(red: 0.6, green: 0.1, blue: 0.6, alpha: 1)
////        viewControllers = [AllViewController()]
////        self.setViewControllers([SplashVC()], animated: true)
//        self.navigationController?.pushViewController(SplashVC(), animated: true)
//    }
//}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    private var table : UITableView!
    
    private var demoArray: Array<String> = [
        "开屏(SplashAd)",
        "插屏(InterstitialAd)",
        "横幅(BannerAd)",
        "信息流-模版(NativeExpressAd)",
        "信息流-自渲染(NativeAd)",
        "激励视频(RewardVideoAd)",
        "全屏视频(FullScreenVideoAd)",
    ]
    
    private let reusableTableViewCellID = "DemoTableIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "AdKleinSDK Swift Demo"
        initTableView()
    }
    
    private func initTableView() {
        table = UITableView(frame: self.view.bounds)
        table.frame.origin.y = 44
        self.view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
//        table.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        
        let viewConstraints:[NSLayoutConstraint] = [
            NSLayoutConstraint.init(item: table!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: table!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: table!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: table!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0)]
        self.view.addConstraints(viewConstraints)
        
        table.delegate = self
        table.dataSource = self
        table.reloadData()
    }
    
    //    MARK:UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: reusableTableViewCellID)
        cell.textLabel?.text = self.demoArray[indexPath.row]
//        cell.backgroundColor = UIColor.orange
//        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    //    MARK:UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let vc:UIViewController?
        
        switch indexPath.row {
        case 0:
            vc = SplashAdVC()
        case 1:
            vc = InterstitialAdVC()
        case 2:
            vc = BannerAdVC()
        case 3:
            vc = NativeExpressAdVC()
        case 4:
            vc = NativeAdVC()
        case 5:
            vc = RewardVideoAdVC()
        case 6:
            vc = FullScreenVideoAdVC()
        default:
            vc = nil
        }
        
        vc?.title = demoArray[indexPath.row]
        if let vc = vc {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func getIDFA() {
        let idfa = ""
        let alertController = UIAlertController(title: nil,
                                                message: "\(idfa) \n已经复制到你的粘贴板", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}


