//
//  BaseViewController.swift
//  SwiftDemo
//
//  Created by mirari on 2021/9/15.
//  Copyright © 2021 MobiusAd. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var tipsLabel: UILabel = UILabel(frame: CGRect(x: 50, y: 100, width: Constant.ScreenWidth - 100, height: 80))
    var loadBtn: UIButton = UIButton(frame: CGRect(x: 50, y: 200, width: Constant.ScreenWidth - 100, height: 50))
    var showBtn: UIButton = UIButton(frame: CGRect(x: 50, y: 300, width: Constant.ScreenWidth - 100, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        
        tipsLabel.numberOfLines = 3
        tipsLabel.font = UIFont.systemFont(ofSize: 15)
        tipsLabel.textAlignment = .center
        view.addSubview(tipsLabel)
        
        loadBtn.setTitle("load", for: .normal)
        loadBtn.addTarget(self, action: #selector(self.loadClick), for: .touchUpInside)
        loadBtn.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.3)
        view.addSubview(loadBtn)
        
        showBtn.setTitle("show", for: .normal)
        showBtn.addTarget(self, action: #selector(self.showClick), for: .touchUpInside)
        showBtn.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.3)
        view.addSubview(showBtn)
    }
    
    @objc func loadClick() {

    }
    
    @objc func showClick() {

    }
    
    func showString(_ message: String) {
        print(message)
        tipsLabel.text = message
    }

    func showError(_ error: Error) {
        let message = "\(error)"
        showString(message)
    }
}
