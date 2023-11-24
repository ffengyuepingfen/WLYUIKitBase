//
//  NSAttributedStringEx.swift
//  WLYUIKitBase
//
//  Created by Laowang on 2023/11/22.
//

import UIKit

// MARK: - 一、文本设置的基本扩展
public extension NSAttributedString {

    // MARK: 1.1、设置特定区域的字体大小
    /// 设置特定区域的字体大小
    /// - Parameters:
    ///   - font: 字体
    ///   - range: 区域
    /// - Returns: 返回设置后的富文本
//    func setRangeFontText(font: UIFont, range: NSRange) -> NSAttributedString {
//        return setSpecificRangeTextMoreAttributes(attributes: [NSAttributedString.Key.font : font], range: range)
//    }
    
    // MARK: 1.2、设置特定文字的字体大小
    /// 设置特定文字的字体大小
    /// - Parameters:
    ///   - text: 特定文字
    ///   - font: 字体
    /// - Returns: 返回设置后的富文本
//    func setSpecificTextFont(_ text: String, font: UIFont) -> NSAttributedString {
//        return setSpecificTextMoreAttributes(text, attributes: [NSAttributedString.Key.font : font])
//    }
    
    // MARK: 1.3、设置特定区域的字体颜色
    /// 设置特定区域的字体颜色
    /// - Parameters:
    ///   - color: 字体颜色
    ///   - range: 区域
    /// - Returns: 返回设置后的富文本
//    func setSpecificRangeTextColor(color: UIColor, range: NSRange) -> NSAttributedString {
//        return setSpecificRangeTextMoreAttributes(attributes: [NSAttributedString.Key.foregroundColor : color], range: range)
//    }
    
    // MARK: 1.4、设置特定文字的字体颜色
    /// 设置特定文字的字体颜色
    /// - Parameters:
    ///   - text: 特定文字
    ///   - color: 字体颜色
    /// - Returns: 返回设置后的富文本
//    func setSpecificTextColor(_ text: String, color: UIColor) -> NSAttributedString {
//        return setSpecificTextMoreAttributes(text, attributes: [NSAttributedString.Key.foregroundColor : color])
//    }
    
    // MARK: 1.5、设置特定区域行间距
    /// 设置特定区域行间距
    /// - Parameters:
    ///   - lineSpace: 行间距
    ///   - alignment: 对齐方式
    ///   - range: 区域
    /// - Returns: 返回设置后的富文本
//    func setSpecificRangeTextLineSpace(lineSpace: CGFloat, alignment: NSTextAlignment, range: NSRange) -> NSAttributedString {
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = lineSpace
//        paragraphStyle.alignment = alignment
//        
//        return setSpecificRangeTextMoreAttributes(attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle], range: range)
//    }
    
    // MARK: 1.6、设置特定文字行间距
    /// 设置特定文字行间距
    /// - Parameters:
    ///   - text: 特定的文字
    ///   - lineSpace: 行间距
    ///   - alignment: 对齐方式
    /// - Returns: 返回设置后的富文本
//    func setSpecificTextLineSpace(_ text: String, lineSpace: CGFloat, alignment: NSTextAlignment) -> NSAttributedString {
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = lineSpace
//        paragraphStyle.alignment = alignment
//        return setSpecificTextMoreAttributes(text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
//    }
    
    // MARK: 1.7、设置特定区域的下划线
    /// 设置特定区域的下划线
    /// - Parameters:
    ///   - color: 下划线颜色
    ///   - stytle: 下划线样式，默认单下划线
    ///   - range: 特定区域范围
    /// - Returns: 返回设置后的富文本
//    func setSpecificRangeUnderLine(color: UIColor, stytle: NSUnderlineStyle = .single, range: NSRange) -> NSAttributedString {
//        // 下划线样式
//        let lineStytle = NSNumber(value: Int8(stytle.rawValue))
//        return setSpecificRangeTextMoreAttributes(attributes: [NSAttributedString.Key.underlineStyle: lineStytle, NSAttributedString.Key.underlineColor: color], range: range)
//    }
    
    // MARK: 1.8、设置特定文字的下划线
    /// 设置特定文字的下划线
    /// - Parameters:
    ///   - text: 特定文字
    ///   - color: 下划线颜色
    ///   - stytle: 下划线样式，默认单下划线
    /// - Returns: 返回设置后的富文本
//    func setSpecificTextUnderLine(_ text: String, color: UIColor, stytle: NSUnderlineStyle = .single) -> NSAttributedString {
//        // 下划线样式
//        let lineStytle = NSNumber(value: Int8(stytle.rawValue))
//        return setSpecificTextMoreAttributes(text, attributes: [NSAttributedString.Key.underlineStyle : lineStytle, NSAttributedString.Key.underlineColor: color])
//    }
    
