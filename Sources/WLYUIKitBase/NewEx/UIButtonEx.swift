//
//  UIButtonEx.swift
//  WLYUIKitBase
//
//  Created by Laowang on 2023/11/14.
//

import UIKit

extension UIButton {
    
    /// 类似于 揉线选择站点的按钮
    /// - Parameters:
    ///   - placeholder: 占位文字
    ///   - image: 前面的图片
    ///   - weight: 字重
    ///   - color: 字的颜色
    /// - Returns: 返回一个按钮
    public static func styleOne(placeholder: String, image: UIImage?, weight: UIFont.Weight? = nil, color: UIColor, isShowBg: Bool = true) -> UIButton {
        let b = UIButton()
        b.setTitle(placeholder, for: .normal)
        b.setTitleColor(color, for: .normal)
        b.setImage(image, for: .normal)
        b.setImage(image, for: .highlighted)
        b.contentHorizontalAlignment = .left
        b.titleLabel?.font = UIFont.body(weight)
        b.backgroundColor = isShowBg ? UIColor.systemGray6 : .white
        b.layer.cornerRadius = 6.0
        
        let imageTitleSpace = 16.0
        //初始化imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        imageEdgeInsets = UIEdgeInsets(top: 0, left: imageTitleSpace, bottom: 0, right: 0)
        labelEdgeInsets = UIEdgeInsets(top: 0, left: imageTitleSpace*2, bottom: 0, right: 0)

        b.titleEdgeInsets = labelEdgeInsets
        b.imageEdgeInsets = imageEdgeInsets
        return b
    }
}
