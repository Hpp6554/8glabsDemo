//
//  UIColor+Extension.swift
//  SwiftDemo
//
//  Created by hp on 2022/10/27.
//

import UIKit

func RGB(_ r: CGFloat, _ g: CGFloat, _ b:CGFloat) -> UIColor {
    return UIColor(red: r, green: g, blue: b, alpha: 1);
}

public extension UIColor {
    
    /// hexColor
    convenience init(hex: UInt32, alpha:CGFloat) {
        let r: CGFloat = ((CGFloat)((hex & 0xFF0000) >> 16)) / 255.0
        let g: CGFloat = ((CGFloat)((hex & 0xFF00) >> 8)) / 255.0
        let b: CGFloat = ((CGFloat)(hex & 0xFF)) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }

    static var fc_3296F4: UIColor {
        return UIColor(hex: 0x3296F4, alpha: 1.0)
    }
    
    static var fc_7FCCFC: UIColor {
        return UIColor(hex: 0x7FCCFC, alpha: 1.0)
    }
    
    static var fc_999999: UIColor {
        return UIColor(hex: 0x999999, alpha: 1.0)
    }
    
    static var fc_121E26: UIColor {
        return UIColor(hex: 0x121E26, alpha: 1.0)
    }
    
    static var fc_018CD7: UIColor {
        return UIColor(hex: 0x018CD7, alpha: 1.0)
    }
    
    static var fc_FAFAFA: UIColor {
        return UIColor(hex: 0xFAFAFA, alpha: 1.0)
    }
    
    static var fc_040404: UIColor {
        return UIColor(hex: 0x040404, alpha: 1.0)
    }
    
    static var fc_4D4D4D: UIColor {
        return UIColor(hex: 0x4D4D4D, alpha: 1.0)
    }
    
    static var fc_F3F3F3: UIColor {
        return UIColor(hex: 0xF3F3F3, alpha: 1.0)
    }
}
