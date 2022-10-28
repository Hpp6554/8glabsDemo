//
//  UIButton+Extension.swift
//  SwiftDemo
//
//  Created by hp on 2022/10/27.
//

import UIKit

extension UIButton {
    /// 创建一个按钮
    /// - Parameters:
    ///   - title: 标题
    ///   - titleFont: 字体
    ///   - titleColor: 标题颜色，默认颜色 黑色
    ///   - image: 图片
    ///   - bgColor: 背景颜色，默认透明
    /// - Returns: UIButton
    public class func makeButton(title: String?,
                                 titleFont: UIFont?,
                                 titleColor: UIColor? = UIColor.black,
                                 image: String?,
                                 bgColor:UIColor? = UIColor.clear) -> UIButton{
        let button = UIButton(type: .custom)
        button.titleLabel?.font = titleFont
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        if let image = image{
            button.setImage(UIImage(named: image) , for: .normal)
        }
        button.sizeToFit()
        button.backgroundColor = bgColor
        return button
    }
}
