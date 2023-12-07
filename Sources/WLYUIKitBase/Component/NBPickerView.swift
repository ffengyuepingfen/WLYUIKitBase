//
//  NBPickerView.swift
//  Alamofire
//
//  Created by Laowang on 2023/8/23.
//

import UIKit
#if canImport(OC)
import OC
#endif

public struct NBPickerView {
    
    public static func showPickView(style: CXDatePickerStyle, format: String = "yyyy", callBack: @escaping (String)-> Void) {
        // 年-月
        let datepicker = CXDatePickerView(dateStyle: style, scrollTo: Date()) { result in
            if let re = result as? NSDate, let dateString = re.cx_string(withFormat: format) {
                callBack(dateString)
            }
        }
        datepicker?.datePickerFont = UIFont.systemFont(ofSize: 17)
        datepicker?.dateUnitLabelColor = UIColor.systemBlue;//年-月-日-时-分 颜色
        datepicker?.datePickerColor = UIColor.black//滚轮日期颜色
        datepicker?.doneButtonColor = UIColor.systemBlue//确定按钮的颜色
        datepicker?.cancelButtonColor = UIColor.black
        datepicker?.show()
    }
} 
