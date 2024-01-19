//
//  CicPickerView.swift
//  
//
//  Created by Laowang on 2024/1/19.
//

import UIKit

public struct CicPickerView {

    /**
     *  显示自定义字符串选择器     自定义

     *  @param title            标题
     *  @param dataSource       数组数据源  单行@[@"ha",@"haha"]    多行@[@[@"ha",@"haha"],@[@"ha",@"haha"]]
     *  @param defaultSelValue  默认选中的行(单列传字符串，多列传一维数组)
     *  @param isAutoSelect     是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值
     *  @param resultBlock      选择后的回调
     *
     */
    public static func showStringPickerWithTitle(_ title: String,dataSource: [String], defaultSelValue: String?, isAutoSelect: Bool, resultBlock: @escaping (_: String) -> Void) {
        
        CicStringPickerView.showStringPickerWithTitle(title, dataSource: dataSource, defaultSelValue: defaultSelValue, isAutoSelect: isAutoSelect, resultBlock: resultBlock)
    }
    
    public static func showStringPickerWithTitle(_ title: String, type: DatePickerStyle, defaultSelValue: String?, isAutoSelect: Bool, resultBlock: @escaping (_ selectValue: String) -> Void) {
        
        CicStringPickerView.showStringPickerWithTitle(title, type: type, defaultSelValue: defaultSelValue, isAutoSelect: isAutoSelect, resultBlock: resultBlock)
    }
    
    /**
     *  显示时间选择器
     *
     *  @param title            标题
     *  @param type             类型（时间、日期、日期和时间、倒计时）
     *  @param defaultSelValue  默认选中的时间（为空，默认选中现在的时间）
     *  @param minDateStr       最小时间（如：2015-08-28 00:00:00），可为空
     *  @param maxDateStr       最大时间（如：2018-05-05 00:00:00），可为空
     *  @param isAutoSelect     是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值
     *  @param resultBlock      选择结果的回调
     *
     */
    public static func showDatePickerWithTitle(_ title: String, type: UIDatePicker.Mode, defaultSelValue: String? = nil, minDateStr: String? = nil, maxDateStr: String? = nil, isAutoSelect: Bool, resultBlock: @escaping (_: String) -> Void) {
        CicDatePickerView.showDatePickerWithTitle(title, type: type, defaultSelValue: defaultSelValue, minDateStr: minDateStr, maxDateStr: maxDateStr, isAutoSelect: isAutoSelect, resultBlock: resultBlock)
    }
    
    
}
