//
//  File.swift
//  
//
//  Created by Laowang on 2023/5/15.
//

import Foundation
// MARK: - 一、Character 与其他类型的转换
public extension Character {

    // MARK: 1.1、Character 转 String
    /// Character 转 String
    var charToString: String { return String(self) }

    // MARK: 1.2、Character 转 Int
    /// Character 转 Int
    var charToInt: Int? {
        return Int(String(self))
        
    }
}

// MARK: - 二、常用的属性和方法
public extension Character {
    
    // MARK: 2.1、判断是不是 Emoji 表情
    /// 判断是不是 Emoj 表情
    var isEmoji: Bool {
//        return String(self).jk.includesEmoji()
        return false
    }
}
