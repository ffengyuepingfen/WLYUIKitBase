//
//  RandomUtils.swift
//  加密哭
//
//  Created by 王相博 on 2018/12/18.
//  Copyright © 2018 王相博. All rights reserved.
//

import Foundation

class RandomUtils {
    /**
     * 获取1-9的随机数
     *
     * @return 返回随机数
     */
    static func getRandomOneToNine() -> NSInteger {
        return Int.random(in: 1...9)
    }
    
    /**
     * 生成0-1之间的随机数
     *
     * @return 返回随机数
     */
    static func getRandomInOne() -> Double {
        return Double.random(in: 0.1..<1)
    }
    /**
     * 获取2-9的随机数
     *
     * @return 返回2-9的随机数
     */
    static func getRandomTwoToNine() -> NSInteger {
        return Int.random(in: 2...9)
    }
    
    /**
     * 获取[0,10)随机整数
     *
     * @return 随机整数
     */
    static func getRandom() -> Int {
        return Int.random(in: 0...9)
    }
    
    /**
     * 获取[0,1)随机数
     *
     * @return Double随机数
     */
    static func getRandomToDouble() -> Double {
        return Double.random(in: 0..<1)
    }
}
