//
//  HpBaseMacro.swift
//  SwiftDemo
//
//  Created by hp on 2022/10/27.
//

import UIKit

public let kScreenHeight = UIScreen.main.bounds.size.height
public let kScreenWidth = UIScreen.main.bounds.size.width
public let kStatusBarHeight = UIApplication.shared.statusBarFrame.size.height
public let KBottomSafeArea: CGFloat = iphoneX ? 34 : 0
public let KNavigationHeight: CGFloat = iphoneX ? 88.0 : 64.0
public let KTabBarHeight: CGFloat = iphoneX ? 83.0 : 49.0


/// iphoneX系列
public var iphoneX: Bool{
    var iphonex = false
    if UIDevice.current.userInterfaceIdiom != .phone {
        return false
    }
    if #available(iOS 11, *) {
        let mainWindow = UIApplication.shared.delegate?.window
        if let window = mainWindow,let bottom = window?.safeAreaInsets.bottom, bottom > CGFloat(0.0){
            iphonex = true
        }
    }
    return iphonex
}
