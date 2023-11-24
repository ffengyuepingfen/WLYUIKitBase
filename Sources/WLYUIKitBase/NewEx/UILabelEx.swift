//
//  UILabelEx.swift
//  WLYUIKitBase
//
//  Created by Laowang on 2023/9/5.
//

import UIKit



// MARK: - 二、其他的基本扩展
public extension UILabel {
    
    // MARK: 2.1、获取已知 frame 的 label 的文本行数 & 每一行内容
    /// 获取已知 frame 的 label 的文本行数 & 每一行内容
    /// - Parameters:
    ///   - lineSpace: 行间距
    ///   - textSpace: 字间距，默认为0.0
    ///   - paraSpace: 段间距，默认为0.0
    /// - Returns: label 的文本行数 & 每一行内容
    func linesCountAndLinesContent(lineSpace: CGFloat, textSpace: CGFloat = 0.0, paraSpace: CGFloat = 0.0) -> (Int?, [String]?) {
        return accordWidthLinesCountAndLinesContent(accordWidth: self.frame.size.width, lineSpace: lineSpace, textSpace: textSpace, paraSpace: paraSpace)
    }
    
    // MARK: 2.2、获取已知 width 的 label 的文本行数 & 每一行内容
    /// 获取已知 width 的 label 的文本行数 & 每一行内容
    /// - Parameters:
    ///   - accordWidth: label 的 width
    ///   - lineSpace: 行间距
    ///   - textSpace: 字间距，默认为0.0
    ///   - paraSpace: 段间距，默认为0.0
    /// - Returns: description
    func accordWidthLinesCountAndLinesContent(accordWidth: CGFloat, lineSpace: CGFloat, textSpace: CGFloat = 0.0, paraSpace: CGFloat = 0.0) -> (Int?, [String]?) {
        guard let t = self.text, let f = self.font else {return (0, nil)}
        let align = self.textAlignment
        let c_fn = f.fontName as CFString
        let fp = f.pointSize
        let c_f = CTFontCreateWithName(c_fn, fp, nil)
        
        let contentDict = UILabel.genTextStyle(text: t as NSString, linebreakmode: NSLineBreakMode.byCharWrapping, align: align, font: f, lineSpace: lineSpace, textSpace: textSpace, paraSpace: paraSpace)
        
        let attr = NSMutableAttributedString(string: t)
        let range = NSRange(location: 0, length: attr.length)
        attr.addAttributes(contentDict, range: range)
        
        attr.addAttribute(NSAttributedString.Key.font, value: c_f, range: range)
        let frameSetter = CTFramesetterCreateWithAttributedString(attr as CFAttributedString)
        
        let path = CGMutablePath()
        /// 2.5 是经验误差值
        path.addRect(CGRect(x: 0, y: 0, width: accordWidth - 2.5, height: CGFloat(MAXFLOAT)))
        let framef = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, nil)
        let lines = CTFrameGetLines(framef) as NSArray
        var lineArr = [String]()
        for line in lines {
            let lineRange = CTLineGetStringRange(line as! CTLine)
            let lineString = t.sub(start: lineRange.location, length: lineRange.length)
            lineArr.append(lineString as String)
        }
        return (lineArr.count, lineArr)
    }
    
    // MARK: 2.3、获取第一行内容
    /// 获取第一行内容
    var firstLineString: String? {
        return self.linesCountAndLinesContent(lineSpace: 0.0).1?.first
    }
    
    // MARK: 2.4、改变行间距
    /// 改变行间距
    /// - Parameter space: 行间距大小
    func changeLineSpace(space: CGFloat) {
        if self.self.text == nil || self.self.text == "" {
            return
        }
        let text = self.self.text
        let attributedString = NSMutableAttributedString(string: text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = space
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: text!.count))
        self.self.attributedText = attributedString
        self.self.sizeToFit()
    }
    
    // MARK: 2.5、改变字间距
    /// 改变字间距
    /// - Parameter space: 字间距大小
    func changeWordSpace(space: CGFloat) {
        if self.self.text == nil || self.self.text == "" {
            return
        }
        let text = self.self.text
        let attributedString = NSMutableAttributedString(string: text!, attributes: [NSAttributedString.Key.kern:space])
        let paragraphStyle = NSMutableParagraphStyle()
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: text!.count))
        self.self.attributedText = attributedString
        self.self.sizeToFit()
    }
    
    // MARK: 2.6、改变字间距和行间距
    /// 改变字间距和行间距
    /// - Parameters:
    ///   - lineSpace: 行间距
    ///   - wordSpace: 字间距
    func changeSpace(lineSpace: CGFloat, wordSpace: CGFloat) {
        if self.self.text == nil || self.self.text == "" {
            return
        }
        let text = self.self.text
        let attributedString = NSMutableAttributedString(string: text!, attributes: [NSAttributedString.Key.kern:wordSpace])
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: text!.count))
        self.self.attributedText = attributedString
        self.self.sizeToFit()
    }
    
    // MARK: 2.7、label添加中划线
    /// label添加中划线
    /// - Parameters:
    ///   - lineValue: value 越大,划线越粗
    ///   - underlineColor: 中划线的颜色
    func centerLineText(lineValue: Int = 1, underlineColor: UIColor = .black) {
        guard let content = self.text else {
            return
        }
        let arrText = NSMutableAttributedString(string: content)
        arrText.addAttributes([NSAttributedString.Key.strikethroughStyle: lineValue, NSAttributedString.Key.strikethroughColor: underlineColor], range: NSRange(location: 0, length: arrText.length))
        self.attributedText = arrText
    }
    
    // MARK: 设置文本样式
    /// 设置文本样式
    /// - Parameters:
    ///   - text: 文字内容
    ///   - linebreakmode: 结尾部分的内容以……方式省略 ( "...wxyz" ,"abcd..." ,"ab...yz")
    ///   - align: 文本对齐方式：（左，中，右，两端对齐，自然）
    ///   - font: 字体大小
    ///   - lineSpace: 字体的行间距
    ///   - textSpace: 设定字符间距，取值为 NSNumber 对象（整数），正值间距加宽，负值间距变窄
    ///   - paraSpace: 段与段之间的间距
    /// - Returns: 返回样式 [NSAttributedString.Key : Any]
    private static func genTextStyle(text: NSString, linebreakmode: NSLineBreakMode, align: NSTextAlignment, font: UIFont, lineSpace: CGFloat, textSpace: CGFloat, paraSpace: CGFloat) -> [NSAttributedString.Key : Any] {
        let style = NSMutableParagraphStyle()
        // 结尾部分的内容以……方式省略 ( "...wxyz" ,"abcd..." ,"ab...yz")
        /**
         case byWordWrapping = 0       //  以单词为显示单位显示，后面部分省略不显示
         case byCharWrapping = 1        //  以字符为显示单位显示，后面部分省略不显示
         case byClipping = 2                  //   剪切与文本宽度相同的内容长度，后半部分被删除
         case byTruncatingHead = 3      //   前面部分文字以……方式省略，显示尾部文字内容
         case byTruncatingTail = 4         //   中间的内容以……方式省略，显示头尾的文字内容
         case byTruncatingMiddle = 5    //   结尾部分的内容以……方式省略，显示头的文字内容
         */
        style.lineBreakMode = linebreakmode
        // 文本对齐方式：（左，中，右，两端对齐，自然）
        style.alignment = align
        // 字体的行间距
        style.lineSpacing = lineSpace
        // 连字属性 在iOS，唯一支持的值分别为0和1
        style.hyphenationFactor = 1.0
        // 首行缩进
        style.firstLineHeadIndent = 0.0
        // 段与段之间的间距
        style.paragraphSpacing = paraSpace
        // 段首行空白空间
        style.paragraphSpacingBefore = 0.0
        // 整体缩进(首行除外)
        style.headIndent = 0.0
        // 文本行末缩进距离
        style.tailIndent = 0.0
        
        /*
         // 一组NSTextTabs。 内容应按位置排序。 默认值是一个由12个左对齐制表符组成的数组，间隔为28pt ？？？？？
         style.tabStops =
         // 一个布尔值，指示系统在截断文本之前是否可以收紧字符间间距 ？？？？？
         style.allowsDefaultTighteningForTruncation = true
         // 文档范围的默认选项卡间隔 ？？？？？
         style.defaultTabInterval = 1
         // 最低行高（设置最低行高后，如果文本小于20行，会通过增加行间距达到20行的高度）
         style.minimumLineHeight = 10
         // 最高行高（设置最高行高后，如果文本大于10行，会通过降低行间距达到10行的高度）
         style.maximumLineHeight = 20
         //从左到右的书写方向
         style.selfWritingDirection = .leftToRight
         // 在受到最小和最大行高约束之前，自然线高度乘以该因子（如果为正） 多少倍行间距
         style.lineHeightMultiple = 15
         */
        
        let dict = [
            NSAttributedString.Key.font : font, NSAttributedString.Key.paragraphStyle : style, NSAttributedString.Key.kern : textSpace] as [NSAttributedString.Key : Any]
        return dict
    }
    
    // MARK: 2.8、获取已知label 的文本行数 & 每一行内容
    /// 获取已知label 的文本行数 & 每一行内容
    /// - Returns: 每行的内容
