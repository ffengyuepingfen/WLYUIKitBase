//
//  UIViewEx.swift
//  WLYUIKitBase
//
//  Created by Laowang on 2023/11/22.
//

import UIKit


extension UIView {
    
    /// 单行语言文字展示
    /// - Parameters:
    ///   - icon: 图片
    ///   - text: 文字
    /// - Returns: 返回视图
    public static func singleLine(icon: UIImage?, tintColor: UIColor? = nil, text: String) -> UIView {
        
        let ll = UILabel.body(text, weight: .medium)
        
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.layer.cornerRadius = 6
        
        let tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: GConfig.ScreenW, height: 44))
        tableHeaderView.backgroundColor = UIColor.clear
        tableHeaderView.addSubviewAnchor(subView: backView, insets: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        var leftMagin = 8.0
        if let icon {
            leftMagin = 44
            let imageView = UIImageView(frame: CGRect(x: 8, y: 11, width: 22, height: 22))
            imageView.image = icon.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = tintColor
            backView.addSubview(imageView)
        }
        
        backView.addSubviewAnchor(subView: ll, insets: UIEdgeInsets(top: 0, left: leftMagin, bottom: 0, right: 8))
        return tableHeaderView
    }
    
    /// 卡片的背景色
    /// - Parameters:
    ///   - subView: 子View
    ///   - insets: 间距
    public static func bg(color: UIColor = .secondarySystemBackground, radius: CGFloat = 12) -> UIView {
        let vi = UIView()
        vi.backgroundColor = color
        vi.layer.cornerRadius = radius
        return vi
    }
    
    public static func separatorH(color: UIColor = UIColor.separator) -> UIView {
        let vi = UIView()
        vi.backgroundColor = color
        vi.heightConstraint = 1.0
        return vi
    }
    
    public static func separatorv(color: UIColor = UIColor.separator) -> UIView {
        let vi = UIView()
        vi.backgroundColor = color
        vi.widthConstraint = 1.0
        return vi
    }
}
