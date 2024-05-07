//
//  ArrayEx.swift
//  
//
//  Created by Laowang on 2024/4/17.
//

import Foundation

extension Array {
    
    /// Description: 获取数组的内存地址
    ///
    /// - Parameter array: array description
    /// - Returns: return value description
    public func getBufferaddress() -> String {
        return self.withUnsafeBufferPointer {
            return String(describing: $0)
        }
    }

    /// Description：剔除数组中满足条件的元素（我们只要把调用转发给filter，然后把指定的条件取反就好了）
    ///
    /// - Parameter predicate: predicate description
    /// - Returns: return value description
    public func reject(_ predicate: (Element) -> Bool) -> [Element] {
        return filter { !predicate($0) }
    }

    /// 交换两个元素
    public mutating func replaceObject(item: Element, index: NSInteger) {
        self.remove(at: index)
        self.insert(item, at: index)
    }
    /// contains 是 是否有满足条件的
    /// 如果的取反 n没有不满族条件的元素，也就是全部元素都满足了
    func allMatch(_ predicate: (Element) -> Bool) -> Bool {
        return !contains { !predicate($0) }
    }
}


// 安全获取 集合制定位置的元素
extension Collection {
    
    public subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    /// SwifterSwift: Returns an array of slices of length "size" from the array. If array can't be split evenly, the final slice will be the remaining elements.
    ///
    ///     [0, 2, 4, 7].group(by: 2) -> [[0, 2], [4, 7]]
    ///     [0, 2, 4, 7, 6].group(by: 2) -> [[0, 2], [4, 7], [6]]
    ///
    /// - Parameter size: The size of the slices to be returned.
    /// - Returns: grouped self.
    public func group(by size: Int) -> [[Element]]? {
        // Inspired by: https://lodash.com/docs/4.17.4#chunk
        guard size > 0, !isEmpty else { return nil }
        var start = startIndex
        var slices = [[Element]]()
        while start != endIndex {
            let end = index(start, offsetBy: size, limitedBy: endIndex) ?? endIndex
            slices.append(Array(self[start..<end]))
            start = end
        }
        return slices
    }
}

extension Array {
    
    /// 字典转换为JSONString
    public func toJSON() -> String? {
        let array = self
        guard JSONSerialization.isValidJSONObject(array) else {
            GConfig.log("无法解析出JSONString")
            return ""
        }
        let data : NSData = try! JSONSerialization.data(withJSONObject: array, options: []) as NSData
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
    }
    
    // MARK: 1.4、分隔数组
    /// 分隔数组
    /// - Parameter condition: condition description
    /// - Returns: description
    func split(where condition: (Element, Element) -> Bool) -> [[Element]] {
        var result: [[Element]] = self.isEmpty ? [] : [[self[0]]]
        for (previous, current) in zip(self, self.dropFirst()) {
            if condition(previous, current) {
                result.append([current])
            } else {
                result[result.endIndex - 1].append(current)
            }
        }
        return result
    }
    
    /// 从数组中挑出随机的n个元素成新的数组
    /// - Parameters:
    ///   - count: 返回元素的数量,传入0 则返回空数组,大于数组元素数量或者小于0则返回所有元素并打乱顺序
    ///   - duplicates: 是否允许重复的选取某一个下标的元素，默认是false
    /// - Returns: 随机之后的数组
    public func random(count: Int = 0, duplicates: Bool = false) -> Array {
        if count == 0 {
            return []
        }
        var n = count
        if n > self.count || n < 0 {
            n = self.count
        }

        var array: [Element] = []
        var arrayTemp = self
        for _ in 1 ... n {
            let rand = Int(arc4random_uniform(UInt32(arrayTemp.count)))
            array.append(arrayTemp[rand])
            if !duplicates {
                arrayTemp.remove(at: rand)
            }
        }
        return array
    }
    
}

// MARK: - 二、数组 有关索引 的扩展方法
public extension Array where Element : Equatable {
    
    // MARK: 2.1、获取数组中的指定元素的索引值
    /// 获取数组中的指定元素的索引值
    /// - Parameter item: 元素
    /// - Returns: 索引值数组
    func indexes(_ item: Element) -> [Int] {
        var indexes = [Int]()
        for index in 0..<count where self[index] == item {
            indexes.append(index)
        }
        return indexes
    }
    
    // MARK: 2.3、获取元素最后出现的位置
    /// 获取元素最后出现的位置
    /// - Parameter item: 元素
    /// - Returns: 索引值
    func lastIndex(_ item: Element) -> Int? {
        let indexs = indexes(item)
        return indexs.last
    }
}

