//
//  DateFormatterEx.swift
//  WLYUIKitBase
//
//  Created by Laowang on 2023/11/16.
//

import UIKit

public enum DateFormatterOptions: String {
    case yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"
    case yyyyMMddHHmm = "yyyy-MM-dd HH:mm"
    case yyyyMMdd = "yyyy-MM-dd"
    case yyyyMM = "yyyy-MM"
    case HHmmss = "HH:mm:ss"
    case HHmm = "HH:mm"
    
    
    case yyyyMMddHHmmss_zh = "yyyy年MM月dd日 HH:mm:ss"
    
    /// 服务器时间格式
    case Server = "EEE, dd MMMM yyyy HH:mm:ss Z"
    ///  无格式
    case yyyyMMdd_ns = "yyyyMMdd"
}

let Cicformatter = DateFormatter()

extension DateFormatter {
    
    /// 获取时间格式 默认全格式
    /// - Parameter formatStr:  yyyy-MM-dd HH:mm:ss
    /// - Returns: 返回时间格式
    static public func cicDefault(format: DateFormatterOptions) -> DateFormatter {
        let formatter = Cicformatter
        formatter.dateFormat = format.rawValue
        formatter.timeZone = NSTimeZone.system
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.calendar = Calendar.init(identifier: .iso8601)
        return formatter
    }
    
    static public func cicDefault(formatStr: String = "yyyy-MM-dd HH:mm:ss") -> DateFormatter {
        let formatter = Cicformatter
        formatter.dateFormat = formatStr
        formatter.timeZone = NSTimeZone.system
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.calendar = Calendar.init(identifier: .iso8601)
        return formatter
    }
    
    static public func yyyyMMddHHmm() -> DateFormatter {
        return DateFormatter.cicDefault(format: .yyyyMMddHHmm)
    }
    
    static public func yyyyMMdd() -> DateFormatter {
        return DateFormatter.cicDefault(format: .yyyyMMdd)
    }
    
    static public func yyyyMM() -> DateFormatter {
        return DateFormatter.cicDefault(format: .yyyyMM)
    }
    
    static public func HHmmss() -> DateFormatter {
        return DateFormatter.cicDefault(format: .HHmmss)
    }
}

/*
 NSDateFormatter
 
 G:公元时代， 例如AD公元
 
 yy:年后的2位
 
 yyyy:完整年
 
 MM:月，显示为1-12
 
 MMM:月，显示为英文月分简写，如: Jan
 
 MMMM:月， 显示为英文月分全称,July
 
 dd:日， 2位数表示，如02
 
 d:日,1-2位显示， 如2
 
 EEE: 简写星期几，如Sun
 
 EEEE:全写星期几，如Sunday
 
 aa:上下午，AM/PM
 
 H:时，24小时制，0-23
 
 K:时，12小时制，0-11
 
 m:分，1-2位
 
 mm:分，2位
 
 s:秒，1-2位
 
 ss:秒: 2位
 
 S:毫秒
 
 Z:GMT
 */
