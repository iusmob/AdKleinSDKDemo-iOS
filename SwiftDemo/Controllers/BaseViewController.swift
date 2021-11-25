//
//  BaseViewController.swift
//  SwiftDemo
//
//  Created by mirari on 2021/9/15.
//  Copyright © 2021 MobiusAd. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var slotIdTextField: UITextField = UITextField(frame: CGRect(x: 20, y: 100, width: Constant.ScreenWidth - 40, height: 40))
    var tipsLabel: UILabel = UILabel(frame: CGRect(x: 20, y: 160, width: Constant.ScreenWidth - 40, height: 80))
    var loadBtn: UIButton = UIButton(frame: CGRect(x: 20, y: 260, width: Constant.ScreenWidth - 40, height: 40))
    var showBtn: UIButton = UIButton(frame: CGRect(x: 20, y: 320, width: Constant.ScreenWidth - 40, height: 40))
   
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        
        slotIdTextField.backgroundColor = UIColor.white
        slotIdTextField.textColor = UIColor.black
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onChangeSlotId),
            name: UITextField.textDidChangeNotification,
            object: slotIdTextField)
        view.addSubview(slotIdTextField)
        
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
    
    @objc func onChangeSlotId(_ notification: Notification?) {
    }
    
    @objc func loadClick() {

    }
    
    @objc func showClick() {

    }
    
    func showString(_ message: String) {
        print("Demo:" + message)
        tipsLabel.text = message
    }

    func showError(_ error: Error) {
        let message = "\(error)"
        showString(message)
    }
}