//    func linesCountAndLinesContent() -> (Int?, [String]?) {
//        guard let t = self.text else {return (0, nil)}
//        let lodFontName = self.font.fontName == ".SFUI-Regular" ? "TimesNewRomanPSMT" : self.font.fontName
//        let fontSize = getFontSizeForLabel()
//        let newFont = UIFont(name: lodFontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
//        let c_fn = newFont.fontName as CFString
//        let fp = newFont.pointSize
//        let c_f = CTFontCreateWithName(c_fn, fp, nil)
//
//        let style = NSMutableParagraphStyle()
//        style.lineBreakMode = .byCharWrapping
//        let contentDict = [NSAttributedString.Key.paragraphStyle : style] as [NSAttributedString.Key : Any]
//
//        let attr = NSMutableAttributedString(string: t)
//        let range = NSRange(location: 0, length: attr.length)
//        attr.addAttributes(contentDict, range: range)
//        attr.addAttribute(NSAttributedString.Key.font, value: c_f, range: range)
//        let frameSetter = CTFramesetterCreateWithAttributedString(attr as CFAttributedString)
//
//        let path = CGMutablePath()
//        /// 2.5 是经验误差值
//        path.addRect(CGRect(x: 0, y: 0, width: self.width, height: self.height > (fp * 1.5) ? self.height : fp * 1.5))
//        let framef = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, nil)
//        let lines = CTFrameGetLines(framef) as NSArray
//        var lineArr = [String]()
//        for line in lines {
//            let lineRange = CTLineGetStringRange(line as! CTLine)
//            let lineString = t.sub(start: lineRange.location, length: lineRange.length)
//            lineArr.append(lineString as String)
//        }
//        return (lineArr.count, lineArr)
//    }
    
    // MARK: 2.9、获取字体的大小
    /// 获取字体的大小
    /// - Returns: 字体大小
    func getFontSizeForLabel() -> CGFloat {
        let text: NSMutableAttributedString = NSMutableAttributedString(attributedString: self.attributedText!)
        text.setAttributes([NSAttributedString.Key.font: self.font as Any], range: NSMakeRange(0, text.length))
        let context: NSStringDrawingContext = NSStringDrawingContext()
        context.minimumScaleFactor = self.minimumScaleFactor
        text.boundingRect(with: self.frame.size, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: context)
        let adjustedFontSize: CGFloat = self.font.pointSize * context.actualScaleFactor
        return adjustedFontSize
    }
}

