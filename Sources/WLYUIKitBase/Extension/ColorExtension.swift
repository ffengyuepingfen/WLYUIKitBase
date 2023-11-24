//
//  Color_Extension.swift
//  SwiftDemo
//
//  Created by 中行讯 on 2018/7/6.
//  Copyright © 2018年 Beijing CIC Technology Co., Ltd. All rights reserved.
//

import UIKit



extension UIColor {

    convenience init(hex: Int, alpha: CGFloat = 1) {
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255
        let g = CGFloat((hex & 0xFF00) >> 8) / 255
        let b = CGFloat((hex & 0xFF)) / 255
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    /// Description 红色
    ///
    /// - Returns: return value description
    public static func pumkinRed() -> UIColor {
        return hex(hexString: "#FF5928")
    }

    /// Description 绿色
    ///
    /// - Returns: return value description
    public static func pumkinGreen() -> UIColor {
        return hex(hexString: "#70BF41")
    }

    /// Description 蓝色
    ///
    /// - Returns: return value description
    public static func pumkinBlue() -> UIColor {
        return hex(hexString: "#51A7F9")
    }

    /// Description yellow
    ///
    /// - Returns: return value description
    public static func pumkinYellow() -> UIColor {
        return hex(hexString: "#F5D328")
    }

    /// Description 紫色
    ///
    /// - Returns: return value description
    public static func pumkinPurple() -> UIColor {
        return hex(hexString: "#B36AE2")
    }

    /// Description 橙色
    ///
    /// - Returns: return value description
    public static func pumkinOrange() -> UIColor {
        return hex(hexString: "#F39019")
    }

    /// Description cyan 青色
    ///
    /// - Returns: return value description
    public static func pumkinCyan() -> UIColor {
        return hex(hexString: "#00E5F9")
    }

    public static func randomColor() -> UIColor {
        return UIColor(displayP3Red: CGFloat(Double.random(in: 0...1)), green: CGFloat(Double.random(in: 0...1)), blue: CGFloat(Double.random(in: 0...1)), alpha: 1.0)
    }
    
    //使用rgb方式生成自定义颜色
    public convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) {
        let red = r / 255.0
        let green = g / 255.0
        let blue = b / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }

    //使用rgba方式生成自定义颜色
    public convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) {
        let red = r / 255.0
        let green = g / 255.0
        let blue = b / 255.0
        self.init(red: red, green: green, blue: blue, alpha: a)
    }

    public convenience init(r: UInt32, g: UInt32, b: UInt32, a: CGFloat = 1.0) {
        self.init(red: CGFloat(r) / 255.0,
                  green: CGFloat(g) / 255.0,
                  blue: CGFloat(b) / 255.0,
                  alpha: a)
    }
    /// Description 颜色转化成图片
    ///
    /// - Returns: return value description 图片
    public func image(size:CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(self.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    /// Description 获取字符串颜色
    ///
    /// - Parameter hexString: hexString description 颜色的字符串代号
    /// - Returns: return value description 返回颜色
    public class func hex(hexString: String) -> UIColor {
        var cString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        if cString.count < 6 { return UIColor.black }

        let index = cString.index(cString.endIndex, offsetBy: -6)
        let subString = cString[index...]
        if cString.hasPrefix("0X") { cString = String(subString) }
        if cString.hasPrefix("#") { cString = String(subString) }

        if cString.count != 6 { return UIColor.black }

        var range: NSRange = NSRange(location: 0, length: 2)
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)

        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0

        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)

        return UIColor(r: r, g: g, b: b)
    }

}

extension UIColor {
    ///  主标题文字的黑色
    public static func textBlack() -> UIColor {
        return hex(hexString: "#333333")
    }
    ///  二级标题文字深灰色
    public static func textGray() -> UIColor {
        return hex(hexString: "#666666")
    }
    ///  二级标题文字浅灰色
    public static func textLightGray() -> UIColor {
        return hex(hexString: "#999999")
    }
    
    public static func backGroundColor() -> UIColor {
        return hex(hexString: "#F8F8F8")
    }
    
    ///  背景浅灰色
    public static func backGroudLightGray() -> UIColor {
        return hex(hexString: "#f8f8f8")
    }
    ///  边框浅灰色
    public static func borderLightGray() -> UIColor {
        return hex(hexString: "#dddddd")
    }
    ///  边框深灰色
    public static func borderDeepGray() -> UIColor {
        return hex(hexString: "#cccccc")
    }
}

