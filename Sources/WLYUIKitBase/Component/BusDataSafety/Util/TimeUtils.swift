//
//  TimeUtils.swift
//  加密哭
//
//  Created by 王相博 on 2018/12/18.
//  Copyright © 2018 王相博. All rights reserved.
//

import Foundation

class TimeUtils {
    /**
     * 获取当前时间的日期数字 20181217
     *
     * @return
     */
    
    static func getTimeNum() -> NSInteger {
        
        let dateFormatter = DateFormatter.cicDefault(format: .yyyyMMdd_ns)
        let dateTime = dateFormatter.string(from: Date())
        return Int(dateTime) ?? 1
    }
    /**
     * 获取一个秒级别的时间戳
     *
     * @return
     */
    static func getTimeDefault() -> String {
        let datenow = Date()
        let time = Int(datenow.timeIntervalSince1970)
        return "\(time)"
    }
    
    /**
     * 获取星期日期
     *
     * @return
     */
    static func getWeekNum() -> NSInteger {
        let date = Date()
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let unitFlags = NSCalendar.Unit.year.rawValue | NSCalendar.Unit.month.rawValue | NSCalendar.Unit.day.rawValue | NSCalendar.Unit.weekday.rawValue
        let comps = calendar?.components(NSCalendar.Unit(rawValue: unitFlags), from: date)
        let week = comps?.weekday
        return week ?? 0
        
    }
    /**
     * 获取当前的系统日期时间秒级别
     *
     * @return 到秒级别: 20170420时间戳为 1492617600 1494259200
     */
    static func getTimeCurrent() -> NSInteger {
        let formatter = DateFormatter.cicDefault(format: .yyyyMMddHHmmss)
        var nowtimeStr = formatter.string(from: Date())
        nowtimeStr = String(nowtimeStr.prefix(10))
        nowtimeStr = nowtimeStr + " 00:00:00"
        let newDate = formatter.date(from: nowtimeStr)
        let timeCount:NSInteger = Int(newDate?.timeIntervalSince1970 ?? 1492617600)
        return timeCount
    }
  
}
