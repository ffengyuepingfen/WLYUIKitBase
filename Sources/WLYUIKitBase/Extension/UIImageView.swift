//
//  UIImageView.swift
//  Alamofire
//
//  Created by wangxiangbo on 2020/3/30.
//

import UIKit

extension UIImageView {
    
    public func toCircle() {
        let width = self.bounds.width/2
        
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize(width: width, height: width))
        let maskLayer = CAShapeLayer()
        //设置大小
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath;
        self.layer.mask = maskLayer
    }
    
    public func toNormalCircle(cornerRadii:CGFloat = 10) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize(width: cornerRadii, height: cornerRadii))
        let maskLayer = CAShapeLayer()
        //设置大小
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath;
        self.layer.mask = maskLayer
    }
    
}

