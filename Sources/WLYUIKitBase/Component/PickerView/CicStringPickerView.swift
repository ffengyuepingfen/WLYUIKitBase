//
//  CicStringPickerView.swift
//  
//
//  Created by Laowang on 2024/1/19.
//

import UIKit

class CicStringPickerView: CicBasePickerView {

    /// 字符串选择器(默认大小: 320px × 216px)
    lazy var pickerView: UIPickerView = {
        let _pickerView = UIPickerView(frame: CGRect(x: 0, y: manager.kTopViewH + 0.5, width: GConfig.ScreenW, height: manager.kPickerViewH))
        _pickerView.backgroundColor = UIColor.white
        _pickerView.dataSource = self
        _pickerView.delegate = self
        
        if let index = dataSource.firstIndex(of: selectedItem) {
            _pickerView.selectRow(index, inComponent: 0, animated: true)
        }
        return _pickerView
    }()
    // 是否是单列
    let isSingleColumn: Bool = true
    // 数据源是否合法（数组的元素类型只能是字符串或数组类型）
    var isDataSourceValid: Bool = true
    let title: String
    let dataSource: [String]
    // 是否开启自动选择
    let isAutoSelect: Bool
    private var resultBlock: (_ selectValue: String) -> Void

    private var type: DatePickerStyle = .CustomStr
    
    var selectedItem: String = "-"

    // 多列选中的项
//    let selectedItems: [String]
    
    /**
     *  显示自定义字符串选择器
     *
     *  @param title            标题
     *  @param dataSource       数组数据源
     *  @param defaultSelValue  默认选中的行(单列传字符串，多列传字符串数组)
     *  @param isAutoSelect     是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值
     *  @param resultBlock      选择后的回调
     *
     */
    static func showStringPickerWithTitle(_ title: String, dataSource: [String], defaultSelValue: String?, isAutoSelect: Bool, resultBlock: @escaping (_ selectValue: String) -> Void) {
        if (dataSource == nil || dataSource.count == 0) {
            return;
        }
        
        let strPickerView = CicStringPickerView(title: title, dataSource: dataSource, defaultSelValue: defaultSelValue, isAutoSelect: isAutoSelect, resultBlock: resultBlock)
        strPickerView.showWithAnimation()
    }
    
    static func showStringPickerWithTitle(_ title: String, type: DatePickerStyle, isAutoSelect: Bool, resultBlock: @escaping (_ selectValue: String) -> Void) {
        
        let strPickerView = CicStringPickerView(title: title, type: type, isAutoSelect: isAutoSelect, resultBlock: resultBlock)
        strPickerView.showWithAnimation()
    }
    
    private var years: [String] = []
    private var months: [String] = []
    var selectYear: String = ""
    var selectMonth: String = ""
    
    init(title: String, type: DatePickerStyle, isAutoSelect: Bool, resultBlock: @escaping (_: String) -> Void, manager: CicPickerConfig = CicPickerConfig()) {
        self.title = title
        self.type = type
        self.isAutoSelect = isAutoSelect
        self.resultBlock = resultBlock
        self.dataSource = []
        
        super.init(frame: CGRect.zero)
        self.manager = manager
        loadData()
        initUI()
        
        switch type {
        case .DateYearMonths:
            years = DatePickerManager.yearArray
            months = DatePickerManager.monthArray
            self.selectYear = "\(Date().year)"
            self.selectMonth = "\(Date().month)"
            self.selectedItem = "\(Date().year)-\(Date().month)"
            let yearIndex = (Date().year - DatePickerManager.MINYEAR)
            let monthIndex = Date().month - 1
            pickerView.selectRow(yearIndex, inComponent: 0, animated: true)
            pickerView.selectRow(monthIndex, inComponent: 1, animated: true)
        case .DateYears:
            years = DatePickerManager.yearArray
            self.selectYear = "\(Date().year)"
            self.selectedItem = "\(Date().year)"
            let yearIndex = (Date().year - DatePickerManager.MINYEAR)
            self.pickerView.selectRow(yearIndex, inComponent: 0, animated: true)
        default:
            self.selectedItem = ""
            break
        }
    }
    
