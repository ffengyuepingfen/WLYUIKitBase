//
//  File.swift
//  
//
//  Created by Laowang on 2023/5/15.
//

import Foundation
import CoreGraphics
// MARK: - 一、CGFloat 的基本转换
//public extension CGFloat {

    // MARK: 1.1、转 Int
    /// 转 Int
//    var int: Int { return Int(self) }
    
    // MARK: 1.2、转 CGFloat
    /// 转 CGFloat
//    var cgFloat: CGFloat { return self }
    
    // MARK: 1.3、转 Int64
    /// 转 Int64
//    var int64: Int64 { return Int64(self) }
    
    // MARK: 1.4、转 Float
    /// 转 Float
//    var float: Float { return Float(self) }
    
    // MARK: 1.5、转 String
    /// 转 String
//    var string: String { return String(self.base.jk.double) }
    
    // MARK: 1.6、转 NSNumber
    /// 转 NSNumber
//    var number: NSNumber { return NSNumber(value: self.base.jk.double) }
    
    // MARK: 1.7、转 Double
    /// 转 Double
//    var double: Double { return Double(self) }
//}

// MARK: - 二、角度和弧度相互转换
public extension CGFloat {
    
    // MARK: 角度转弧度
    /// 角度转弧度
    /// - Returns: 弧度
    func degreesToRadians() -> CGFloat {
        return (.pi * self) / 180.0
    }
    
    // MARK: 弧度转角度
    /// 角弧度转角度
    /// - Returns: 角度
    func radiansToDegrees() -> CGFloat {
        return (self * 180.0) / .pi
    }
}

extension CGPoint {
    
    /// Calculates the distance between two points in 2D space.
    /// + returns: The distance from this point to the given point.
    public func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(point.x - self.x, 2) + pow(point.y - self.y, 2))
    }
    
    public static func degreesToRadians(_ degrees: Double) -> Double {
        return degrees * .pi / 180.0
    }

    /// 计算两个经纬度之间的直线距离:代码使用Haversine公式计算之间的直线距离，结果以米为单位输出。
    /// - Parameters:
    ///   - latitude1: latitude1 description
    ///   - longitude1: longitude1 description
    ///   - latitude2: latitude2 description
    ///   - longitude2: longitude2 description
    /// - Returns: description
    public static func distanceBetweenCoordinates(latitude1: Double, longitude1: Double, latitude2: Double, longitude2: Double) -> Double {
        let earthRadius = 6371.0 // 地球的半径，单位：公里

        let dLat = degreesToRadians(latitude2 - latitude1)
        let dLon = degreesToRadians(longitude2 - longitude1)

        let lat1 = degreesToRadians(latitude1)
        let lat2 = degreesToRadians(latitude2)

        let a = sin(dLat/2) * sin(dLat/2) + sin(dLon/2) * sin(dLon/2) * cos(lat1) * cos(lat2)
        let c = 2 * atan2(sqrt(a), sqrt(1-a))

        return earthRadius * c * 1000.0
    }
}
