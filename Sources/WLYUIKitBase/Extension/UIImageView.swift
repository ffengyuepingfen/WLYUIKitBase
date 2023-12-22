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
 
    /// 下载图片并添加到视图上
    public func downloadImage(from url: URL?, placeholder: UIImage?) {
        self.image = placeholder
        guard let url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            let image = UIImage(data: data)
            self.image = image
        }.resume()
    }
    
}