    // MARK: 1.9、设置特定区域的删除线
    /// 设置特定区域的删除线
    /// - Parameters:
    ///   - color: 删除线颜色
    ///   - range: 范围
    /// - Returns: 返回设置后的富文本
//    func setSpecificRangeDeleteLine(color: UIColor, range: NSRange) -> NSAttributedString {
//        var attributes = Dictionary<NSAttributedString.Key, Any>()
//        // 删除线样式
//        let lineStytle = NSNumber(value: Int8(NSUnderlineStyle.single.rawValue))
//        attributes[NSAttributedString.Key.strikethroughStyle] = lineStytle
//        attributes[NSAttributedString.Key.strikethroughColor] = color
//
//        let version = UIDevice.currentSystemVersion as NSString
//        if version.floatValue >= 10.3 {
//            attributes[NSAttributedString.Key.baselineOffset] = 0
//        } else if version.floatValue <= 9.0 {
//            attributes[NSAttributedString.Key.strikethroughStyle] = []
//        }
//        return setSpecificRangeTextMoreAttributes(attributes: attributes, range: range)
//    }
    
    // MARK: 1.10、设置特定文字的删除线
    /// 设置特定文字的删除线
    /// - Parameters:
    ///   - text: 特定文字
    ///   - color: 删除线颜色
    /// - Returns: 返回设置后的富文本
//    func setSpecificTextDeleteLine(_ text: String, color: UIColor) -> NSAttributedString {
//        var attributes = Dictionary<NSAttributedString.Key, Any>()
//        // 删除线样式
//        let lineStytle = NSNumber(value: Int8(NSUnderlineStyle.single.rawValue))
//        attributes[NSAttributedString.Key.strikethroughStyle] = lineStytle
//        attributes[NSAttributedString.Key.strikethroughColor] = color
//
//        let version = UIDevice.currentSystemVersion as NSString
//        if version.floatValue >= 10.3 {
//            attributes[NSAttributedString.Key.baselineOffset] = 0
//        } else if version.floatValue <= 9.0 {
//            attributes[NSAttributedString.Key.strikethroughStyle] = []
//        }
//        return setSpecificTextMoreAttributes(text, attributes: attributes)
//    }
    
    // MARK: 1.11、插入图片
    /// 插入图片
    /// - Parameters:
    ///   - imgName: 要添加的图片名称，如果是网络图片，需要传入完整路径名，且imgBounds必须传值
    ///   - imgBounds: 图片的大小，默认为.zero，即自动根据图片大小设置，并以底部基线为标准。 y > 0 ：图片向上移动；y < 0 ：图片向下移动
    ///   - imgIndex: 图片的位置，默认放在开头
    /// - Returns: 返回设置后的富文本
//    func insertImage(imgName: String, imgBounds: CGRect = .zero, imgIndex: Int = 0) -> NSAttributedString {
//        let attributedString = NSMutableAttributedString(attributedString: self)
//        // NSTextAttachment可以将要插入的图片作为特殊字符处理
//        let attch = NSTextAttachment()
//        attch.image = loadImage(imageName: imgName)
//        attch.bounds = imgBounds
//        // 创建带有图片的富文本
//        let string = NSAttributedString(attachment: attch)
//        // 将图片添加到富文本
//        attributedString.insert(string, at: imgIndex)
//        return attributedString
//    }
    
    // MARK: 1.12、首行缩进
    /// 首行缩进
    /// - Parameter edge: 缩进宽度
    /// - Returns: 返回设置后的富文本
//    func firstLineLeftEdge(_ edge: CGFloat) -> NSAttributedString {
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.firstLineHeadIndent = edge
//        return setSpecificRangeTextMoreAttributes(attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: self.base.length))
//    }
    
    // MARK: 1.13、设置特定区域的多个字体属性
    /// 设置特定区域的多个字体属性
    /// - Parameters:
    ///   - attributes: 字体属性
    ///   - range: 特定区域
    /// - Returns: 返回设置后的富文本
//    func setSpecificRangeTextMoreAttributes(attributes: Dictionary<NSAttributedString.Key, Any>, range: NSRange) -> NSAttributedString {
//        let mutableAttributedString = NSMutableAttributedString(attributedString: self)
//        for name in attributes.keys {
//            mutableAttributedString.addAttribute(name, value: attributes[name] ?? "", range: range)
//        }
//        return mutableAttributedString
//    }

