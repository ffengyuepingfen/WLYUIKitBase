////
////  AngXImageViewCollectionViewCell.swift
////  angXinOutsourcing
////
////  Created by 王相博 on 2018/10/28.
////  Copyright © 2018 WXBPre. All rights reserved.
////
//
import UIKit
import WLYUIKitBase

class AngXImageViewCollectionViewCell: UICollectionViewCell {

    lazy var deleteButton: UIButton = {
        let b = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 22, height: 22)))
        b.setImage(UIImage(named: "delete"), for: .normal)
        b.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        return b
    }()
    
    lazy var imageView: UIImageView = {
        let i = UIImageView()
        i.isUserInteractionEnabled = true
        return i
    }()
    
    var deleteBlock:(()->Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviewAnchor(subView: imageView)
        self.addSubviewAnchor(subView: deleteButton, insets: UIEdgeInsets(top: 0, left: bounds.width - 22, bottom: bounds.height - 22, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func deleteAction() {
        if deleteBlock != nil {
            deleteBlock!()
        }
    }
}
