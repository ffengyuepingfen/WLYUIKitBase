//
//  CLLocation.swift
//  Sky
//
//  Created by Mars on 13/02/2018.
//  Copyright © 2018 Mars. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocation {
    public var toString: String {
        let latitude = String(format: "%.3f", coordinate.latitude)
        let longitude = String(format: "%.3f", coordinate.longitude)

        return "\(latitude), \(longitude)"
    }
}

extension Double {
    
    /// 返回 字符串
    /// - Parameter scale: 保留的小数位
    /// - Returns: 返回结构化的字符串
    public func toString(scale:Int16 = 2) -> String {
        let inputNumber = NSDecimalNumber(value: self)
        let number = inputNumber.rounding(accordingToBehavior: String.priceHandler(scale: scale))
        return "\(number)"
    }
}
