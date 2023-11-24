//
//  DecimalNumber.swift
//  WLYUIKitBase
//
//  Created by CictecMacMini on 2020/10/19.
//

/**
    关于浮点数据的精确处理
 */
import Foundation

extension String {
    
    /// 返回精度的 字符串 代表的单位是分
    /// - Parameter scale: 保留的小数位
    /// - Returns: 返回结构化的字符串
    public func toPrice(scale:Int16 = 2) -> String {
        
        guard let input = Int(self) else {
            return "-"
        }
        let inputNumber = NSDecimalNumber(string: "\(Double(input)/100.0)")
        let number = inputNumber.rounding(accordingToBehavior: String.priceHandler(scale: scale))
        return "\(number)"
    }
    
    /// 返回精度的 字符串 代表的单位是元
    /// - Parameter scale: 保留的小数位
    /// - Returns: 返回结构化的字符串
    public func toOldPrice(scale:Int16 = 2) -> String {
        
        let inputNumber = NSDecimalNumber(string: "\(self)")
        let number = inputNumber.rounding(accordingToBehavior: String.priceHandler(scale: scale))
        return "\(number)"
    }
    
    /// 拿到金钱类型的handle
    static func priceHandler(scale:Int16 = 2) -> NSDecimalNumberHandler {
        return NSDecimalNumberHandler(roundingMode: .plain,
                                      scale: scale,
                                      raiseOnExactness: false,
                                      raiseOnOverflow: false,
                                      raiseOnUnderflow: false,
                                      raiseOnDivideByZero: true)
    }
    /// 安全Double
    public func toSafeDouble() -> Double {
        guard let input = Double(self) else {
            return 0
        }
        return input
    }
    
}

extension Double {
    
    /// 返回精度的 字符串 代表的单位是分
    /// - Parameter scale: 保留的小数位
    /// - Returns: 返回结构化的字符串
    public func toPrice(scale:Int16 = 2) -> String {
        
        let inputNumber = NSDecimalNumber(string: "\(self/100.0)")
        let number = inputNumber.rounding(accordingToBehavior: String.priceHandler(scale: scale))
        return "\(number)"
    }
    /// 返回精度的 字符串 代表的单位是元
    /// - Parameter scale: 保留的小数位
    /// - Returns: 返回结构化的字符串
    public func toNomalPrice(scale:Int16 = 2) -> String {
        
        let inputNumber = NSDecimalNumber(string: "\(self)")
        let number = inputNumber.rounding(accordingToBehavior: String.priceHandler(scale: scale))
        return "\(number)"
    }
    
    public func toKm(scale:Int16 = 2) -> String {
        
        let inputNumber = NSDecimalNumber(string: "\(Double(self)/1000.0)")
        let number = inputNumber.rounding(accordingToBehavior: String.priceHandler(scale: scale))
        return "\(number)"
    }
}

//extension NSInteger {
//
//    public func toKm(scale:Int16 = 2) -> String {
//
//        let inputNumber = NSDecimalNumber(string: "\(Double(self)/1000.0)")
//        let number = inputNumber.rounding(accordingToBehavior: String.priceHandler(scale: scale))
//        return "\(number)"
//    }
//
//}


// MARK: - 苹果针对浮点类型计算精度问题提供出来的计算类
/// NSDecimalNumberHandler 苹果针对浮点类型计算精度问题提供出来的计算类
/**
 初始化方法
 roundingMode 舍入方式
 scale 小数点后舍入值的位数
 raiseOnExactness 精度错误处理
 raiseOnOverflow 溢出错误处理
 raiseOnUnderflow 下溢错误处理
 raiseOnDivideByZero 除以0的错误处理
 */
/**
 public enum RoundingMode : UInt {
 case plain = 0 是四舍五入
 case down = 1 是向下取整
 case up = 2 是向上取整
 case bankers = 3 是在四舍五入的基础上，加上末尾数为5时，变成偶数的规则
 }
 */