// MARK: - 三、特定区域和特定文字的基本扩展
public extension UILabel {

    // MARK: 3.1、设置特定区域的字体大小
    /// 设置特定区域的字体大小
    /// - Parameters:
    ///   - font: 字体
    ///   - range: 区域
//    func setRangeFontText(font: UIFont, range: NSRange) {
//        let attributedString = self.attributedText?.setRangeFontText(font: font, range: range)
//        self.attributedText = attributedString
//    }
//
//    // MARK: 3.2、设置特定文字的字体大小
//    /// 设置特定文字的字体大小
//    /// - Parameters:
//    ///   - text: 特定文字
//    ///   - font: 字体
//    func setsetSpecificTextFont(_ text: String, font: UIFont) {
//        let attributedString = self.attributedText?.setSpecificTextFont(text, font: font)
//        self.attributedText = attributedString
//    }
//
//    // MARK: 3.3、设置特定区域的字体颜色
//    /// 设置特定区域的字体颜色
//    /// - Parameters:
//    ///   - color: 字体颜色
//    ///   - range: 区域
//    func setSpecificRangeTextColor(color: UIColor, range: NSRange) {
//        let attributedString = self.attributedText?.setSpecificRangeTextColor(color: color, range: range)
//        self.attributedText = attributedString
//    }
//
//    // MARK: 3.4、设置特定文字的字体颜色
//    /// 设置特定文字的字体颜色
//    /// - Parameters:
//    ///   - text: 特定文字
//    ///   - color: 字体颜色
//    func setSpecificTextColor(_ text: String, color: UIColor) {
//        let attributedString = self.attributedText?.setSpecificTextColor(text, color: color)
//        self.attributedText = attributedString
//    }
//
//    // MARK: 3.5、设置行间距
//    /// 设置行间距
//    /// - Parameter space: 行间距
//    func setTextLineSpace(_ space: CGFloat) {
//        let attributedString = self.attributedText?.setSpecificRangeTextLineSpace(lineSpace: space, alignment: self.textAlignment, range: NSRange(location: 0, length: self.text?.count ?? 0))
//        self.attributedText = attributedString
//    }
//
//    // MARK: 3.6、设置特定文字区域的下划线
//    /// 设置特定区域的下划线
//    /// - Parameters:
//    ///   - color: 下划线颜色
//    ///   - stytle: 下划线样式，默认单下划线
//    ///   - range: 文字区域
//    func setSpecificRangeTextUnderLine(color: UIColor, stytle: NSUnderlineStyle = .single, range: NSRange) {
//        let attributedString = self.attributedText?.setSpecificRangeUnderLine(color: color, stytle: stytle, range: range)
//        self.attributedText = attributedString
//    }
//
//    // MARK: 3.7、设置特定文字的下划线
//    /// 设置特定文字的下划线
//    /// - Parameters:
//    ///   - text: 特定文字
//    ///   - color: 下划线颜色
//    ///   - stytle: 下划线样式，默认单下划线
//    func setSpecificTextUnderLine(_ text: String, color: UIColor, stytle: NSUnderlineStyle = .single) {
//        let attributedString = self.attributedText?.setSpecificTextUnderLine(text, color: color, stytle: stytle)
//        self.attributedText = attributedString
//    }
//
//    // MARK: 3.8、设置特定区域的删除线
//    /// 设置特定区域的删除线
//    /// - Parameters:
//    ///   - color: 删除线颜色
//    ///   - range: 特定区域范围
//    func setSpecificRangeDeleteLine(color: UIColor, range: NSRange) {
//        let attributedString = self.attributedText?.setSpecificRangeDeleteLine(color: color, range: range)
//        self.attributedText = attributedString
//    }
//
//    // MARK: 3.9、设置特定文字的删除线
//    /// 设置特定文字的删除线
//    /// - Parameters:
//    ///   - text: 特定文字
//    ///   - color: 删除线颜色
//    func setSpecificTextDeleteLine(_ text: String, color: UIColor) {
//        let attributedString = self.attributedText?.setSpecificTextDeleteLine(text, color: color)
//        self.attributedText = attributedString
//    }
//
//    // MARK: 3.10、插入图片
//    /// 插入图片
//    /// - Parameters:
//    ///   - imgName: 要添加的图片名称，如果是网络图片，需要传入完整路径名，且imgBounds必须传值
//    ///   - imgBounds: 图片的大小，默认为.zero，即自动根据图片大小设置，并以底部基线为标准。 y > 0 ：图片向上移动；y < 0 ：图片向下移动
//    ///   - imgIndex:  图片的位置，默认放在开头
//    func insertImage(imgName: String, imgBounds: CGRect = .zero, imgIndex: Int = 0) {
//        // 设置换行方式
//        self.lineBreakMode = NSLineBreakMode.byCharWrapping
//        let attributedString = self.attributedText?.insertImage(imgName: imgName, imgBounds: imgBounds, imgIndex: imgIndex)
//        self.attributedText = attributedString
//    }
//
//    // MARK: 3.11、首行缩进
//    /// 首行缩进
//    /// - Parameter edge: 缩进宽度
//    func firstLineLeftEdge(_ edge: CGFloat) {
//        let attributedString = self.attributedText?.firstLineLeftEdge(edge)
//        self.attributedText = attributedString
//    }
//
//    // MARK: 3.12、设置特定文字区域的倾斜
//    /// 设置特定区域的倾斜
//    /// - Parameters:
//    ///   - inclination: 倾斜度
//    ///   - range: 文字区域
//    func setSpecificRangeBliqueness(inclination: Float = 0, range: NSRange) {
//        let attributedString = self.attributedText?.setSpecificRangeBliqueness(inclination: inclination, range: range)
//        self.attributedText = attributedString
//    }
//
//    // MARK: 3.13、设置特定文字的倾斜
//    /// 设置特定文字的倾斜
//    /// - Parameters:
//    ///   - text: 特定文字
//    ///   - inclination: 倾斜度
//    func setSpecificTextBliqueness(_ text: String, inclination: Float = 0) {
//        let attributedString = self.attributedText?.setSpecificTextBliqueness(text, inclination: inclination)
//        self.attributedText = attributedString
//    }
}


