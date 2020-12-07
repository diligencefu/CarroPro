//
//  LNBaseViewController.swift
//  Carro
//
//  Created by MAC on 2020/12/2.
//

import UIKit

class LNBaseViewController: UIViewController {
        
    public let kStatusBarHeight = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0

    lazy var bgNavigationView: UIView = {
        let navigationView = UIView.init()
        navigationView.frame = CGRect.init(x: 0, y: 0, width: self.view.ln_width, height: kStatusBarHeight+44)
        return navigationView
    }()
    
    lazy var myNavigationItem: UINavigationItem = {
        let navigationItem = UINavigationItem.init()
        return navigationItem
    }()
    
    lazy var myNavigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar.init()
        navigationBar.frame = CGRect.init(x: 0, y: kStatusBarHeight, width: self.view.ln_width, height: 44)
        navigationBar.autoresizingMask = UIView.AutoresizingMask.init(arrayLiteral: [.flexibleBottomMargin,.flexibleWidth])
        navigationBar.setBackgroundImage(UIImage.init(), for: .default)
        navigationBar.backgroundColor = .clear
        navigationBar.pushItem(self.myNavigationItem, animated: true)
        return navigationBar
    }()
    
    lazy var contentView: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: safeArea.top, width: self.view.ln_width, height: self.view.ln_height - safeArea.top - safeArea.bottom))
        view.backgroundColor = self.view.backgroundColor
        return view
    }()

    ///导航栏背景色
    var navigationBgColor : UIColor? {
        didSet {
            self.bgNavigationView.backgroundColor = navigationBgColor
        }
    }
    
    ///安全区域
    var safeArea : UIEdgeInsets! {
        var bottom:CGFloat = 0
        if let tabbarVc = self.tabBarController, !tabbarVc.tabBar.isHidden {
            bottom = tabbarVc.tabBar.frame.height
        }
        return UIEdgeInsets.init(top: kStatusBarHeight+44, left: 0, bottom: bottom, right: 0)
    }

    ///设置右导航按钮
    var rightBarButtonItem: UIBarButtonItem? {
        didSet {
            self.myNavigationItem.rightBarButtonItem = rightBarButtonItem
            self.myNavigationItem.rightBarButtonItem?.tintColor = UIColor.init(gary: 36)
        }
    }
    
    ///设置左导航按钮
    var leftBarButtonItem : UIBarButtonItem? {
        didSet {
            self.myNavigationItem.leftBarButtonItem = leftBarButtonItem
            self.myNavigationItem.leftBarButtonItem?.tintColor = UIColor.init(gary: 36)
        }
    }
    
    
    fileprivate func addNavigationItem() {
        
        if self.navigationController?.children.count == 1 {
            return
        }
        self.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_return_gray"), style: .plain, target: self, action: #selector(pop))
        self.navigationController?.popoverPresentationController?.delegate = self as? UIPopoverPresentationControllerDelegate
    }
    
    @objc func pop() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.backGroudColor
        self.navigationBgColor = UIColor.clear
        self.view.addSubview(self.bgNavigationView)
        self.view.addSubview(self.myNavigationBar)
        self.view.addSubview(contentView)
        
        addNavigationItem()
        configSubViews()
        requestData()
    }
    
    internal func configSubViews() {
        
    }

    internal func requestData() {
        
    }
}