    // MARK: 1.14、设置特定文字的多个字体属性
    /// 设置特定文字的多个字体属性
    /// - Parameters:
    ///   - text: 特定文字
    ///   - attributes: 字体属性
    /// - Returns: 返回设置后的富文本
//    func setSpecificTextMoreAttributes(_ text: String, attributes: Dictionary<NSAttributedString.Key, Any>) -> NSAttributedString {
//        let mutableAttributedString = NSMutableAttributedString(attributedString: self)
//        let rangeArray = getStringRangeArray(with: [text])
//        if !rangeArray.isEmpty {
//            for name in attributes.keys {
//                for range in rangeArray {
//                    mutableAttributedString.addAttribute(name, value: attributes[name] ?? "", range: range)
//                }
//            }
//        }
//        return mutableAttributedString
//    }
    
    // MARK: 1.15、设置特定区域的倾斜
    /// 设置特定区域的倾斜
    /// - Parameters:
    ///   - inclination: 倾斜度
    ///   - range: 特定区域范围
    /// - Returns: 返回设置后的富文本
//    func setSpecificRangeBliqueness(inclination: Float = 0, range: NSRange) -> NSAttributedString {
//        return setSpecificRangeTextMoreAttributes(attributes: [NSAttributedString.Key.obliqueness: inclination], range: range)
//    }
    
    // MARK: 1.16、设置特定文字的倾斜
    /// 设置特定文字的倾斜
    /// - Parameters:
    ///   - text: 特定文字
    ///   - inclination: 倾斜度
    /// - Returns: 返回设置后的富文本
//    func setSpecificTextBliqueness(_ text: String, inclination: Float = 0) -> NSAttributedString {
//        return setSpecificTextMoreAttributes(text, attributes: [NSAttributedString.Key.obliqueness : inclination])
//    }
}

// MARK: - Private Func
public extension NSAttributedString {
    /// 获取对应字符串的range数组
    /// - Parameter textArray: 字符串数组
    /// - Returns: range数组
//    private func getStringRangeArray(with textArray: Array<String>) -> Array<NSRange> {
//        var rangeArray = Array<NSRange>()
//        // 遍历
//        for str in textArray {
//            if self.string.contains(str) {
//                let subStrArr = self.string.components(separatedBy: str)
//                var subStrIndex = 0
//                for i in 0 ..< (subStrArr.count - 1) {
//                    let subDivisionStr = subStrArr[i]
//                    if i == 0 {
//                        subStrIndex += (subDivisionStr.lengthOfBytes(using: .unicode) / 2)
//                    } else {
//                        subStrIndex += (subDivisionStr.lengthOfBytes(using: .unicode) / 2 + str.lengthOfBytes(using: .unicode) / 2)
//                    }
//                    let newRange = NSRange(location: subStrIndex, length: str.count)
//                    rangeArray.append(newRange)
//                }
//            }
//        }
//        return rangeArray
//    }

    // MARK: 加载网络图片
    /// 加载网络图片
    /// - Parameter imageName: 图片名
    /// - Returns: 图片
//    private func loadImage(imageName: String) -> UIImage? {
//        if imageName.hasPrefix("http://") || imageName.hasPrefix("https://") {
//            let imageURL = URL(string: imageName)
//            var imageData: Data? = nil
//            do {
//                imageData = try Data(contentsOf: imageURL!)
//                return UIImage(data: imageData!)!
//            } catch {
//                return nil
//            }
//        }
//        return UIImage(named: imageName)!
//    }
}

