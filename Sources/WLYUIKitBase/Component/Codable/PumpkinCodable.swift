//
//  PumpkinCodable.swift
//  codable
//
//  Created by 王相博 on 2018/10/21.
//  Copyright © 2018 王相博. All rights reserved.
//

import Foundation

enum MyCustomErrorType: Error {
    case errorReason
}

public func pumpkinDecoder<T>(jsonstr: String?, modelType: T.Type) throws -> T where T: Codable {
    
    if let json = jsonstr, json != "" {
        // 1. Create a data object
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        do {
            let episode = try decoder.decode(modelType, from: data)
            return episode
        } catch DecodingError.dataCorrupted(let error) {
            GConfig.log("=============")
            GConfig.log("\(error.debugDescription)")
            throw MyCustomErrorType.errorReason
        }
    }else{
        throw MyCustomErrorType.errorReason
    }
}

/// Description base64 有问题
///
/// - Parameter model: model description
/// - Returns: return value description
public func pumpkinEncoder<T: Codable>( model: T) -> String {
    let encoder = JSONEncoder()
    /// 为了让这个结果打印出来好看一些
    guard let data = try? encoder.encode(model) else { return "" }
    return String(data: data, encoding: .utf8) ?? ""
}

/// 处理json 值缺失的情况 和 默认值
///
///
public protocol DefaultValue {
    associatedtype Value: Codable
    static var defaultValue: Value { get }
}

@propertyWrapper
public struct Default<T: DefaultValue> {
    public var wrappedValue: T.Value
    
    public init(wrappedValue: T.Value) {
        self.wrappedValue = wrappedValue
    }
}

extension Default: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = (try? container.decode(T.Value.self)) ?? T.defaultValue
    }
}

extension Default: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

extension KeyedDecodingContainer {
    public func decode<T>(_ type: Default<T>.Type, forKey key: Key) throws -> Default<T> where T: DefaultValue {
        //判断 key 缺失的情况，提供默认值
        (try decodeIfPresent(type, forKey: key)) ?? Default(wrappedValue: T.defaultValue)
    }
}

/// 设置多种默认值的情况
extension String: DefaultValue {
    
    public static var defaultValue = "-"
    
    public struct Empty: DefaultValue {
        public static var defaultValue = ""
    }
    public struct Zero: DefaultValue {
        public static var defaultValue = "0"
    }
    
    public struct One: DefaultValue {
        public static var defaultValue = "1"
    }
    
    /// 如何能把颜色从外部穿进去
    public struct Color: DefaultValue {
        public static var defaultValue = ""
    }
}

