//
//  File.swift
//  
//
//  Created by Laowang on 2023/5/15.
//

import UIKit
import AVFoundation

// MARK: - 一、基本的扩展
public extension Dictionary {
    
    // MARK: 1.1、检查字典里面是否有某个 key
    /// 检查字典里面是否有某个 key
    func has(_ key: Key) -> Bool {
        return index(forKey: key) != nil
    }
    
    // MARK: 1.2、字典的key或者value组成的数组
    /// 字典的key或者value组成的数组
    /// - Parameter map: map
    /// - Returns: 数组
    func toArray<V>(_ map: (Key, Value) -> V) -> [V] {
        return self.map(map)
    }
    
    // MARK: 1.3、JSON字符串 -> 字典
    /// JsonString转为字典
    /// - Parameter json: JSON字符串
    /// - Returns: 字典
    static func jsonToDictionary(json: String) -> Dictionary<String, Any>? {
        if let data = (try? JSONSerialization.jsonObject(
            with: json.data(using: String.Encoding.utf8,allowLossyConversion: true)!,
            options: JSONSerialization.ReadingOptions.mutableContainers)) as? Dictionary<String, Any> {
            return data
        } else {
            return nil
        }
    }
    
    // MARK: 1.4、字典 -> JSON字符串
    /// 字典转换为JSONString
    func toJSON() -> String? {
        if let jsonData = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions()) {
            let jsonStr = String(data: jsonData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            return String(jsonStr ?? "")
        }
        return nil
    }
    
    // MARK: 1.5、字典里面所有的 key
    /// 字典里面所有的key
    /// - Returns: key 数组
    func allKeys() -> [Key] {
        /*
         shuffled：不会改变原数组，返回一个新的随机化的数组。  可以用于let 数组
         */
        return self.keys.shuffled()
    }
    
    // MARK: 1.6、字典里面所有的 value
    /// 字典里面所有的value
    /// - Returns: value 数组
    func allValues() -> [Value] {
        return self.values.shuffled()
    }
    
    // MARK: 1.7、设置value
    subscript<Result>(key: Key, as type: Result.Type) -> Result? {
        get {
            return self[key] as? Result
        }
        set {
            // 如果传⼊ nil, 就删除现存的值。
            guard let value = newValue else {
                self[key] = nil
                return
            }
            // 如果类型不匹配，就忽略掉。
            guard let value2 = value as? Value else {
                return
            }
            self[key] = value2
        }
    }
    
    // MARK: 1.8、设置value
    /// 设置value
    /// - Parameters:
    ///   - keys: key链
    ///   - newValue: 新的value
    @discardableResult
    mutating func setValue(keys: [String], newValue: Any) -> Bool {
        guard keys.count > 1 else {
            guard keys.count == 1, let key = keys[0] as? Dictionary<Key, Value>.Keys.Element else {
                return false
            }
            self[key] = (newValue as! Value)
            return true
        }
        guard let key = keys[0] as? Dictionary<Key, Value>.Keys.Element, self.keys.contains(key), var value1 = self[key] as? [String: Any] else {
            return false
        }
        let result = Dictionary<String, Any>.value(keys: Array(keys[1..<keys.count]), oldValue: &value1, newValue: newValue)
        self[key] = (value1 as! Value)
        return result
    }
    
    /// 字典深层次设置value
    /// - Parameters:
    ///   - keys: key链
    ///   - oldValue: 字典
    ///   - newValue: 新的值
    @discardableResult
    private static func value(keys: [String], oldValue: inout [String: Any], newValue: Any) -> Bool {
        guard keys.count > 1 else {
            oldValue[keys[0]] = newValue
            return true
        }
        guard var value1 = oldValue[keys[0]] as? [String : Any] else { return false}
        let key = Array(keys[1..<keys.count])
        let result = value(keys: key, oldValue: &value1, newValue: newValue)
        oldValue[keys[0]] = value1
        return result
    }
}

// MARK: - 二、其他基本扩展
public extension Dictionary<String, Any> {
    
    // MARK: 2.1、字典转JSON
    /// 字典转JSON
    @discardableResult
    func dictionaryToJson() -> String? {
        if (!JSONSerialization.isValidJSONObject(self)) {
            GConfig.log("无法解析出JSONString")
            return nil
        }
        if let data = try? JSONSerialization.data(withJSONObject: self) {
            let JSONString = NSString(data:data,encoding: String.Encoding.utf8.rawValue)
            return JSONString! as String
        } else {
            GConfig.log("无法解析出JSONString")
            return nil
        }
    }
}

extension Dictionary {
    /*
        由于Dictionary是一个struct，并且merge修改了self，我们必须使用mutating关键字修饰这个方法。而对于sequence参数，我们通过where关键字限定了两个内容
            S必须遵从Sequence protocol，Dictionary是众多遵从了Sequence protocol的collection类型之一，但是，我们没必要一定只能合并Dictionary；
            S的元素类型必须和原Dictionary的Element相同，其中Key和Value是Dictionary声明中的两个反省参数；
     */
    /// 合并key value
    public mutating func merge<S:Sequence>(_ sequence: S)
        where S.Iterator.Element == (key: Key, value: Value) {
            
            sequence.forEach { self[$0] = $1 }
    }
}

/*
    用一个tuple数组初始化Dictionary
    理解了merge的实现和用法之后，其实，我们很容易把这个场景进一步扩展下，如果我们可以merge类型兼容的Sequence，那么，用这样的Sequence来初始化一个Dictionary也是可以的，把它看成是和一个空的Dictionary进行合并就好了
 */
extension Dictionary {
    init<S:Sequence>(_ sequence: S)
        where S.Iterator.Element == (key: Key, value: Value) {
            
            self = [:]
            self.merge(sequence)
    }
}

/// map返回一个Array<RecordType>，但有时，我们仅仅希望对value做一些变换，而仍旧保持Dictionary的类型。为此，我们可以自定义一个“只map value”的方法

extension Dictionary {
    func mapValue<T>(_ transform: (Value) -> T) -> [Key: T] {
        return Dictionary<Key, T>(map { (k, v) in
            return (k, transform(v))
        })
    }
}

//把Set用作内部支持类型
//很多时候，除了把Set作为一个集合类型返回给用户之外，我们还可以把它作为函数的内部支持类型来使用。例如，借助于Set不能包含重复元素的特性，为任意一个序列类型去重
//我们给Sequence添加下面的扩展
extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var result: Set<Iterator.Element> = []
        
        return filter {
            if result.contains($0) {
                return false
            }
            else {
                result.insert($0)
                return true
            }
        }
    }
}
