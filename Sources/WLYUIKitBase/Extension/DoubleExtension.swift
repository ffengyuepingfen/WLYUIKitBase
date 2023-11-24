//
//  File.swift
//  
//
//  Created by Laowang on 2023/5/15.
//

import UIKit
// MARK: - 一、Double 的基本转换
public extension Double {
   
    // MARK: 1.1、转 Int
    /// 转 Int
    var int: Int { return Int(self) }
    
    // MARK: 1.2、Double 四舍五入转 Int
    /// Double 四舍五入转 Int
    var lroundToInt: Int { return lround(self) }
    
    // MARK: 1.3、转 CGFloat
    /// 转 CGFloat
    var cgFloat: CGFloat { return CGFloat(self) }

    // MARK: 1.4、转 Int64
    /// 转 Int64
    var int64: Int64 { return Int64(self) }
    
    // MARK: 1.5、转 Float
    /// 转 Float
    var float: Float { return Float(self) }
    
    // MARK: 1.6、转 String
    /// 转 String
    var string: String { return String(self) }
    
    // MARK: 1.7、转 NSNumber
    /// 转 NSNumber
    var number: NSNumber { return NSNumber(value: self) }
    
    // MARK: 1.8、转 Double
    /// 转 Double
    var double: Double { return self }
}

// MARK: - 二、数字的处理
public extension Double {
    // MARK: 2.1、浮点数四舍五入
    /// 浮点数四舍五入
    /// - Parameter places: 数字
    /// - Returns: Double
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
