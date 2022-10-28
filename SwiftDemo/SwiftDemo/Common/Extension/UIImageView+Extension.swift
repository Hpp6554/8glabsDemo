//
//  UIImageView+Extension.swift
//  SwiftDemo
//
//  Created by hp on 2022/10/27.
//

import Foundation
import UIKit

extension UIImageView {
    /// 创建一个IamgeView
    /// - Parameters:
    ///   - image: 图片
    ///   - mode: 模式
    ///   - isUserInteractionEnabled: 是否可交互
    /// - Returns: UIImageView
    public class func makeImageView(image: UIImage?,
                                    contentMode: ContentMode = .scaleToFill,
                                    isUserInteractionEnabled:Bool = false) -> UIImageView {
        let imgView = UIImageView()
        imgView.image = image
        imgView.isUserInteractionEnabled = isUserInteractionEnabled
        imgView.contentMode = contentMode
        imgView.clipsToBounds = true
        return imgView
    }
}
