//
//  IdentifierProtocol.swift
//  DynamicBusClient
//
//  Created by zhonghangxun on 2019/7/12.
//  Copyright © 2019 WLY. All rights reserved.
//

import UIKit

public protocol IdentifierProtocol {}

extension IdentifierProtocol {
    public static var identifier: String {
        return String(describing: self) + "Identifier"
    }
    
    public static var className:String {
        return String(describing: self)
    }
}