// MARK: - 三、遵守 Equatable 协议的数组 (增删改查) 扩展
public extension Array where Element : Equatable {
    
    // MARK: 3.1、删除数组的中的元素(可删除第一个出现的或者删除全部出现的)
    /// 删除数组的中的元素(可删除第一个出现的或者删除全部出现的)
    /// - Parameters:
    ///   - element: 要删除的元素
    ///   - isRepeat: 是否删除重复的元素
    @discardableResult
    mutating func remove(_ element: Element, isRepeat: Bool = true) -> Array {
        var removeIndexs: [Int] = []
        
        for i in 0 ..< count {
            if self[i] == element {
                removeIndexs.append(i)
                if !isRepeat { break }
            }
        }
        // 倒序删除
        for index in removeIndexs.reversed() {
            self.remove(at: index)
        }
        return self
    }
    
    // MARK: 3.2、从删除数组中删除一个数组中出现的元素，支持是否重复删除, 否则只删除第一次出现的元素
    /// 从删除数组中删除一个数组中出现的元素，支持是否重复删除, 否则只删除第一次出现的元素
    /// - Parameters:
    ///   - elements: 被删除的数组元素
    ///   - isRepeat: 是否删除重复的元素
    @discardableResult
    mutating func removeArray(_ elements: [Element], isRepeat: Bool = true) -> Array {
        for element in elements {
            if self.contains(element) {
                self.remove(element, isRepeat: isRepeat)
            }
        }
        return self
    }
}

// MARK: - 四、遵守 NSObjectProtocol 协议对应数组的扩展方法
public extension Array where Element : NSObjectProtocol {
    
    // MARK: 4.1、删除数组中遵守NSObjectProtocol协议的元素，是否删除重复的元素
    /// 删除数组中遵守NSObjectProtocol协议的元素
    /// - Parameters:
    ///   - object: 元素
    ///   - isRepeat: 是否删除重复的元素
    @discardableResult
    mutating func remove(object: NSObjectProtocol, isRepeat: Bool = true) -> Array {
        var removeIndexs: [Int] = []
        for i in 0..<count {
            if self[i].isEqual(object) {
                removeIndexs.append(i)
                if !isRepeat {
                    break
                }
            }
        }
        for index in removeIndexs.reversed() {
            self.remove(at: index)
        }
        return self
    }
    
    // MARK: 4.2、删除一个遵守NSObjectProtocol的数组中的元素，支持重复删除
    /// 删除一个遵守NSObjectProtocol的数组中的元素，支持重复删除
    /// - Parameters:
    ///   - objects: 遵守NSObjectProtocol的数组
    ///   - isRepeat: 是否删除重复的元素
    @discardableResult
    mutating func removeArray(objects: [NSObjectProtocol], isRepeat: Bool = true) -> Array {
        for object in objects {
            if self.contains(where: {$0.isEqual(object)} ){
                self.remove(object: object, isRepeat: isRepeat)
            }
        }
        return self
    }
}

// MARK: - 五、针对数组元素是 String 的扩展
public extension Array where Self.Element == String {
    
    // MARK: 5.1、数组转字符转（数组的元素是 字符串），如：["1", "2", "3"] 连接器为 - ，那么转化后为 "1-2-3"
    /// 数组转字符转（数组的元素是 字符串），如：["1", "2", "3"] 连接器为 - ，那么转化后为 "1-2-3"
    /// - Parameter separator: 连接器
    /// - Returns: 转化后的字符串
    func toStrinig(separator: String = "") -> String {
        return self.joined(separator: separator)
    }
}


public extension Array where Element: Hashable {
    
    /// 去除数组中重复的元素，如果有重复的，将优先保留前面的一个。
    /// - Returns: 去重后的新数组
    func removeDuplicates() -> [Element] {
        var newAray: [Element] = []
        var set = Set<Element>()
        for item in self {
            if !set.contains(item) {
                newAray.append(item)
                set.insert(item)
            }
        }
        return newAray
    }
}

public extension Array {
    
    /// 去除数组中重复的元素，如果有重复的，将优先保留前面的一个。
    /// - Parameter keypath: 用于做对比的属性
    /// - Returns: 去重后的新数组
    func removeDuplicates<Value>(by keypath: KeyPath<Element, Value>) -> [Element] where Value: Hashable {
        var newAray: [Element] = []
        var set = Set<Value>()
        for item in self {
            let value = item[keyPath: keypath]
            if !set.contains(value) {
                newAray.append(item)
                set.insert(value)
            }
        }
        return newAray
    }
}
