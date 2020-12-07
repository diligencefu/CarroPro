//
//  LNTabbarViewController.swift
//  Carro
//
//  Created by MAC on 2020/12/2.
//

import UIKit

class LNNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        let navigationBar = UINavigationBar.appearance()
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.95)]
        self.navigationBar.tintColor = UIColor.white
    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if (children.count > 0) {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        var isHidden = false
        if viewController.isKind(of: LNCarDetailViewController.self)
        {
            isHidden = true
        }
        self.setNavigationBarHidden(isHidden, animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        navigationController.interactivePopGestureRecognizer?.delegate = (viewController as? UIGestureRecognizerDelegate)
        navigationController.interactivePopGestureRecognizer?.isEnabled = navigationController.children.count > 1
    }
    
}
