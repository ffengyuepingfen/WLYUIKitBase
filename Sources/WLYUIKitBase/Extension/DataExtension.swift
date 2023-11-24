//
//  DataExtension.swift
//  Pods-WLYUIKitBase_Example
//
//  Created by wangxiangbo on 2020/5/11.
//

import Foundation

extension Data {
    
    public static func dataWith(str: String)-> Data {
        
        if let d = NSData(base64Encoded: str, options: .ignoreUnknownCharacters) as? Data {
            return d
        }
        return Data()
    }
}

// MARK: - 一、基本的扩展
public extension Data {

    // MARK: 1.1、base64编码成 Data
    /// 编码
    var encodeToData: Data? {
        return self.base64EncodedData()
    }
    
    // MARK: 1.2、base64解码成 Data
    /// 解码成 Data
    var decodeToDada: Data? {
        return Data(base64Encoded: self)
    }
    
    // MARK: 1.3、转成bytes
    /// 转成bytes
    var bytes: [UInt8] {
        return [UInt8](self)
    }
    
    func hexadecimal() -> String {
            return map { String(format: "%02x", $0) }
                .joined(separator: "")
        }
}
