//
//  UIFont+Extension.swift
//  SwiftDemo
//
//  Created by hp on 2022/10/27.
//

import UIKit

// MARK: - 标准字体
extension UIFont {
    /// 苹方常规
    ///
    /// - Parameter size: 字体大小
    /// - Returns: 字体对象
    @objc public class func pingfangRegular(size: CGFloat) ->UIFont? {
        return UIFont(name: "PingFangSC-Regular", size: size)
    }
    
    /// 苹方中粗
    ///
    /// - Parameter size: 字体大小
    /// - Returns: 字体对象
    @objc public class func pingfangMedium(size: CGFloat) ->UIFont? {
        return UIFont(name: "PingFangSC-Medium", size: size)
    }
    
    /// 苹方半黑体
    ///
    /// - Parameter size: 字体大小
    /// - Returns: 字体对象
    @objc public class func pingfangSemibold(size: CGFloat) ->UIFont? {
        return UIFont(name: "PingFangSC-Semibold", size: size)
    }
}

extension Array {
    /// 数组安全取值
    /// - Parameter index: 索引
    /// - Returns: 元素
    public func objectOrNil(at index: Int) -> Any? {
        if index >= 0 && index < self.count  {
            return self[index]
        }
        return nil
    }
}
