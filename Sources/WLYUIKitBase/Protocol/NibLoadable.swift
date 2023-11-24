//
//  NibLoadable.swift
//  XAOfficialBus
//
//  Created by zhonghangxun on 2018/12/4.
//  Copyright © 2018 zhonghangxun. All rights reserved.
//

import UIKit

public protocol NibLoadable {
}
extension NibLoadable where Self : UIView {
    //在协议里面不允许定义class 只能定义static
    public static func loadFromNib(_ nibname: String? = nil, bundle:Bundle? = nil) -> Self {//Self (大写) 当前类对象
        //self(小写) 当前对象
        let loadName = nibname == nil ? "\(self)" : nibname!

        if bundle == nil {
            return (Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as? Self)!
        }else{
            return (bundle?.loadNibNamed(loadName, owner: nil, options: nil)?.first as? Self)!
        }
    }
}
