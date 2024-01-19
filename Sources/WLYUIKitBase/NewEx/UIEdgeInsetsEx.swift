//
//  File.swift
//  
//
//  Created by Laowang on 2024/1/19.
//

import UIKit

public extension UIEdgeInsets {
    static let four = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    static let eight = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    static let sixteen = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    static let big72 = UIEdgeInsets(top: 72, left: 72, bottom: 72, right: 72)
    
    init(_ all: CGFloat) {
        self.init(top: all, left: all, bottom: all, right: all)
    }
    
    init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}

public extension CGSize {
    
    init(_ all: CGFloat) {
        self.init(width: all, height: all)
    }
}
