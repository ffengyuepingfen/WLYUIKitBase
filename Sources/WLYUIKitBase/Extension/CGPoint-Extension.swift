//
//  File.swift
//  
//
//  Created by Laowang on 2023/5/15.
//

import Foundation
import CoreGraphics

extension CGPoint {
    
    /// Calculates the distance between two points in 2D space.
    /// + returns: The distance from this point to the given point.
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(point.x - self.x, 2) + pow(point.y - self.y, 2))
    }
    
    /// Calculates the distance between two points in 2D space.
    /// + returns: The distance from this point to the given point.
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(point.x - self.x, 2) + pow(point.y - self.y, 2))
    }
    
    
    static func degreesToRadians(_ degrees: Double) -> Double {
        return degrees * .pi / 180.0
    }

    
    /// 计算两个经纬度之间的直线距离:代码使用Haversine公式计算之间的直线距离，结果以米为单位输出。
    /// - Parameters:
    ///   - latitude1: latitude1 description
    ///   - longitude1: longitude1 description
    ///   - latitude2: latitude2 description
    ///   - longitude2: longitude2 description
    /// - Returns: description
    static func distanceBetweenCoordinates(latitude1: Double, longitude1: Double, latitude2: Double, longitude2: Double) -> Double {
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
