//
//  DecodeBusNum.swift
//  加密哭
//
//  Created by 王相博 on 2018/12/18.
//  Copyright © 2018 王相博. All rights reserved.
//

import Foundation
/// 车牌号
public class DecodeBusNum {
 
    static public func decode(busNum :String) -> String {
        
        if busNum == "" {
            return ""
        }
        
        // 时间的余值再余周次+1
        let transfer:Int = TimeUtils.getTimeCurrent()%TimeUtils.getTimeNum()%TimeUtils.getWeekNum() + 1
        // 分切出两部分，去掉车牌号码第一位汉字，只对后边进行混淆
        let preBusNum:String = busNum.substring(to: 1)
        let leaNum:String = busNum.substring(from: 1)
        var newbusNum:String = leaNum
        
        for _ in 0..<transfer {
            for (index,value) in newbusNum.enumerated() {
                newbusNum.swapAtDe(index: index, c: Character(getTransferNum(c: String(value))))
            }
        }
        newbusNum = preBusNum.appending(newbusNum)
        return newbusNum
    }
    /**
     * 数值转换
     * <p>
     */
    static private func getTransferNum(c:String) -> String {
        switch c {
        case "0":
            return "6"
        case "1":
            return "4"
        case "2":
            return "8"
        case "3":
            return "7"
        case "4":
            return "3"
        case "5":
            return "1"
        case "6":
            return "0"
        case "7":
            return "2"
        case "8":
            return "9"
        case "9":
            return "5"
        default:
            return c
        }
    }
}