enum UILabelLevel {
case large, title, subtitle, body, footnote, caption
}


//标题： 17pt
//副标题： 14pt-17pt
//正文： 12pt—16pt
//注释： 11pt—12pt
//最小可见： 10pt


extension UILabel {
    
    /// 大标题
    /// - Parameters:
    ///   - title: 名称
    ///   - weight: 自重
    ///   - color: 颜色
    /// - Returns:  label
    public static func large(_ title: String, weight: UIFont.Weight? = nil, color: UIColor = .label, alignment: NSTextAlignment = .left) -> UILabel {
        productLabel(level: .large, title: title, color: color, weight: weight, alignment: alignment)
    }
    
    
    /// 一级标题
    /// - Parameters:
    ///   - title: 显示的内容
    ///   - weight: 字重
    ///   - color:  字的颜色
    ///   - alignment: 对齐方式
    /// - Returns: description
    public static func title(_ title: String, weight: UIFont.Weight? = nil , color: UIColor = .label, alignment: NSTextAlignment = .left) -> UILabel {
        productLabel(level: .title, title: title, color: color, weight: weight, alignment: alignment)
    }
    
    
    /// 2级级标题
    /// - Parameters:
    ///   - title: 显示的内容
    ///   - weight: 字重
    ///   - color:  字的颜色
    ///   - alignment: 对齐方式
    /// - Returns: description
    public static func subtitle(_ title: String, weight: UIFont.Weight? = nil , color: UIColor = .label, alignment: NSTextAlignment = .left) -> UILabel {
        productLabel(level: .subtitle, title: title, color: color, weight: weight, alignment: alignment)
    }
    
