//
//  XYMenuItem.swift
//  XYMenuSwiftDemo
//
//  Created by FireHsia on 2018/2/2.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

import UIKit

class XYMenuItem: UIView {

    // MARK: LazyLoad
    private lazy var iconImage: UIImageView = {
        var image = UIImageView()
        return image
    }()

    private lazy var titleLab: UILabel = {
        var label = UILabel.init(frame: CGRect.zero)
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()

    private var icon: UIImage?
    
    // MARK: 初始化方法
    init(_ iconStr: UIImage?, _ titleStr: String) {
        self.icon = iconStr
        super.init(frame: CGRect.zero)
        iconImage.image = iconStr
        titleLab.text = titleStr
    }

    func setUpViews(_ rect: CGRect) {
        frame = rect
        let kItemHeight = bounds.size.height
        let iconHeight = kItemHeight / 3
        addSubview(iconImage)
        addSubview(titleLab)
        if icon == nil {
            iconImage.frame = CGRect.zero
            titleLab.frame = CGRect(origin: CGPoint.zero, size: rect.size)
        }else{
            iconImage.frame = CGRect(x: iconHeight, y: iconHeight, width: iconHeight, height: iconHeight)
            let iconMaxY = iconImage.frame.maxY
            titleLab.frame = CGRect(x: iconMaxY + (iconHeight * 3) / 4, y: iconHeight, width: iconHeight * 5, height: iconHeight)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
