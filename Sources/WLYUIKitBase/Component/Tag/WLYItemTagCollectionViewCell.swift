//
//  WLYItemTagCollectionViewCell.swift
//  InternetBusKit
//
//  Created by wangxiangbo on 2019/12/12.
//  Copyright © 2019 ZHXMAC. All rights reserved.
//

import UIKit
import WLYUIKitBase

class WLYItemTagCollectionViewCell: UICollectionViewCell,IdentifierProtocol {
    var label: UILabel!
    
    var imageView:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView = UIImageView(frame: CGRect(x: (self.bounds.width - 60)/2, y: 4, width: 60, height: 60))
        self.imageView.backgroundColor = UIColor.gray
        self.imageView.layer.cornerRadius = 30
        self.contentView.addSubview(self.imageView)
        self.label = UILabel(frame: CGRect(x: 10, y: 68, width: self.bounds.width - 20, height: self.bounds.height - 12 - 60))
        self.label.font = UIFont.systemFont(ofSize: 14.0)
        self.label.textAlignment = .center
        self.label.numberOfLines = 1
        self.contentView.addSubview(self.label)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