/// 计算的类型
public enum DecimalNumberHandlerType: String {
    // 加
    case add
    // 减
    case subtracting
    // 乘
    case multiplying
    // 除
    case dividing
}

// MARK: - 一、基本的扩展
public extension NSDecimalNumberHandler {
    
    // MARK: 1.1、向下取整取倍数
    /// 向下取整取倍数
    /// - Parameters:
    ///   - value1: 除数
    ///   - value2: 被除数
    /// - Returns: 值
    static func getFloorIntValue(value1: Any, value2: Any) -> Int {
        return decimalNumberHandlerValue(type: .dividing, value1: value1, value2: value2, roundingMode: .down, scale: 0, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false).intValue
    }
    
    // MARK: 1.2、一个数字能否整除另外一个数字
    static func isDivisible(value1: Any, value2: Any) -> Bool {
        let value = decimalNumberHandlerValue(type: .dividing, value1: value1, value2: value2, roundingMode: .down, scale: 3, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false).stringValue
        let valueArray = value.separatedByString(with: ".")
        // 没有小数代表是整除
        guard valueArray.count > 1 else {
            return true
        }
        // 有小数的情况
        guard valueArray.count > 1, let decimalValue = valueArray[1] as? String, decimalValue.count == 1, decimalValue == "0" else {
            return false
        }
        return true
    }
    
    // MARK:1.3、两个数字之间的计算
    /// 两个数字之间的计算
    /// - Parameters:
    ///   - type: 计算的类型
    ///   - value1: 值
    ///   - value2: 值
    /// - Returns: 计算结果
    static func calculation(type: DecimalNumberHandlerType, value1: Any, value2: Any) -> NSDecimalNumber {
        return decimalNumberHandlerValue(type: type, value1: value1, value2: value2, roundingMode: .down, scale: 30, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
    }
}

// MARK: - public 公有方法
public extension NSDecimalNumberHandler {
    
    /// 两个数的：加 减 乘 除
    /// - Parameters:
    ///   - type: 计算的类型
    ///   - value1: 第一个值
    ///   - value2: 第二个人值
    ///   - roundingMode: 舍入方式
    ///   - scale: 小数点后舍入值的位数
    ///   - exact:  精度错误处理
    ///   - overflow: 溢出错误处理
    ///   - underflow: 下溢错误处理
    ///   - divideByZero: 除以0的错误处理
    /// - Returns: NSDecimalNumber
    static func decimalNumberHandlerValue(type: DecimalNumberHandlerType ,value1: Any, value2: Any, roundingMode: NSDecimalNumber.RoundingMode, scale: Int16, raiseOnExactness exact: Bool, raiseOnOverflow overflow: Bool, raiseOnUnderflow underflow: Bool, raiseOnDivideByZero divideByZero: Bool) -> NSDecimalNumber {

        let amountHandler = NSDecimalNumberHandler(roundingMode: roundingMode, scale: scale, raiseOnExactness: exact, raiseOnOverflow: overflow, raiseOnUnderflow: underflow, raiseOnDivideByZero: divideByZero)
        let oneNumber = NSDecimalNumber(string: "\(value1)")
        let twoNumber = NSDecimalNumber(string: "\(value2)")
        
        var result = NSDecimalNumber()
        if type == .add {
            result = oneNumber.adding(twoNumber, withBehavior: amountHandler)
        } else if type == .subtracting {
            result = oneNumber.subtracting(twoNumber, withBehavior: amountHandler)
        } else if type == .multiplying {
            result = oneNumber.multiplying(by: twoNumber, withBehavior: amountHandler)
        } else if type == .dividing {
            result = oneNumber.dividing(by: twoNumber, withBehavior: amountHandler)
        }
        return result
    }
}

// MARK: - 一、基本的扩展用法
extension NumberFormatter {
    
