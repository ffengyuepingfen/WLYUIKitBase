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
    
}