    /// body
    /// - Parameters:
    ///   - title: 显示的内容
    ///   - weight: 字重
    ///   - color:  字的颜色
    ///   - alignment: 对齐方式
    /// - Returns: description
    public static func body(_ title: String, weight: UIFont.Weight? = nil , color: UIColor = .label, alignment: NSTextAlignment = .left) -> UILabel {
        productLabel(level: .body, title: title, color: color, weight: weight, alignment: alignment)
    }
    
    /// footnote
    /// - Parameters:
    ///   - title: 显示的内容
    ///   - weight: 字重
    ///   - color:  字的颜色
    ///   - alignment: 对齐方式
    /// - Returns: description
    public static func footnote(_ title: String, weight: UIFont.Weight? = nil , color: UIColor = .label, alignment: NSTextAlignment = .left) -> UILabel {
        productLabel(level: .footnote, title: title, color: color, weight: weight, alignment: alignment)
    }

    
    /// caption
    /// - Parameters:
    ///   - title: 显示的内容
    ///   - weight: 字重
    ///   - color:  字的颜色
    ///   - alignment: 对齐方式
    /// - Returns: description
    public static func caption(_ title: String, weight: UIFont.Weight? = nil , color: UIColor = .label, alignment: NSTextAlignment = .left) -> UILabel {
        productLabel(level: .caption, title: title, color: color, weight: weight, alignment: alignment)
    }
}

extension UILabel {
    /// 加载 普通文本
    private static func productLabel(level: UILabelLevel,
                                     title: String,
                                     color: UIColor,
                                     weight: UIFont.Weight?,
                                     alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.text = title
        label.textAlignment = alignment
        label.textColor = color
//        label.heightConstraint = 24
        
        switch level {
        case .large:
            label.font = UIFont.largeTitle(weight)
        case .title:
            label.font = UIFont.title(weight)
        case .subtitle:
            label.font = UIFont.subtitle(weight)
        case .body:
            label.font = UIFont.body(weight)
        case .footnote:
            label.font = UIFont.footnote(weight)
        case .caption:
            label.font = UIFont.caption(weight)
        }
        return label
    }
    
    /// 加载 富文本
    private static func productAttributedLabel(level: UILabelLevel,title: String, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = title
//        label.heightConstraint = 24
        label.textColor = color
        label.font = UIFont.footnote()
        return label
    }
    
}