    init(title: String, dataSource: [String], defaultSelValue: String?, isAutoSelect: Bool, resultBlock: @escaping (_: String) -> Void, manager: CicPickerConfig = CicPickerConfig()) {
        self.title = title
        self.dataSource = dataSource
        self.isAutoSelect = isAutoSelect
        self.resultBlock = resultBlock
        
        if let defaultSelValue {
            self.selectedItem = defaultSelValue
        }else{
            self.selectedItem = dataSource.first ?? ""
        }
        super.init(frame: CGRect.zero)
        self.manager = manager
        loadData()
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initUI() {
        super.initUI()
        self.titleLabel.text = self.title
        // 添加字符串选择器
        self.alertView.addSubview(pickerView)
    }
   
    func loadData() {
        if type == .CustomStr ,dataSource.isEmpty {
            self.isDataSourceValid = false
        }
    }
   
    override func didTapBackgroundView(sender: UITapGestureRecognizer) {
        dismissWithAnimation()
    }
 
    // 取消按钮的点击事件
    override func clickLeftBtn() {
        dismissWithAnimation()
    }
    /// 确定按钮的点击事件
    override func clickRightBtn() {

        resultBlock(selectedItem)
        dismissWithAnimation()
        
    }
}

extension CicStringPickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch type {
        case .CustomStr:
            return 1
        case .DateYearMonths:
            return 2
        case .DateYears:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch type {
        case .CustomStr:
            return dataSource.count
        case .DateYearMonths:
            if component == 0 {
                return years.count
            }else{
                return months.count
            }
        case .DateYears:
            return years.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch type {
        case .CustomStr:
            return dataSource[row]
        case .DateYearMonths:
            if component == 0 {
                return years[row]
            }else{
                return months[row]
            }
        case .DateYears:
            return years[row]
        }
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch type {
        case .CustomStr:
            self.selectedItem = dataSource[row]
        case .DateYearMonths:
            if component == 0 {
                self.selectYear = years[row].removeSomeStringUseSomeString(removeString: "年")
            }else {
                self.selectMonth = months[row].removeSomeStringUseSomeString(removeString: "月")
            }
            self.selectedItem = selectYear + "-" + selectMonth
        case .DateYears:
            self.selectedItem = years[row].removeSomeStringUseSomeString(removeString: "年")
        }
        // 设置是否自动回调
        if isAutoSelect {
            resultBlock(selectedItem)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        //设置分割线的颜色
        for singleLine in pickerView.subviews {
            if singleLine.frame.size.height < 1 {
                singleLine.backgroundColor =  UIColor.init(white: 0.93, alpha: 1)
            }
        }
        //可以通过自定义label达到自定义pickerview展示数据的方式
        var pickerLabel: UILabel?
        if let l =  view as? UILabel {
            pickerLabel = l
        }else {
            var labelWidth  = GConfig.ScreenW - 30
            if type == .DateYearMonths {
                labelWidth = (GConfig.ScreenW - 30)/2
            }
            let l = UILabel(frame: CGRect(x: 0, y: 0, width: labelWidth, height: 40))
            l.adjustsFontSizeToFitWidth = true
            l.textAlignment = .center
            l.backgroundColor = .white
            l.font = UIFont.systemFont(ofSize: manager.pickerTitleSize)
            l.textColor = manager.pickerTitleColor
            pickerLabel = l
        }
        
        switch type {
        case .CustomStr:
            pickerLabel?.text = dataSource[row]
        case .DateYearMonths:
            if component == 0 {
                pickerLabel?.text = years[row]
            }else {
                pickerLabel?.text = months[row]
            }
        case .DateYears:
            pickerLabel?.text = years[row]
        }
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
}


//- (UILabel *)backYearView {
//    if (!_backYearView) {
//        _backYearView = [[UILabel alloc] initWithFrame:CGRectMake(PickerPointX, PickerPointY, PickerWeight, PickerHeight)];
//        _backYearView.textAlignment = NSTextAlignmentCenter;
//        _backYearView.font = [UIFont systemFontOfSize:110];
//        _backYearView.textColor =  RGB(228, 232, 239);
//    }
//    return _backYearView;
//}
