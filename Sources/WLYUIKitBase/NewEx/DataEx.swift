//
//  DataExtension.swift
//  Pods-WLYUIKitBase_Example
//
//  Created by wangxiangbo on 2020/5/11.
//

import Foundation

// MARK: - 一、基本的扩展
public extension Data {

    static func dataWith(str: String)-> Data {
        if let d = NSData(base64Encoded: str, options: .ignoreUnknownCharacters) as? Data {
            return d
        }
        return Data()
    }
    
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
    /// 将 Data 转换成十六进制字符串并转为大写
    func hexadecimal() -> String {
        return map { String(format: "%02x", $0) }
            .joined(separator: "")
    }
}


extension Data {
    public struct HexEncodingOptions: OptionSet {
        public let rawValue: Int
        public static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
    
    /// 将 Data 转换成十六进制字符串并转为大写
    /// - Parameter options: 默认是大写
    /// - Returns: 十六进制字符串
    public func hexEncodedString(options: HexEncodingOptions = [.upperCase]) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return map { String(format: format, $0) }.joined()
    }
}
