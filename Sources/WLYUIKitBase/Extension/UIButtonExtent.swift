//
//  UIButtonExtent.swift
//  XAOfficialBus
//
//  Created by zhonghangxun on 2018/12/7.
//  Copyright © 2018 zhonghangxun. All rights reserved.
//

import UIKit

// MARK: - 定义button相对label的位置
public enum YWButtonEdgeInsetsStyle {
    case top
    case left
    case right
    case bottom
}

extension UIButton {
    
    public static func imageTop(title:String,image:UIImage?) -> UIButton {
        let imageTop = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        imageTop.setTitle(title, for: .normal)
        imageTop.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        imageTop.setImage(image, for: .normal)
        imageTop.layoutButton(style: .top, imageTitleSpace: 4)
        return imageTop
    }

    public func layoutButton(style: YWButtonEdgeInsetsStyle, imageTitleSpace: CGFloat) {
        //得到imageView和titleLabel的宽高
        let imageWidth = self.imageView?.frame.size.width
        let imageHeight = self.imageView?.frame.size.height

        var labelWidth: CGFloat! = 0.0
        var labelHeight: CGFloat! = 0.0

        labelWidth = self.titleLabel?.intrinsicContentSize.width
        labelHeight = self.titleLabel?.intrinsicContentSize.height

        //初始化imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero

        //根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch style {
        case .top:
            //上 左 下 右
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight-imageTitleSpace/2, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageHeight!-imageTitleSpace/2, right: 0)
            break

        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -imageTitleSpace/2, bottom: 0, right: imageTitleSpace)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: imageTitleSpace/2, bottom: 0, right: -imageTitleSpace/2)
            break

        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight!-imageTitleSpace/2, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight!-imageTitleSpace/2, left: -imageWidth!, bottom: 0, right: 0)
            break

        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+imageTitleSpace/2, bottom: 0, right: -labelWidth-imageTitleSpace/2)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!-imageTitleSpace/2, bottom: 0, right: imageWidth!+imageTitleSpace/2)
            break

        }

        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets

    }

    /// 便利构造函数
    ///
    /// - Parameters:
    ///   - imageName: 图像名称
    ///   - backImageName: 背景图像名称
    public convenience init(hq_imageName: String, backImageName: String?) {
        self.init()

        setImage(UIImage(named: hq_imageName), for: .normal)
        setImage(UIImage(named: hq_imageName), for: .highlighted)

        if let backImageName = backImageName {
            setBackgroundImage(UIImage(named: backImageName), for: .normal)
            setBackgroundImage(UIImage(named: backImageName + "_highlighted"), for: .highlighted)
        }

        // 根据背景图片大小调整尺寸
        sizeToFit()
    }

}
