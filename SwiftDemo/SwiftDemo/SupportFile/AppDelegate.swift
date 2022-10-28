//
//  AppDelegate.swift
//  SwiftDemo
//
//  Created by hp on 2022/10/27.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.rootViewController = HpHomeManagerVC()
        window?.makeKeyAndVisible()

        return true
    }
}

