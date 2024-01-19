//
//  CicDatePickerView.swift
//  
//
//  Created by Laowang on 2024/1/19.
//

import UIKit

class CicDatePickerView: CicBasePickerView {

    static func showDatePickerWithTitle(_ title: String, type: UIDatePicker.Mode, defaultSelValue: String?, minDateStr: String?, maxDateStr: String?, isAutoSelect: Bool, resultBlock: @escaping (_: String) -> Void) {
        
        let datePickerView = CicDatePickerView(title: title, datePickerMode: type, defaultSelValue: defaultSelValue, minDateStr: minDateStr, maxDateStr: maxDateStr, resultBlock: resultBlock, isAutoSelect: isAutoSelect)
        datePickerView.showWithAnimation()
    }
    
    let datePickerMode: UIDatePicker.Mode
    let title: String
    var minDateStr: String?
    var maxDateStr: String?
    private var resultBlock: (_ selectValue: String) -> Void
    var selectValue: String?
    let isAutoSelect: Bool

    // 时间选择器(默认大小: 320px × 216px)
    lazy var datePicker: UIDatePicker = {
        let _datePicker = UIDatePicker(frame: CGRect(x: 0, y: manager.kTopViewH + 0.5, width: GConfig.ScreenW, height: manager.kPickerViewH))
        _datePicker.backgroundColor = .white
        _datePicker.datePickerMode = datePickerMode
        // 设置该UIDatePicker的国际化Locale，以简体中文习惯显示日期，UIDatePicker控件默认使用iOS系统的国际化Locale
        _datePicker.locale = Locale(identifier: "zh_CHS_CN")
        // 设置时间范围
        if let minDateStr {
            let minDate = toDateWithDateString(dateString: minDateStr)
            _datePicker.minimumDate = minDate
        }
        if let maxDateStr {
            let maxDate = toDateWithDateString(dateString: maxDateStr)
            _datePicker.maximumDate = maxDate
        }
        // 把当前时间赋值给 _datePicker
        _datePicker.setDate(Date(), animated: true)
        
        if #available(iOS 13.4, *) {
            // 设置UIDatePicker的显示模式
            _datePicker.locale = Locale(identifier: "zh_CN")
            _datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        _datePicker.addTarget(self, action: #selector(didSelectValueChanged), for: .valueChanged)
        return _datePicker
    }()
    
    init(title: String, datePickerMode: UIDatePicker.Mode, defaultSelValue: String? = nil, minDateStr: String? = nil, maxDateStr: String? = nil, resultBlock: @escaping (_: String) -> Void, isAutoSelect: Bool) {
        self.datePickerMode = datePickerMode
        self.title = title
        self.minDateStr = minDateStr
        self.maxDateStr = maxDateStr
        self.resultBlock = resultBlock
        self.isAutoSelect = isAutoSelect
        
        if let defaultSelValue, !defaultSelValue.isEmpty {
            self.selectValue = defaultSelValue
        }
        super.init(frame: CGRect.zero)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initUI() {
        super.initUI()
        self.titleLabel.text = title
        // 添加时间选择器
        self.alertView.addSubview(datePicker)
    }
    
    @objc func didSelectValueChanged(sender: UIDatePicker) {
        // 读取日期：datePicker.date
        selectValue = toStringWithDate(date: sender.date)
        GCLog.info("滚动完成后，执行block回调:\(selectValue)")
        // 设置是否开启自动回调
        if isAutoSelect {
            resultBlock(selectValue ?? "-")
        }
    }
    
    override func didTapBackgroundView(sender: UITapGestureRecognizer) {
        dismissWithAnimation()
    }
    
    override func clickLeftBtn() {
        dismissWithAnimation()
    }

    override func clickRightBtn() {
        resultBlock(selectValue ?? "-")
        dismissWithAnimation()
    }
}

extension CicDatePickerView {
    
    func toDateWithDateString(dateString: String) -> Date? {
        let dateFormatter = Cicformatter
        switch datePickerMode {
        case .time:
            dateFormatter.dateFormat = DateFormatterOptions.HHmm.rawValue
        case .date:
            dateFormatter.dateFormat = DateFormatterOptions.yyyyMMdd.rawValue
        case .dateAndTime:
            dateFormatter.dateFormat = DateFormatterOptions.yyyyMMddHHmm.rawValue
        case .countDownTimer:
            dateFormatter.dateFormat = DateFormatterOptions.HHmm.rawValue
        @unknown default:
            break
        }
        let destDate = dateFormatter.date(from: dateString)
        return destDate
    }
    
    func toStringWithDate(date: Date) -> String? {
        let dateFormatter = Cicformatter
        switch datePickerMode {
        case .time:
            dateFormatter.dateFormat = DateFormatterOptions.HHmm.rawValue
        case .date:
            dateFormatter.dateFormat = DateFormatterOptions.yyyyMMdd.rawValue
        case .dateAndTime:
            dateFormatter.dateFormat = DateFormatterOptions.yyyyMMddHHmm.rawValue
        case .countDownTimer:
            dateFormatter.dateFormat = DateFormatterOptions.HHmm.rawValue
        @unknown default:
            break
        }
        
        let destDateString = dateFormatter.string(from: date)
        return destDateString
    }
}


