//
//  UIView+Extension.swift
//  SwiftDemo
//
//  Created by hp on 2022/10/27.
//

import UIKit

public struct UIRectSide : OptionSet {

    public let rawValue: Int

    public static let left = UIRectSide(rawValue: 1 << 0)

    public static let top = UIRectSide(rawValue: 1 << 1)

    public static let right = UIRectSide(rawValue: 1 << 2)

    public static let bottom = UIRectSide(rawValue: 1 << 3)

    public static let all: UIRectSide = [.top, .right, .left, .bottom]

    public init(rawValue: Int) {

        self.rawValue = rawValue;

    }

}

extension UIView {
    // .x
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var rect = self.frame
            rect.origin.x = newValue
            self.frame = rect
        }
    }
    
    // .y
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var rect = self.frame
            rect.origin.y = newValue
            self.frame = rect
        }
    }
    
    // .maxX
    public var maxX: CGFloat {
        get {
            return self.frame.maxX
        }
        set {
            self.x = newValue - self.width
        }
    }
    
    // .maxY
    public var maxY: CGFloat {
        get {
            return self.frame.maxY
        }
        set {
            self.y = newValue - self.height
        }
    }
    
    // .centerX
    public var centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    // .centerY
    public var centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
    
    // .width
    public var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var rect = self.frame
            rect.size.width = newValue
            self.frame = rect
        }
    }
    
    // .height
    public var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var rect = self.frame
            rect.size.height = newValue
            self.frame = rect
        }
    }
    //  ??????
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.masksToBounds = (newValue > 0)
            layer.cornerRadius = newValue
        }
    }
    //  ????????????
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        } set {
            layer.borderWidth = newValue
        }
    }
    //  ????????????
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        } set {
            layer.borderColor = newValue.cgColor
        }
    }
    // ????????????
    @IBInspectable var shadowColor: UIColor{
        get {
            return UIColor(cgColor: layer.shadowColor!)
        }set {
            layer.shadowColor = newValue.cgColor
        }
    }
    // ????????????
    @IBInspectable var shadowOffset: CGSize{
        get {
            return layer.shadowOffset
        }set {
            layer.shadowOffset = newValue
        }
    }
    // ???????????????
    @IBInspectable var shadowOpacity: Float{
        get {
            return layer.shadowOpacity
        }set {
            layer.shadowOpacity = newValue
        }
    }
    // ????????????
    @IBInspectable var shadowRadius: CGFloat{
        get {
            return layer.shadowRadius
        }set {
            layer.shadowRadius = newValue
        }
    }
//    func addTapForView() ->(Observable<UITapGestureRecognizer>){
//        self.isUserInteractionEnabled = true
//        for ges in gestureRecognizers ?? []{
//            removeGestureRecognizer(ges)
//        }
//        let ges = UITapGestureRecognizer()
//        self.addGestureRecognizer(ges)
//        return ges.rx.event.throttle(.milliseconds(150), latest: true, scheduler: MainScheduler.instance)
//    }
    
    
    ///?????????????????????
    func LayerImage(fromLayer layer:CALayer) ->UIImage{

        UIGraphicsBeginImageContext(layer.frame.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage!
    }
    func addRoundedOrShadow(radius:CGFloat, shadowOpacity:CGFloat, shadowColor:UIColor)  {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        let subLayer = CALayer()
        let fixframe = self.frame
        let newFrame = CGRect(x: fixframe.minX + 3, y: fixframe.minY + 8, width: fixframe.width, height: fixframe.height) // ????????????
        subLayer.frame = newFrame
        subLayer.cornerRadius = radius
        subLayer.backgroundColor = UIColor.white.cgColor
        subLayer.masksToBounds = false
        subLayer.shadowColor = shadowColor.cgColor // ????????????
        subLayer.shadowOffset = CGSize(width: 0, height: 0) // ????????????,width:????????????3???height:????????????2?????????(0, -3),?????????shadowRadius????????????
        subLayer.shadowOpacity = Float(shadowOpacity) //???????????????
        subLayer.shadowRadius = 5;//?????????????????????3
        self.superview?.layer.insertSublayer(subLayer, below: self.layer)
    }
    /// ????????????
    ///
    /// - Parameters:
    ///   - corner: ????????????
    ///   - radii: ????????????
    /// - Returns: layer??????
    func configRectCorner(corner: UIRectCorner, radii: CGSize) -> CALayer {
        
        let maskPath = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: corner, cornerRadii: radii)
        
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        
        return maskLayer
    }
    
    
    /// ??????
    public func cornerRadius(_ radius:CGFloat)
    {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
    
    /// ??????
    public func border(_ color:UIColor?, width:CGFloat)
    {
        self.layer.borderColor = color?.cgColor
        self.layer.borderWidth = width
    }
}



// MARK: TableView`s reuseIdentifier
protocol ReuseViewProtocol: NSObjectProtocol {
    static var reuseIdentifier: String { get }
}

extension UIView: ReuseViewProtocol {
    static var reuseIdentifier: String {
        return "\(self)"
    }
}