    // MARK: 1.1、将Float数字转成格式化后的字符串
    /// 将数字转成字格式化后的符串
    /// - Parameters:
    ///   - value: 值
    ///   - nstyle: 相应的显示样式
    /// - Returns: 格式化后的字符串
    public static func numberFormatting(value: Float, number nstyle: NumberFormatter.Style = .none) -> String {
        //原始数字（需要先转成NSNumber类型）
        let number = NSNumber(value: value)
        /**
         NumberFormatter.Style
         .none：四舍五入的整数
         .decimal：小数形式（以国际化格式输出 保留三位小数,第四位小数四舍五入）
         .percent：百分数形式
         .scientific：科学计数
         .spellOut：朗读形式（英文表示）
         .ordinal：序数形式
         .currency：货币形式（以货币通用格式输出 保留2位小数,第三位小数四舍五入,在前面添加货币符号）
         .currencyISOCode：货币形式
         .currencyPlural：货币形式
         .currencyAccounting：会计计数
         */
        return NumberFormatter.localizedString(from: number, number: nstyle)
    }
    
    // MARK: 1.2、将Double数字转成格式化后的字符串
    /// 将数字转成格式化后的字符串
    /// - Parameters:
    ///   - value: 值
    ///   - nstyle: 相应的显示样式
    /// - Returns: 格式化后的字符串
    public static func numberFormatting(value: Double, number nstyle: NumberFormatter.Style = .none) -> String {
        //原始数字（需要先转成NSNumber类型）
        let number = NSNumber(value: value)
        return NumberFormatter.localizedString(from: number, number: nstyle)
    }
    
    // MARK: 1.3、字符串转为格式化后的数字
    /// 将数字转成格式化后的字符串
    /// - Parameters:
    ///   - value: 值
    ///   - nstyle: 相应的显示样式
    /// - Returns: 格式化后的字符串
    public static func stringFormattingNumber(value: String, number nstyle: NumberFormatter.Style = .none) -> String? {
        // 从字符串装成数字
        guard let number = NumberFormatter().number(from: value) else {
            // fatalError("数值有问题")
            return nil
        }
        return NumberFormatter.localizedString(from: number, number: nstyle)
    }
}

// MARK: - 二、进阶扩展用法
extension NumberFormatter {
    
    // MARK: 2.1、通用数字格式化
    /// 通用数字格式化
    /// - Parameters:
    ///   - value: 值
    ///   - numberFormatter: 格式化
    /// - Returns: 格式化后的值
    public static func customFormatter(value: String, numberFormatter: NumberFormatter) -> String? {
        // 从字符串装成数字
        guard let number = NumberFormatter().number(from: value) else {
            // fatalError("数值有问题")
            return nil
        }
        // 格式化
        guard let formatValue = numberFormatter.string(from: number) else {
            return nil
        }
        return formatValue
    }
    
    // MARK: 2.2、修改分割符、分割位数
    /// 修改分割符、分割位数
    /// - Parameters:
    ///   - value: 值
    ///   - separator: 分隔符号
    ///   - groupingSize: 分隔位数
    ///   - nstyle: 显示样式
    /// - Returns: 格式化后的值
    public static func setGroupingSeparatorAndSize(value: String, separator: String, groupingSize: Int, number nstyle: NumberFormatter.Style = .none) -> String? {
        // 创建一个NumberFormatter对象
        let numberFormatter = NumberFormatter()
        // 设置number显示样式
        numberFormatter.numberStyle = nstyle
        // 设置用组分隔
        numberFormatter.usesGroupingSeparator = true
        // 分隔符号
        numberFormatter.groupingSeparator = separator
        // 分隔位数
        numberFormatter.groupingSize = groupingSize
        return customFormatter(value: value, numberFormatter: numberFormatter)
    }
    