// MARK: - 富文本属性介绍
/**
 // NSFontAttributeName                设置字体属性，默认值：字体：Helvetica(Neue) 字号：12
 // NSForegroundColorAttributeNam      设置字体颜色，取值为 UIColor对象，默认值为黑色
 // NSBackgroundColorAttributeName     设置字体所在区域背景颜色，取值为 UIColor对象，默认值为nil, 透明色
 // NSLigatureAttributeName            设置连体属性，取值为NSNumber 对象(整数)，0 表示没有连体字符，1 表示使用默认的连体字符
 // NSKernAttributeName                设定字符间距，取值为 NSNumber 对象（整数），正值间距加宽，负值间距变窄
 // NSStrikethroughStyleAttributeName  设置删除线，取值为 NSNumber 对象（整数）
 // NSStrikethroughColorAttributeName  设置删除线颜色，取值为 UIColor 对象，默认值为黑色
 // NSUnderlineStyleAttributeName      设置下划线，取值为 NSNumber 对象（整数），枚举常量 NSUnderlineStyle中的值，与删除线类似
 // NSUnderlineColorAttributeName      设置下划线颜色，取值为 UIColor 对象，默认值为黑色
 // NSStrokeWidth AttributeName         设置笔画宽度，取值为 NSNumber 对象（整数），负值填充效果，正值中空效果
 // NSStrokeColorAttributeName         填充部分颜色，不是字体颜色，取值为 UIColor 对象
 // NSShadowAttributeName              设置阴影属性，取值为 NSShadow 对象
 // NSTextEffectAttributeName          设置文本特殊效果，取值为 NSString 对象，目前只有图版印刷效果可用：
 // NSBaselineOffsetAttributeName      设置基线偏移值，取值为 NSNumber （float）,正值上偏，负值下偏
 // NSObliquenessAttributeName         设置字形倾斜度，取值为 NSNumber （float）,正值右倾，负值左倾
 // NSExpansionAttributeName           设置文本横向拉伸属性，取值为 NSNumber （float）,正值横向拉伸文本，负值横向压缩文本
 // NSWritingDirectionAttributeName    设置文字书写方向，从左向右书写或者从右向左书写
 // NSVerticalGlyphFormAttributeName   设置文字排版方向，取值为 NSNumber 对象(整数)，0 表示横排文本，1 表示竖排文本
 // NSLinkAttributeName                设置链接属性，点击后调用浏览器打开指定URL地址
 // NSAttachmentAttributeName          设置文本附件,取值为NSTextAttachment对象,常用于文字图片混排
 // NSParagraphStyleAttributeName      设置文本段落排版格式，取值为 NSParagraphStyle 对象
 */

// MARK: - 一、基本的链式编程 扩展
public extension NSMutableAttributedString {
 
    // MARK: 1.1、设置 删除线
    /// 设置 删除线
    /// - Returns: 返回自身
    @discardableResult
    func strikethrough() -> Self {
        let range = NSMakeRange(0, length)
        addAttributes([.strikethroughStyle: NSUnderlineStyle.single.rawValue], range: range)
        return self
    }
    
    // MARK: 1.2、设置富文本文字的颜色
    /// 设置富文本文字的颜色
    /// - Parameter color: 富文本文字的颜色
    /// - Returns: 返回自身
    @discardableResult
    func color(_ color: UIColor) -> Self {
        let range = NSMakeRange(0, length)
        addAttributes([.foregroundColor: color], range: range)
        return self
    }
    
    // MARK: 1.3、设置富文本文字的颜色(十六进制字符串颜色)
    /// 设置富文本文字的颜色(十六进制字符串颜色)
    /// - Parameter hexString: (十六进制字符串颜
    /// - Returns: 返回自身
    @discardableResult
    func color(_ hexString: String) -> Self {
        let range = NSMakeRange(0, length)
        addAttributes([.foregroundColor: UIColor.hex(hexString: hexString)], range: range)
        return self
    }
    
    // MARK: 1.4、设置富文本文字的大小
    /// 设置富文本文字的大小
    /// - Parameter font: 字体的大小
    /// - Returns: 返回自身
    @discardableResult
    func font(_ font: CGFloat) -> Self {
        let range = NSMakeRange(0, length)
        addAttributes([.font: UIFont.systemFont(ofSize: font)], range: range)
        return self
    }
    
    // MARK: 1.5、设置富文本文字的 UIFont
    /// 设置富文本文字的 UIFont
    /// - Parameter font: UIFont
    /// - Returns: 返回自身
    @discardableResult
    func font(_ font: UIFont) -> Self {
        let range = NSMakeRange(0, length)
        addAttributes([.font: font], range: range)
        return self
    }
    
    @discardableResult
    func append_c(_ attrString: NSAttributedString) -> NSMutableAttributedString {
        self.append(attrString)
        return self
    }
}

// MARK: 关于字符串的 富文本 扩展
extension String {

    
    /// 转换字符串为 富文本
    /// - Returns: 返回富文本
    public func toAttributed() -> NSAttributedString {
        let attri = NSAttributedString(string: self)
        return attri
    }
    
    public func toMutableAttributed() -> NSMutableAttributedString {
        let attri = NSMutableAttributedString(string: self)
        return attri
    }
}
