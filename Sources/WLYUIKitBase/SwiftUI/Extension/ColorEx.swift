//
//  File.swift
//  
//
//  Created by Laowang on 2023/12/29.
//

import SwiftUI

extension Color {
    
    public init(uuiColor: UIColor) {
        if #available(iOS 15.0, *) {
            self.init(uiColor: uuiColor)
        } else {
            self.init(hex: 0xF2F1F6)
        }
    }
    
    public init(hex: Int, alpha: Double = 1) {
        let components = (
            R: Double((hex >> 16) & 0xff) / 255,
            G: Double((hex >> 08) & 0xff) / 255,
            B: Double((hex >> 00) & 0xff) / 255
        )
        self.init(
            .sRGB,
            red: components.R,
            green: components.G,
            blue: components.B,
            opacity: alpha
        )
    }
    /// Description 获取字符串颜色
    ///
    /// - Parameter hexString: hexString description 颜色的字符串代号
    /// - Returns: return value description 返回颜色
    public init(hex: String, alpha: Double = 1) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if cString.count < 6 {
            self.init(
                .sRGB,
                red: 0,
                green:  0,
                blue: 0,
                opacity: alpha
            )
        }

        let index = cString.index(cString.endIndex, offsetBy: -6)
        let subString = cString[index...]
        if cString.hasPrefix("0X") { cString = String(subString) }
        if cString.hasPrefix("#") { cString = String(subString) }

        if cString.count != 6 {
            self.init(
                .sRGB,
                red: 0,
                green:  0,
                blue: 0,
                opacity: alpha
            )
        }

        var range: NSRange = NSRange(location: 0, length: 2)
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)

        var r: Double = 0x0
        var g: Double = 0x0
        var b: Double = 0x0

        Scanner(string: rString).scanHexDouble(&r)
        Scanner(string: gString).scanHexDouble(&g)
        Scanner(string: bString).scanHexDouble(&b)
        self.init(
            .sRGB,
            red: r,
            green:  g,
            blue: b,
            opacity: alpha
        )
    }
}

extension Color {
    /// 青色
    public static let CCcyan: Self = {
        if #available(iOS 15.0, *) {
            return .cyan
        } else {
            return Color.init(hex: 0x00FFFF)
        }
    }()
    
    public static let BBbrown: Self = {
        if #available(iOS 15.0, *) {
            return .brown
        } else {
            return Color.init(hex: 0xA0522D)
        }
    }()
}
