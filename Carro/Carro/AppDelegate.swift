//
//  AppDelegate.swift
//  Carro
//
//  Created by MAC on 2020/12/3.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = LNNavigationController.init(rootViewController: ViewController())
        self.window?.makeKeyAndVisible()

        return true
    }

}