    // MARK: 2.3、设置格式宽度、填充符、填充位置
    /// 设置格式宽度、填充符、填充位置
    /// - Parameters:
    ///   - value: 值
    ///   - formatWidth: 补齐位数
    ///   - paddingCharacter: 不足位数补齐符
    ///   - paddingPosition: 补在的位置，默认：补在前面
    ///   - nstyle: 显示样式
    /// - Returns: 格式化后的值
    public static func setFormatWidthPaddingCharacterAndPosition(value: String, formatWidth: Int, paddingCharacter: String, paddingPosition: NumberFormatter.PadPosition = .beforePrefix, number nstyle: NumberFormatter.Style = .none) -> String? {
        // 创建一个NumberFormatter对象
        let numberFormatter = NumberFormatter()
        // 设置number显示样式
        numberFormatter.numberStyle = nstyle
        numberFormatter.formatWidth = formatWidth
        numberFormatter.paddingCharacter = paddingCharacter
        numberFormatter.paddingPosition = paddingPosition
        return customFormatter(value: value, numberFormatter: numberFormatter)
    }
    
    // MARK: 2.4、设置最大整数位数、最小整数位数
    /// 设置最大整数位数、最小整数位数
    /// - Parameters:
    ///   - value: 值
    ///   - maximumIntegerDigits: 设置最大整数位数（超过的直接截断）
    ///   - minimumIntegerDigits: 设置最小整数位数（不足的前面补0）
    ///   - nstyle: 显示样式
    /// - Returns: 格式化后的值
    public static func setMaximumIntegerDigitsAndMinimumIntegerDigits(value: String, maximumIntegerDigits: Int, minimumIntegerDigits: Int, number nstyle: NumberFormatter.Style = .none) -> String? {
        // 创建一个NumberFormatter对象
        let numberFormatter = NumberFormatter()
        // 设置number显示样式
        numberFormatter.numberStyle = nstyle
        numberFormatter.maximumIntegerDigits = maximumIntegerDigits
        numberFormatter.minimumIntegerDigits = minimumIntegerDigits
        return customFormatter(value: value, numberFormatter: numberFormatter)
    }
    
    // MARK: 2.5、设置最大小数位数、最小小数位数
    /// 设置最大小数位数、最小小数位数
    /// - Parameters:
    ///   - value: 值
    ///   - maximumIntegerDigits: 设置小数点后最多位数
    ///   - minimumIntegerDigits: 设置小数点后最少位数
    ///   - nstyle: 显示样式
    /// - Returns: 格式化后的值
    public static func setmMximumFractionDigitsAndMinimumFractionDigits(value: String, maximumFractionDigits: Int, minimumFractionDigits: Int) -> String? {
        // 创建一个NumberFormatter对象
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = maximumFractionDigits
        numberFormatter.minimumFractionDigits = minimumFractionDigits
        return customFormatter(value: value, numberFormatter: numberFormatter)
    }
    
    // MARK: 2.6、设置前缀、后缀
    /// 设置前缀、后缀
    /// - Parameters:
    ///   - value: 值
    ///   - positivePrefix: 自定义前缀
    ///   - positiveSuffix: 自定义后缀
    ///   - nstyle: 显示样式
    /// - Returns: 格式化后的值
    public static func setMaximumIntegerDigitsAndMinimumIntegerDigits(value: String, positivePrefix: String, positiveSuffix: String, number nstyle: NumberFormatter.Style = .none) -> String? {
        // 创建一个NumberFormatter对象
        let numberFormatter = NumberFormatter()
        // 设置number显示样式
        numberFormatter.numberStyle = nstyle
        numberFormatter.positivePrefix = positivePrefix
        numberFormatter.positiveSuffix = positiveSuffix
        return customFormatter(value: value, numberFormatter: numberFormatter)
    }
    
    // MARK: 2.7、设置格式化字符串
    /// 设置格式化字符串
    /// - Parameters:
    ///   - value: 值
    ///   - positiveFormat: 设置格式
    ///   - nstyle: 显示样式
    /// - Returns: 格式化后的值
    public static func setPositiveFormat(value: String, positiveFormat: String, number nstyle: NumberFormatter.Style = .none) -> String? {
        // 创建一个NumberFormatter对象
        let numberFormatter = NumberFormatter()
        // 设置number显示样式
        numberFormatter.numberStyle = nstyle
        numberFormatter.positiveFormat = positiveFormat
        return customFormatter(value: value, numberFormatter: numberFormatter)
    }
}
