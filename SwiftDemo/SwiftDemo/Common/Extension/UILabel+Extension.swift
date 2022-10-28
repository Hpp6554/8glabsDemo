//
//  UILabel+Extension.swift
//  SwiftDemo
//
//  Created by hp on 2022/10/27.
//

import UIKit

extension UILabel {
    /// 创建一个Label
    /// - Parameters:
    ///   - text: 文字
    ///   - font: 字体
    ///   - textColor: 文字颜色，默认 黑色
    ///   - alignment: 对其方式，默认左对齐
    ///   - numberLine: 文本行数，默认一行
    /// - Returns: UILabel
    public class func makeLabel(text: String?,
                                font: UIFont?,
                                textColor:UIColor? = UIColor.black,
                                alignment:NSTextAlignment = .left,
                                numberLine: Int = 1) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.numberOfLines = numberLine
        label.text = text
        label.textAlignment = alignment
        if let textFont = font {
            label.font = textFont
        }
        label.sizeToFit()
        return label
    }
}


