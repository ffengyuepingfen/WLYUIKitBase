//
//  WLYTagCollectionViewCell.swift
//  SwiftDemo
//
//  Created by 王相博 on 2019/9/22.
//  Copyright © 2019 CHEN. All rights reserved.
//

import UIKit
import WLYUIKitBase

class WLYTagCollectionViewCell: UICollectionViewCell,IdentifierProtocol {

    var content:String = ""{
        didSet{
            self.label.text = content
            self.label.frame = self.bounds
            if let col = color {
                self.contentView.layer.borderColor = col.cgColor
            }
        }
    }

    var label: UILabel!
    /// 必须在content之前给值
    var color:UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.label = UILabel(frame: CGRect(x: 10, y: 10, width: self.bounds.width - 20, height: self.bounds.height - 20))
        self.label.font = UIFont.systemFont(ofSize: 14.0)
        self.label.textAlignment = .center
        self.label.numberOfLines = 0
        self.contentView.addSubview(self.label)
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.cornerRadius = self.bounds.height/2
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
