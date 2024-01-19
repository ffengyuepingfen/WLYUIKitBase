//
//  File.swift
//  
//
//  Created by Laowang on 2024/1/19.
//

import UIKit

/**
 *  弹出日期类型
 */
public enum DatePickerStyle {
    case CustomStr
    case DateYear
}

struct DatePickerManager {
    
    static let MAXYEAR = 2099
    static let MINYEAR = 1949
   
    static var yearArray: [String] {
        var year: [String] = []
        for item in MINYEAR...MAXYEAR {
            year.append("\(item)年")
        }
        return year
    }

    static var monthArray: [String] {
        var month: [String] = []
        for item in 1...12 {
            month.append("\(item)月")
        }
        return month
    }
    // 通过年月求每月天数
    static func getDayArray(year: Int, month: Int) -> [String] {
        // 判断是不是闰年
        let isLeapYear = year % 4 == 0 ? (month % 100 == 0 ? (year % 400 == 0 ? true : false) : true) : false
        
        switch month {
            case 1,3,5,7,8,10,12:
                return ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
            case 4,6,9,11:
            return ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"]
                
            case 2:
                if isLeapYear {
                    return ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29"]
                }else{
                    return ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28"]
                }
            default:
                return []
        }
    }
}
