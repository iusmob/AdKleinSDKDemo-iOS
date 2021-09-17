//
//  PrivacyAlert.swift
//  SwiftDemo
//
//  Created by mirari on 2021/9/17.
//  Copyright © 2021 MobiusAd. All rights reserved.
//

extension UIControl {
    @objc public func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping()->()) {
        if #available(iOS 14.0, *) {
            addAction(UIAction { (action: UIAction) in closure() }, for: controlEvents)
        } else {
            @objc class ClosureSleeve: NSObject {
                let closure:()->()
                init(_ closure: @escaping()->()) { self.closure = closure }
                @objc func invoke() { closure() }
            }
            let sleeve = ClosureSleeve(closure)
            addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
            objc_setAssociatedObject(self, "\(UUID())", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}


func RGBA(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
    UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

class PrivacyAlert: UIView, UITextViewDelegate {
    private var backgroundView: UIView?
    private var titleLabel: UILabel?
    private var textView: UITextView?
    private var cancelBtn: UIButton?
    private var bottomBtn: UIButton?
    
    func show(onComplete completion: @escaping (_ result: Bool) -> Void) {
        isHidden = false
        
        let keyWindow = UIApplication.shared.keyWindow
        keyWindow?.addSubview(self)

        frame = CGRect(x: 0, y: 0, width: Constant.ScreenWidth, height: Constant.ScreenHeight)
        backgroundColor = RGBA(0, 0, 0, 0.5)

        backgroundView = UIView(frame: CGRect(x: Constant.ScreenWidth * 0.2 / 2, y: Constant.ScreenHeight * 0.5 / 2, width: Constant.ScreenWidth * 0.8, height: Constant.ScreenHeight * 0.5))
        backgroundView?.backgroundColor = UIColor.white
        backgroundView?.layer.masksToBounds = true
        backgroundView?.layer.cornerRadius = 15.0
        addSubview(backgroundView!)
        
        let modalWidth = backgroundView?.frame.size.width
        let modalHeight = backgroundView?.frame.size.height
        
        titleLabel = UILabel(frame: CGRect(x: 20, y: 10, width: modalWidth! - 40, height: 40))
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel?.textAlignment = .center
        titleLabel?.textColor = RGBA(73, 71, 102, 1)
        titleLabel?.text = "隐私权政策"
        backgroundView?.addSubview(titleLabel!)
        
        textView = UITextView(frame: CGRect(x: 20, y: 50, width: modalWidth! - 40, height: modalHeight! - 190))
        textView?.text = ""
//        textView?.font = UIFont.systemFont(ofSize: 18)
        textView?.textAlignment = .left
        textView?.textColor = RGBA(73, 71, 102, 1)
        textView?.keyboardType = .default
        textView?.backgroundColor = UIColor.clear
        textView?.tintColor = UIColor.black
        textView?.isEditable = false
        textView?.isScrollEnabled = true
//        textView?.isSelectable = false
                
        let baseText = "感谢您使用【AdKleinSDKDemo】，为了让您更加放心地使用本产品，请您务必仔细阅读，充分理解政策中的条款内容后再点击同意,以便您能够更好地行使个人权利和保护个人信息。\n请您注意，如果您不同意其中任何条款约定，您可以点击不同意，暂停使用本产品。如果您点击同意即表示您已阅读和同意《隐私政策》。"
        
        let messageText = NSMutableAttributedString(string: baseText)
        
        messageText.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: NSRange(location: 0, length: messageText.length))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        messageText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: messageText.length))
        
        let nsText = (messageText.string as NSString)
//        let rangeUserAgreement = nsText.range(of: "《用户协议》")
        let rangePrivacyAgreement = nsText.range(of: "《隐私政策》")
                
        //设置富文本超链接属性
//        messageText.addAttribute(.link, value: "userAgreement://", range: rangeUserAgreement)
        messageText.addAttribute(.link, value: "privacyAgreement://", range: rangePrivacyAgreement)
        
        textView?.linkTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.blue,
            NSAttributedString.Key.underlineColor: UIColor.blue,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        textView?.delegate = self
        textView?.attributedText = messageText
        backgroundView?.addSubview(textView!)
        
        bottomBtn = UIButton(type: .custom)
        bottomBtn?.frame = CGRect(x: 20, y: modalHeight! - 130, width: modalWidth! - 40, height: 50)
        bottomBtn?.layer.masksToBounds = true
        bottomBtn?.layer.cornerRadius = 24.0
        bottomBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        bottomBtn?.backgroundColor = UIColor.orange
        bottomBtn?.setTitleColor(UIColor.white, for: .normal)
        
        bottomBtn?.addAction { [unowned self] in
            hide()
            completion(true)
        }
        bottomBtn?.setTitle("同意并继续", for: .normal)
        backgroundView?.addSubview(bottomBtn!)
        
        cancelBtn = UIButton(type: .custom)
        cancelBtn?.frame = CGRect(x: 20, y: modalHeight! - 70, width: modalWidth! - 40, height: 50)
        cancelBtn?.layer.masksToBounds = true
        cancelBtn?.layer.cornerRadius = 24.0
        cancelBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        cancelBtn?.backgroundColor = RGBA(153, 151, 169, 0.3)
        cancelBtn?.setTitleColor(RGBA(73, 71, 102, 1), for: .normal)
        
        cancelBtn?.addAction { [unowned self] in
            hide()
            completion(false)
        }
        cancelBtn?.setTitle("不同意", for: .normal)
        backgroundView?.addSubview(cancelBtn!)
        
        let animation = CAKeyframeAnimation(keyPath: "transform")
        animation.duration = 0.3
        var values: [AnyHashable] = []
        values.append(NSValue(caTransform3D: CATransform3DMakeScale(0.5, 0.5, 1.0)))
        values.append(NSValue(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)))
        animation.values = values
        backgroundView?.layer.add(animation, forKey: nil)
    }
    
    func hide() {
        isHidden = true
        removeFromSuperview()
    }
    
    internal func textView(_ textView: UITextView, shouldInteractWith source: URL, in characterRange: NSRange) -> Bool {
        if source.scheme == "userAgreement" {
            if let url = URL(string: "https://www.iusmob.com/doc/ua.html") {
                UIApplication.shared.open(url, options: [:])
            }
            return false
        } else if source.scheme == "privacyAgreement" {
            if let url = URL(string: "https://www.iusmob.com/doc/privacy.html") {
                UIApplication.shared.open(url, options: [:])
            }
            return false
        }
        return true
    }
}
