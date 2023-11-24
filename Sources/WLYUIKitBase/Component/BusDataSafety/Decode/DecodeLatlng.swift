//
//  DecodeLatlng.swift
//  加密哭
//
//  Created by 王相博 on 2018/12/18.
//  Copyright © 2018 王相博. All rights reserved.
//

import Foundation

public class DecodeLatlng {
    
    static public func decode(latlng:String) -> Double {
        var temp = latlng
        // 小数点分割出整数部分
        let integer = temp.components(separatedBy: ".")[0]
        // 小数点分割出小数部分
        var decimal = temp.components(separatedBy: ".")[1]
        while decimal.count < 12 {
            decimal += "0"
        }
        // 截取小数部分最后四位的随机数
        let random = Double(String("0." + decimal.substring(from: 8)))!
        // 获取混淆后的经纬度数值
        temp = integer + "." + decimal.substring(to: 8)
        
        
        // 获取当前系统时间值，时间值为日期的秒级别时间戳加上日期的数字
        let time = TimeUtils.getTimeCurrent() + TimeUtils.getTimeNum()
        // 将当前时间值转换为小数
        var timeNum = Double("0.\(time)")!
        // 于随机数相乘得出混淆数值
        timeNum *= random
        // 保留混淆数值的有效数字八位
//        timeNum = NumFormat.getFormatNum(timeNum, 8);
        timeNum =  Double(temp)! - timeNum
        
        return timeNum
    }
}
