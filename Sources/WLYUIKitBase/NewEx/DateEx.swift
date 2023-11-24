//
//  DateEx.swift
//  WLYUIKitBase
//
//  Created by Laowang on 2023/11/16.
//

import UIKit

extension Date {
    
    /// 字符串时间按照格式转为 1970 年到现在的秒数
    /// - Parameters:
    ///   - stringTime: 需要转换的时间
    ///   - format: 时间的格式
    /// - Returns: 返回描述
    public static func stringToTimeStamp(stringTime: String, format: DateFormatterOptions = .yyyyMMddHHmm) -> Int {

        let dfmatter = DateFormatter.cicDefault(format: format)
        if let date = dfmatter.date(from: stringTime) {
            let dateStamp: TimeInterval = date.timeIntervalSince1970
            let dateSt: Int = Int(dateStamp)
            return dateSt
        }
        return 0
    }
    
    /// 获取当前时间戳 毫秒
    public static func timeStamp() -> NSInteger {
        let date = Date()
        let dateStamp: TimeInterval = date.timeIntervalSince1970*1000
        let timeStamp: NSInteger = NSInteger(dateStamp)
        return timeStamp
    }
    
    /// 获取当前时间的的字符串格式
    /// 往后延期的天数，默认是0 代表当前
    /// - Returns:
    public static func wlyCurrentDateString(afterDay:NSInteger = 0) -> String {
        //格式话输出
        let dformatter = DateFormatter.cicDefault(format: .yyyyMMdd)
        let destindate = Date(timeInterval: TimeInterval(afterDay*24*60*60), since: Date())
        let timeStr: String = dformatter.string(from: destindate)
        return timeStr
    }
    
    /// 将时间戳转为日期时间
    ///
    /// - Parameter timeStamp:
    /// - Returns:
    public static func timeStampToString(timeStamp: Int, format: DateFormatterOptions = .yyyyMMddHHmm) -> String {

        //转换为时间
        let timeInterval: TimeInterval = TimeInterval(timeStamp)
        let date = Date(timeIntervalSince1970: timeInterval)
        //格式话输出
        let dformatter = DateFormatter.cicDefault(format: format)
        return dformatter.string(from: date)
    }
}
