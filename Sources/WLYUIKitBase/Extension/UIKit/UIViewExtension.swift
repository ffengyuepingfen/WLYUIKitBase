//
//  File.swift
//  
//
//  Created by Laowang on 2023/5/16.
//
import Foundation
#if os(iOS)
import UIKit
//import CoreFoundation
//import WebKit

public enum JKDashLineDirection: Int {
    case vertical = 0
    case horizontal = 1
}

// MARK: 1.1、设备型号
/// 设备型号
/// - Returns: 设备型号信息
public func jk_deviceModel() -> String {
    var systemInfo = utsname()
    uname(&systemInfo)
    let size = Int(_SYS_NAMELEN)
    let deviceModelName = withUnsafeMutablePointer(to: &systemInfo.machine) { p in
        p.withMemoryRebound(to: CChar.self, capacity: size, { p2 in
            return String(cString: p2)
        })
    }
    return deviceModelName
}


// MARK: - 三、UIView 有关 Frame 的扩展
public extension UIView {
    // MARK: 3.1、x 的位置
    /// x 的位置
    var w_x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = self.frame
            tempFrame.origin.x = newValue
            self.frame = tempFrame
        }
    }
    // MARK: 3.2、y 的位置
    /// y 的位置
    var w_y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = self.frame
            tempFrame.origin.y = newValue
            self.frame = tempFrame
        }
    }
    
    // MARK: 3.3、height: 视图的高度
    /// height: 视图的高度
    var w_height: CGFloat {
        get {
            return self.frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = self.frame
            tempFrame.size.height = newValue
            self.frame = tempFrame
        }
    }
    
    // MARK: 3.4、width: 视图的宽度
    /// width: 视图的宽度
    var w_width: CGFloat {
        get {
            return self.frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = self.frame
            tempFrame.size.width = newValue
            self.frame = tempFrame
        }
    }
    
    // MARK: 3.5、size: 视图的zize
    /// size: 视图的zize
    var w_size: CGSize {
        get {
            return self.frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = self.frame
            tempFrame.size = newValue
            self.frame = tempFrame
        }
    }
    
    // MARK: 3.6、centerX: 视图的X中间位置
    /// centerX: 视图的X中间位置
    var w_centerX: CGFloat {
        get {
            return self.center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = self.center
            tempCenter.x = newValue
            self.center = tempCenter
        }
    }
    
    // MARK: 3.7、centerY: 视图的Y中间位置
    /// centerY: 视图Y的中间位置
    var w_centerY: CGFloat {
        get {
            return self.center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = self.center
            tempCenter.y = newValue
            self.center = tempCenter
        }
    }
    
    // MARK: 3.8、center: 视图的中间位置
    /// centerY: 视图Y的中间位置
    var w_center: CGPoint {
        get {
            return self.center
        }
        set(newValue) {
            var tempCenter: CGPoint = self.center
            tempCenter = newValue
            self.center = tempCenter
        }
    }
    
    // MARK: 3.9、top 上端横坐标(y)
    /// top 上端横坐标(y)
    var w_top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = self.frame
            tempFrame.origin.y = newValue
            self.frame = tempFrame
        }
    }
    
    // MARK: 3.10、left 左端横坐标(x)
    /// left 左端横坐标(x)
    var w_left: CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = self.frame
            tempFrame.origin.x = newValue
            self.frame = tempFrame
        }
    }
    
    // MARK: 3.11、bottom 底端纵坐标 (y + height)
    /// bottom 底端纵坐标 (y + height)
    var w_bottom: CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
        set(newValue) {
            self.frame.origin.y = newValue - self.frame.size.height
        }
    }
    
    // MARK: 3.12、right 底端纵坐标 (x + width)
    /// right 底端纵坐标 (x + width)
    var w_right: CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        set(newValue) {
            self.frame.origin.x = newValue - self.frame.size.width
        }
    }
    
    // MARK: 3.13、origin 点
    /// origin 点
    var w_origin: CGPoint {
        get {
            return self.frame.origin
        }
        set(newValue) {
            var tempOrigin: CGPoint = self.frame.origin
            tempOrigin = newValue
            self.frame.origin = tempOrigin
        }
    }
}

// MARK: - 四、继承于 UIView 视图的 平面、3D 旋转 以及 缩放、位移
/**
 从m11到m44定义的含义如下：
 m11：x轴方向进行缩放
 m12：和m21一起决定z轴的旋转
 m13:和m31一起决定y轴的旋转
 m14:
 m21:和m12一起决定z轴的旋转
 m22:y轴方向进行缩放
 m23:和m32一起决定x轴的旋转
 m24:
 m31:和m13一起决定y轴的旋转
 m32:和m23一起决定x轴的旋转
 m33:z轴方向进行缩放
 m34:透视效果m34= -1/D，D越小，透视效果越明显，必须在有旋转效果的前提下，才会看到透视效果
 m41:x轴方向进行平移
 m42:y轴方向进行平移
 m43:z轴方向进行平移
 m44:初始为1
 */
extension UIView {
    
    // MARK: 4.1、平面旋转
    /// 平面旋转
    /// - Parameters:
    ///   - angle: 旋转多少度
    ///   - isInverted: 顺时针还是逆时针，默认是顺时针
    public func setRotation(_ angle: CGFloat, isInverted: Bool = false) {
        self.transform = isInverted ? CGAffineTransform(rotationAngle: angle).inverted() : CGAffineTransform(rotationAngle: angle)
    }
    
    // MARK: 4.2、沿X轴方向旋转多少度(3D旋转)
    /// 沿X轴方向旋转多少度(3D旋转)
    /// - Parameter angle: 旋转角度，angle参数是旋转的角度，为弧度制 0-2π
    public func set3DRotationX(_ angle: CGFloat) {
        // 初始化3D变换,获取默认值
        //var transform = CATransform3DIdentity
        // 透视 1/ -D，D越小，透视效果越明显，必须在有旋转效果的前提下，才会看到透视效果
        // 当我们有垂直于z轴的旋转分量时，设置m34的值可以增加透视效果，也可以理解为景深效果
        // transform.m34 = 1.0 / -1000.0
        // 空间旋转，x，y，z决定了旋转围绕的中轴，取值为 (-1,1) 之间
        //transform = CATransform3DRotate(transform, angle, 1.0, 0.0, 0.0)
        //self.layer.transform = transform
        self.layer.transform = CATransform3DMakeRotation(angle, 1.0, 0.0, 0.0)
    }
    
    // MARK: 4.3、沿 Y 轴方向旋转多少度(3D旋转)
    /// 沿 Y 轴方向旋转多少度
    /// - Parameter angle: 旋转角度，angle参数是旋转的角度，为弧度制 0-2π
    public func set3DRotationY(_ angle: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, angle, 0.0, 1.0, 0.0)
        self.layer.transform = transform
    }
    
    // MARK: 4.4、沿 Z 轴方向旋转多少度(3D旋转)
    /// 沿 Z 轴方向旋转多少度
    /// - Parameter angle: 旋转角度，angle参数是旋转的角度，为弧度制 0-2π
    public func set3DRotationZ(_ angle: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, angle, 0.0, 0.0, 1.0)
        self.layer.transform = transform
    }
    
    // MARK: 4.5、沿 X、Y、Z 轴方向同时旋转多少度(3D旋转)
    /// 沿 X、Y、Z 轴方向同时旋转多少度(3D旋转)
    /// - Parameters:
    ///   - xAngle: x 轴的角度，旋转的角度，为弧度制 0-2π
    ///   - yAngle: y 轴的角度，旋转的角度，为弧度制 0-2π
    ///   - zAngle: z 轴的角度，旋转的角度，为弧度制 0-2π
    public func setRotation(xAngle: CGFloat, yAngle: CGFloat, zAngle: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, xAngle, 1.0, 0.0, 0.0)
        transform = CATransform3DRotate(transform, yAngle, 0.0, 1.0, 0.0)
        transform = CATransform3DRotate(transform, zAngle, 0.0, 0.0, 1.0)
        self.layer.transform = transform
    }
    
    // MARK: 4.6、设置 x,y 缩放
    /// 设置 x,y 缩放
    /// - Parameters:
    ///   - x: x 放大的倍数
    ///   - y: y 放大的倍数
    public func setScale(x: CGFloat, y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DScale(transform, x, y, 1)
        self.layer.transform = transform
    }
    
    // MARK: 4.7、水平或垂直翻转
    /// 水平或垂直翻转
    public func flip(isHorizontal: Bool) {
        if isHorizontal {
            // 水平
            self.transform = self.transform.scaledBy(x: -1.0, y: 1.0)
        } else {
            // 垂直
            self.transform = self.transform.scaledBy(x: 1.0, y: -1.0)
        }
    }
    
    // MARK: 4.8、移动到指定中心点位置
    /// 移动到指定中心点位置
    public func moveToPoint(point: CGPoint) {
        var center = self.center
        center.x = point.x
        center.y = point.y
        self.center = center
    }
}

// MARK: - 五、关于UIView的 圆角、阴影、边框、虚线 的设置
public extension UIView {
    
    // MARK: 5.1、添加圆角
    /// 添加圆角
    /// - Parameters:
    ///   - conrners: 具体哪个圆角
    ///   - radius: 圆角的大小
    func addCorner(conrners: UIRectCorner , radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    // MARK: 5.2、添加圆角和边框
    /// 添加圆角和边框
    /// - Parameters:
    ///   - conrners: 具体哪个圆角
    ///   - radius: 圆角的大小
    ///   - borderWidth: 边框的宽度
    ///   - borderColor: 边框的颜色
    func addCorner(conrners: UIRectCorner , radius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        
        // Add border
        let borderLayer = CAShapeLayer()
        borderLayer.path = maskLayer.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame =  self.bounds
        self.layer.addSublayer(borderLayer)
    }
    
    // MARK: 5.3、给继承于view的类添加阴影
    /// 给继承于view的类添加阴影
    /// - Parameters:
    ///   - shadowColor: 阴影的颜色
    ///   - shadowOffset: 阴影的偏移度：CGSizeMake(X[正的右偏移,负的左偏移], Y[正的下偏移,负的上偏移])
    ///   - shadowOpacity: 阴影的透明度
    ///   - shadowRadius: 阴影半径，默认 3
    func addShadow(shadowColor: UIColor, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat = 3) {
        // 设置阴影颜色
        self.layer.shadowColor = shadowColor.cgColor
        // 设置透明度
        self.layer.shadowOpacity = shadowOpacity
        // 设置阴影半径
        self.layer.shadowRadius = shadowRadius
        // 设置阴影偏移量
        self.layer.shadowOffset = shadowOffset
    }
    
    // MARK: 5.4、添加阴影和圆角并存
    /// 添加阴影和圆角并存
    ///
    /// - Parameter superview: 父视图
    /// - Parameter conrners: 具体哪个圆角
    /// - Parameter radius: 圆角大小
    /// - Parameter shadowColor: 阴影的颜色
    /// - Parameter shadowOffset: 阴影的偏移度：CGSizeMake(X[正的右偏移,负的左偏移], Y[正的下偏移,负的上偏移])
    /// - Parameter shadowOpacity: 阴影的透明度
    /// - Parameter shadowRadius: 阴影半径，默认 3
    ///
    /// - Note: 提示：如果在异步布局(如：SnapKit布局)中使用，要在布局后先调用 layoutIfNeeded，再使用该方法
    func addCornerAndShadow(superview: UIView, conrners: UIRectCorner , radius: CGFloat = 3, shadowColor: UIColor, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat = 3) {
        
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        
        let subLayer = CALayer()
        let fixframe = self.frame
        subLayer.frame = fixframe
        subLayer.cornerRadius = shadowRadius
        subLayer.backgroundColor = shadowColor.cgColor
        subLayer.masksToBounds = false
        // shadowColor阴影颜色
        subLayer.shadowColor = shadowColor.cgColor
        // shadowOffset阴影偏移,x向右偏移3，y向下偏移2，默认(0, -3),这个跟shadowRadius配合使用
        subLayer.shadowOffset = shadowOffset
        // 阴影透明度，默认0
        subLayer.shadowOpacity = shadowOpacity
        // 阴影半径，默认3
        subLayer.shadowRadius = shadowRadius
        superview.layer.insertSublayer(subLayer, below: self.layer)
    }
    
    // MARK: 5.5、添加边框
    /// 添加边框
    /// - Parameters:
    ///   - width: 边框宽度
    ///   - color: 边框颜色
    func addBorder(borderWidth: CGFloat, borderColor: UIColor) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.masksToBounds = true
    }
    
    // MARK: 5.6、添加顶部的 边框
    /// 添加顶部的 边框
    /// - Parameters:
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    func addBorderTop(borderWidth: CGFloat, borderColor: UIColor) {
        self.addBorderUtility(x: 0, y: 0, width: self.frame.width, height: borderWidth, color: borderColor)
    }
    
    // MARK: 5.7、添加顶部的 内边框
    /// 添加顶部的 内边框
    /// - Parameters:
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    ///   - padding: 边框距离边上的距离
    func addBorderTopWithPadding(borderWidth: CGFloat, borderColor: UIColor, padding: CGFloat) {
        self.addBorderUtility(x: padding, y: 0, width: self.frame.width - padding * 2, height: borderWidth, color: borderColor)
    }
    
    // MARK: 5.8、添加底部的 边框
    /// 添加底部的 边框
    /// - Parameters:
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    func addBorderBottom(borderWidth: CGFloat, borderColor: UIColor) {
        self.addBorderUtility(x: 0, y: self.frame.height - borderWidth, width: self.frame.width, height: borderWidth, color: borderColor)
    }
    
    // MARK: 5.9、添加左边的 边框
    /// 添加左边的 边框
    /// - Parameters:
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    func addBorderLeft(borderWidth: CGFloat, borderColor: UIColor) {
        self.addBorderUtility(x: 0, y: 0, width: borderWidth, height: self.frame.height, color: borderColor)
    }
    
    // MARK: 5.10、添加右边的 边框
    /// 添加右边的 边框
    /// - Parameters:
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    func addBorderRight(borderWidth: CGFloat, borderColor: UIColor) {
        self.addBorderUtility(x: self.frame.width - borderWidth, y: 0, width: borderWidth, height: self.frame.height, color: borderColor)
    }
    
    // MARK: 5.11、画圆环
    /// 画圆环
    /// - Parameters:
    ///   - fillColor: 内环的颜色
    ///   - strokeColor: 外环的颜色
    ///   - strokeWidth: 外环的宽度
    func drawCircle(fillColor: UIColor, strokeColor: UIColor, strokeWidth: CGFloat) {
        let ciecleRadius = self.w_width > self.w_height ? self.w_height : self.w_width
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: ciecleRadius, height: ciecleRadius), cornerRadius: ciecleRadius / 2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = strokeWidth
        self.layer.addSublayer(shapeLayer)
    }
    
    // MARK: 5.12、绘制虚线
    /// 绘制虚线
    /// - Parameters:
    ///   - strokeColor: 虚线颜色
    ///   - lineLength: 每段虚线的长度
    ///   - lineSpacing: 每段虚线的间隔
    ///   - direction: 虚线的方向
    func drawDashLine(strokeColor: UIColor,
                       lineLength: Int = 4,
                      lineSpacing: Int = 4,
                        direction: JKDashLineDirection = .horizontal) {
        // 线粗
        let lineWidth = direction == .horizontal ? self.w_height : self.w_width
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = self.bounds
        shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
        shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPhase = 0
        // 每一段虚线长度 和 每两段虚线之间的间隔
        shapeLayer.lineDashPattern = [NSNumber(value: lineLength), NSNumber(value: lineSpacing)]
        // 起点
        let path = CGMutablePath()
        if direction == .horizontal {
            path.move(to: CGPoint(x: 0, y: lineWidth / 2))
            // 终点
            // 横向 y = lineWidth / 2
            path.addLine(to: CGPoint(x: self.w_width, y: lineWidth / 2))
        } else {
            path.move(to: CGPoint(x: lineWidth / 2, y: 0))
            // 终点
            // 纵向 Y = view 的height
            path.addLine(to: CGPoint(x: lineWidth / 2, y: self.w_height))
        }
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }
    
    // MARK: 5.13、添加内阴影
    /// 添加内阴影
    /// - Parameters:
    ///   - shadowColor: 阴影的颜色
    ///   - shadowOffset: 阴影的偏移度：CGSizeMake(X[正的右偏移,负的左偏移], Y[正的下偏移,负的上偏移])
    ///   - shadowOpacity: 阴影的透明度
    ///   - shadowRadius: 阴影半径，默认 3
    ///   - insetBySize: 内阴影偏移大小
    func addInnerShadowLayer(shadowColor: UIColor, shadowOffset: CGSize = CGSize(width: 0, height: 0), shadowOpacity: Float = 0.5, shadowRadius: CGFloat = 3, insetBySize: CGSize = CGSize(width: -42, height: -42)) {
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = self.bounds
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowOffset = shadowOffset
        shadowLayer.shadowOpacity = shadowOpacity
        shadowLayer.shadowRadius = shadowRadius
        shadowLayer.fillRule = .evenOdd
        let path = CGMutablePath()
        path.addRect(self.bounds.insetBy(dx: insetBySize.width, dy: insetBySize.height))
      
        // let someInnerPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: innerPathRadius).cgPath
        let someInnerPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: shadowRadius).cgPath
        path.addPath(someInnerPath)
        path.closeSubpath()
        shadowLayer.path = path
        let maskLayer = CAShapeLayer()
        maskLayer.path = someInnerPath
        shadowLayer.mask = maskLayer
        self.layer.addSublayer(shadowLayer)
    }
    
    // MARK: 5.14、毛玻璃效果
    /// 毛玻璃效果
    /// - Parameters:
    ///   - alpha: 可设置模糊的程度(0-1)，越大模糊程度越大
    ///   - size: 毛玻璃的size
    ///   - style: 模糊效果
    func effectViewWithAlpha(alpha: CGFloat = 1.0, size: CGSize? = nil, style: UIBlurEffect.Style = .light) {
        // 模糊视图的大小
        var visualEffectViewSize = CGSize(width: 0, height: 0)
        if let weakSize = size {
            visualEffectViewSize = weakSize
        } else {
            visualEffectViewSize = self.w_size
        }
        let visualEffectView = UIVisualEffectView.visualEffectView(size: visualEffectViewSize, alpha: alpha, style: style, isAddVibrancy: false)
        self.addSubview(visualEffectView)
    }
}

// MARK: - 七、其他的方法
// 抖动方向枚举
public enum JKShakeDirection: Int {
    case horizontal  //水平抖动
    case vertical  //垂直抖动
}

public extension UIView {
    
    // MARK: 7.1、获取当前view的viewcontroller
    /// 获取当前view的viewcontroller
    var currentVC: UIViewController? {
        /**
         实现原理
         通过消息响应者链找到 UIView 所在的 UIViewController。
         UIView 类继承于 UIResponder，通过 UIResponder 的next 方法来获取 UIViewController。
         如果 next 返回是空，则继续向上遍历 superview 并再次使用 next 方法获取。这样一直找下去，直到找到或抛出异常。
         */
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    // MARK: 7.2、添加水印
    /// 添加水印
    /// - Parameters:
    ///   - markText: 水印文字
    ///   - textColor: 水印文字颜色
    ///   - font: 水印文字大小
    func addWater(markText: String, textColor: UIColor = UIColor.black, font: UIFont = UIFont.systemFont(ofSize: 12)) {
        let waterMark: NSString = markText.toNSString
        let textSize: CGSize = waterMark.size(withAttributes: [NSAttributedString.Key.font : font])
        // 多少行
        let line: NSInteger = NSInteger(self.w_height * 3.5 / 80)
        // 多少列：自己的宽度/(每个水印的宽度+间隔)
        let row: NSInteger = NSInteger(self.w_width / markText.rectWidth(font: font, size: CGSize(width: self.w_width, height: CGFloat(MAXFLOAT))))
        for i in 0..<line {
            for j in 0..<row {
                let textLayer: CATextLayer = CATextLayer()
                // textLayer.backgroundColor = UIColor.randomColor().cgColor
                //按当前屏幕分辨显示，否则会模糊
                textLayer.contentsScale = UIScreen.main.scale
                textLayer.font = font
                textLayer.fontSize = font.pointSize
                textLayer.foregroundColor = textColor.cgColor
                textLayer.string = waterMark
                textLayer.frame = CGRect(x: CGFloat(j) * (textSize.width + 30), y: CGFloat(i) * 60, width: textSize.width, height: textSize.height)
                // 旋转文字
                textLayer.transform = CATransform3DMakeRotation(CGFloat(Double.pi*0.2), 0, 0, 3)
                self.layer.addSublayer(textLayer)
            }
        }
    }
    
    // MARK: 7.4、添加点击事件
    /// 添加点击事件
    /// - Parameters:
    ///   - target: 监听对象
    ///   - selector: 方法
    func addTapGestureRecognizerAction(_ target : Any ,_ selector : Selector) {
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: target, action: selector))
    }
    
    // MARK: 7.5、键盘收起来
    /// 键盘收起来
    func keyboardEndEditing() {
        self.endEditing(true)
    }
    
    // MARK: 7.6、视图抖动
    /// 视图抖动
    /// - Parameters:
    ///   - direction: 抖动方向（默认是水平方向）
    ///   - times: 抖动次数（默认5次）
    ///   - interval: 每次抖动时间（默认0.1秒）
    ///   - delta: 抖动偏移量（默认2）
    ///   - completion: 抖动动画结束后的回调
    func shake(direction: JKShakeDirection = .horizontal, times: Int = 3, interval: TimeInterval = 0.1, delta: CGFloat = 2, completion: (() -> Void)? = nil) {
        // 播放动画
        UIView.animate(withDuration: interval, animations: {
            switch direction {
            case .horizontal:
                self.layer.setAffineTransform(CGAffineTransform(translationX: delta, y: 0))
                break
            case .vertical:
                self.layer.setAffineTransform(CGAffineTransform(translationX: 0, y: delta))
                break
            }
        }) { (complete) -> Void in
            // 如果当前是最后一次抖动，则将位置还原，并调用完成回调函数
            if (times == 0) {
                UIView.animate(withDuration: interval, animations: { () -> Void in
                    self.layer.setAffineTransform(CGAffineTransform.identity)
                }, completion: { (complete) -> Void in
                    completion?()
                })
            } else {
                // 如果当前不是最后一次抖动，则继续播放动画（总次数减1，偏移位置变成相反的）
                self.shake(direction: direction, times: times - 1,  interval: interval, delta: delta * -1, completion:completion)
            }
        }
    }
    
    // MARK: 7.7、是否包含WKWebView
    /// 是否包含WKWebView
    /// - Returns: 结果
//    func isContainsWKWebView() -> Bool {
//        if self.isKind(of: WKWebView.self) {
//            return true
//        }
//        for subView in self.subviews {
//            if (subView.isContainsWKWebView()) {
//                return true
//            }
//        }
//        return false
//    }
}

// MARK: - private method
extension UIView {
    /// 边框的私有内容
    fileprivate func addBorderUtility(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }
}

// MARK: 八、视图调试
//public extension UIView {
//    
//    // MARK: 8.1、图层调试(兼容OC)
//    /// 图层调试(兼容OC)
//    /// - Parameters:
//    ///   - borderWidth: 视图的边框宽度
//    ///   - borderColor: 视图的边框颜色
//    ///   - backgroundColor: 视图的背景色
//    func getViewLayer(borderWidth: CGFloat = 0.5, borderColor: UIColor = .randomColor(), backgroundColor: UIColor = .randomColor()) {
//        #if DEBUG
//        let subviews = self.subviews
//        if subviews.count == 0 {
//            return
//        }
//        for subview in subviews {
//            subview.layer.borderWidth = borderWidth
//            subview.layer.borderColor = borderColor.cgColor
//            subview.backgroundColor = backgroundColor
//            subview.getViewLayer(borderWidth: borderWidth, borderColor: borderColor, backgroundColor: backgroundColor)
//        }
//        #endif
//    }
//    
//    // MARK: 8.2、寻找某个类型子视图
//    /// 寻找某个类型子视图
//    /// - Parameters:
//    ///   - type: 子视图类型
//    ///   - resursion: 是否递归查找
//    /// - Returns: 返回找到的子视图
//    @discardableResult
//    func findSubview(type: UIResponder.Type, resursion: Bool)-> UIView? {
//        for e in self.subviews.enumerated() {
//            if e.element.isKind(of: type) {
//                return e.element
//            }
//        }
//        // 是否递归查找
//        guard resursion == true else {
//            return nil
//        }
//        for e in self.subviews.enumerated() {
//            let tmpView = e.element.findSubview(type: type, resursion: resursion)
//            if tmpView != nil {
//                return tmpView
//            }
//        }
//        return nil
//    }
//    
//    // MARK: 8.3、移除所有的子视图
//    /// 移除所有的子视图
//    func removeAllSubViews() {
//        for subView in self.subviews {
//            subView.removeFromSuperview()
//        }
//    }
//    
//    // MARK: 8.4、移除layer
//    /// 移除layer
//    /// - Returns: 返回自身
//    @discardableResult
//    func removeLayer() -> Self {
//        self.layer.mask = nil
//        self.layer.borderWidth = 0
//        return self
//    }
//}

// MARK: 九、手势的扩展
public extension UIView {
    // MARK: 9.2、手势 - 单击
    /// 手势 - 单击
    /// - Parameter action: 事件
    /// - Returns: 手势
    @discardableResult
    func addGestureTap(_ action: @escaping RecognizerClosure) -> UITapGestureRecognizer {
        let obj = UITapGestureRecognizer(target: nil, action: nil)
        // 轻点次数
        obj.numberOfTapsRequired = 1
        // 手指个数
        obj.numberOfTouchesRequired = 1
        addCommonGestureRecognizer(obj)
        obj.addAction { (recognizer) in
            action(recognizer)
        }
        return obj
    }

    // MARK: 9.3、手势 - 长按
    /// 手势 - 长按
    /// - Parameters:
    ///   - action: 事件
    ///   - minimumPressDuration: 长按的时间
    /// - Returns: 手势
    @discardableResult
    func addGestureLongPress(_ action: @escaping RecognizerClosure, for minimumPressDuration: TimeInterval) -> UILongPressGestureRecognizer {
        let obj = UILongPressGestureRecognizer(target: nil, action: nil)
        obj.minimumPressDuration = minimumPressDuration
        addCommonGestureRecognizer(obj)
        obj.addAction { (recognizer) in
            action(recognizer)
        }
        return obj
    }
      
    // MARK: 9.4、手势 - 拖拽
    /// 手势 - 拖拽
    /// - Parameter action: 事件
    /// - Returns: 手势
    @discardableResult
    func addGesturePan(_ action: @escaping RecognizerClosure) -> UIPanGestureRecognizer {
        let obj = UIPanGestureRecognizer(target: nil, action: nil)
        // 最大最小的手势触摸次数
        obj.minimumNumberOfTouches = 1
        obj.maximumNumberOfTouches = 3
        addCommonGestureRecognizer(obj)
          
        obj.addAction { (recognizer) in
            if let sender = recognizer as? UIPanGestureRecognizer, let senderView = sender.view {
                let translate: CGPoint = sender.translation(in: senderView.superview)
                senderView.center = CGPoint(x: senderView.center.x + translate.x, y: senderView.center.y + translate.y)
                sender.setTranslation( .zero, in: senderView.superview)
                action(recognizer)
            }
        }
        return obj
    }
      
    // MARK: 9.5、手势 - 屏幕边缘
    /// 手势 - 屏幕边缘
    /// - Parameters:
    ///   - target: 监听对象
    ///   - action: 事件
    ///   - edgs: 哪边缘手势
    /// - Returns: 手势
    @discardableResult
    func addGestureEdgPan(_ target: Any?, action: Selector?, for edgs: UIRectEdge) -> UIScreenEdgePanGestureRecognizer {
        let obj = UIScreenEdgePanGestureRecognizer(target: target, action: action)
        obj.edges = edgs
        addCommonGestureRecognizer(obj)
        return obj
    }
    
    // MARK: 9.6、手势 - 屏幕边缘(闭包) - 靠近屏幕边缘的视图即可
    /// 手势 - 屏幕边缘(闭包)
    /// - Parameters:
    ///   - action: 事件
    ///   - edgs: 哪边缘手势
    /// - Returns: 手势
    @discardableResult
    func addGestureEdgPan(_ action: @escaping RecognizerClosure, for edgs: UIRectEdge) -> UIScreenEdgePanGestureRecognizer {
        let obj = UIScreenEdgePanGestureRecognizer(target: nil, action: nil)
        obj.edges = edgs
        addCommonGestureRecognizer(obj)
        obj.addAction { (recognizer) in
            action(recognizer)
        }
        return obj
    }
      
    // MARK: 9.7、手势 - 清扫
    /// 手势 - 清扫
    /// - Parameters:
    ///   - target: 对象
    ///   - action: 事件
    ///   - direction: 清扫的方向
    /// - Returns: 手势
    @discardableResult
    func addGestureSwip(_ target: Any?, action: Selector?, for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        let obj = UISwipeGestureRecognizer(target: target, action: action)
        obj.direction = direction
        addCommonGestureRecognizer(obj)
        return obj
    }
    
    // MARK: 9.8、手势 - 清扫
    /// 手势 - 清扫
    /// - Parameters:
    ///   - action: 事件
    ///   - direction: 清扫的方向
    /// - Returns: 手势
    @discardableResult
    func addGestureSwip(_ action: @escaping RecognizerClosure, for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        let obj = UISwipeGestureRecognizer(target: nil, action: nil)
        obj.direction = direction
        addCommonGestureRecognizer(obj)
        obj.addAction { (recognizer) in
            action(recognizer)
        }
        return obj
    }
      
    // MARK: 9.9、手势 - 捏合
    /// 手势 - 捏合
    /// - Parameter action: 事件
    /// - Returns: 手势
    @discardableResult
    func addGesturePinch(_ action: @escaping RecognizerClosure) -> UIPinchGestureRecognizer {
        let obj = UIPinchGestureRecognizer(target: nil, action: nil)
        addCommonGestureRecognizer(obj)
        obj.addAction { (recognizer) in
            if let sender = recognizer as? UIPinchGestureRecognizer {
                let location = recognizer.location(in: sender.view!.superview)
                sender.view!.center = location
                sender.view!.transform = sender.view!.transform.scaledBy(x: sender.scale, y: sender.scale)
                sender.scale = 1.0
                action(recognizer)
            }
        }
        return obj
    }
    
    // MARK: 9.10、手势 - 旋转
    /// 手势 - 旋转
    /// - Parameter action: 事件
    /// - Returns: 手势
    @discardableResult
    func addGestureRotation(_ action: @escaping RecognizerClosure) -> UIRotationGestureRecognizer {
        let obj = UIRotationGestureRecognizer(target: nil, action: nil)
        addCommonGestureRecognizer(obj)
        obj.addAction { (recognizer) in
            if let sender = recognizer as? UIRotationGestureRecognizer {
                sender.view!.transform = sender.view!.transform.rotated(by: sender.rotation)
                sender.rotation = 0.0
                action(recognizer)
            }
        }
        return obj
    }
    
    // MARK: 通用支持手势的方法 - private
    private func addCommonGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer) {
        self.isUserInteractionEnabled = true
        self.isMultipleTouchEnabled = true
        self.addGestureRecognizer(gestureRecognizer)
    }
}

// MARK: - 十、颜色渐变
public extension UIView {

    // MARK: 添加渐变色图层
    /// 添加渐变色图层
    /// - Parameters:
    ///   - direction: 渐变方向
    ///   - gradientColors: 渐变的颜色数组（颜色的数组是）
    ///   - gradientLocations: 决定每个渐变颜色的终止位置，这些值必须是递增的，数组的长度和 colors 的长度最好一致
    public func gradientColor(_ direction: JKViewGradientDirection = .horizontal, _ gradientColors: [Any], _ gradientLocations: [NSNumber]? = nil, layerName: String? = nil) {
        // 获取渐变对象
        let gradientLayer = CAGradientLayer().gradientLayer(direction, gradientColors, gradientLocations)
        gradientLayer.name = layerName
        // 设置其CAGradientLayer对象的frame，并插入view的layer
        gradientLayer.frame = self.bounds // CGRect(x: 0, y: 0, width: self.w_width, height: self.w_height)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // MARK: 10.2、colors 变化渐变动画
    /// colors 变化渐变动画
    /// - Parameters:
    ///   - direction: 渐变方向
    ///   - startGradientColors: 开始渐变的颜色数组
    ///   - endGradientColors: 结束渐变的颜色数组
    ///   - gradientLocations: 决定每个渐变颜色的终止位置，这些值必须是递增的，数组的长度和 colors 的长度最好一致
    func gradientColorAnimation(direction: JKViewGradientDirection = .horizontal, startGradientColors: [Any], endGradientColors: [Any], duration: CFTimeInterval = 1.0, gradientLocations: [NSNumber]? = nil) {
        // 获取渐变对象
        let gradientLayer = CAGradientLayer().gradientLayer(direction, startGradientColors, gradientLocations)
        // 设置其CAGradientLayer对象的frame，并插入view的layer
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.w_width, height: self.w_height)
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        startgradientColorAnimation(gradientLayer, startGradientColors, endGradientColors, duration)
    }
    
    private func startgradientColorAnimation(_ gradientLayer: CAGradientLayer, _ startGradientColors: [Any], _ endGradientColors: [Any], _ duration: CFTimeInterval = 1.0) {
        // 添加渐变动画
        let colorChangeAnimation = CABasicAnimation(keyPath: "colors")
        // colorChangeAnimation.delegate = self
        colorChangeAnimation.duration = duration
        colorChangeAnimation.fromValue = startGradientColors
        colorChangeAnimation.toValue = endGradientColors
        colorChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
        // 动画结束后保持最终的效果
        colorChangeAnimation.isRemovedOnCompletion = false
        gradientLayer.add(colorChangeAnimation, forKey: "colorChange")
    }
}

import UIKit

extension UIView {
    
    /// Description 添加阴影 to View
    /// - Parameters:
    ///   - sColor: sColor description
    ///   - offset: offset description
    ///   - opacity: opacity description
    ///   - radius: radius description
    public func setShadow(sColor: UIColor = UIColor.gray,
                   offset: CGSize = CGSize(width: 0.0, height: 0.0),
                   opacity: Float = 0.5,
                   radius: CGFloat = 3) {
        //设置阴影颜色
        self.layer.shadowColor = sColor.cgColor
        //设置透明度
        self.layer.shadowOpacity = opacity
        //设置阴影半径
        self.layer.shadowRadius = radius
        //设置阴影偏移量
        self.layer.shadowOffset = offset
        // 默认nil，系统自动配置
//        self.layer.shadowPath = UIBezierPath(rect: CGRect(x: self.bounds.origin.x - offset.width,
//                                                          y: self.bounds.origin.y - offset.height,
//                                                          width: self.bounds.width + offset.width*2,
//                                                          height: self.bounds.height + offset.height*2)).cgPath
    }

    /// Description 添加阴影 to View (高性能)
    /// - Parameters:
    ///   - sColor: sColor description
    ///   - offset: offset description
    ///   - opacity: opacity description
    ///   - radius: radius description
    public func setShadowNormal(sColor: UIColor = UIColor.gray,
                   offset: CGSize = CGSize(width: 0.0, height: 0.0),
                   opacity: Float = 0.5,
                   radius: CGFloat = 3) {
        //设置阴影颜色
        self.layer.shadowColor = sColor.cgColor
        //设置透明度
        self.layer.shadowOpacity = opacity
        
//        self.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: self.bounds.origin.y+offset.width, y: imageView.bounds.origin.y+offset.height, width: <#T##CGFloat#>, height: <#T##CGFloat#>), cornerRadius: radius).cgPath
//
//
//        //设置阴影半径
        self.layer.shadowRadius = radius
//        //设置阴影偏移量
        self.layer.shadowOffset = offset
//        // 默认nil，系统自动配置
////        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//        imageView.layer.shadowPath = [[UIBezierPath bezierPathWithRect:CGRectMake(imageView.bounds.origin.x+5, imageView.bounds.origin.y+5, imageView.bounds.size.width, imageView.bounds.size.height)] CGPath];
//        imageView.layer.shadowOpacity = 0.6;
//
//        imageView.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
//        imageView.layer.shadowRadius = 5.0f;
//        imageView.layer.shadowOpacity = 0.6;
    }
    
    
    
    
    private struct AssociatedKeys {
        static var descriptiveName = "AssociatedKeys.DescriptiveName.blurView"
    }

    private (set) var blurView: BlurView {
        get {
            if let blurView = objc_getAssociatedObject(
                self,
                &AssociatedKeys.descriptiveName
                ) as? BlurView {
                return blurView
            }
            self.blurView = BlurView(to: self)
            return self.blurView
        }
        set(blurView) {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.descriptiveName,
                blurView,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }

    class BlurView {

        private var superview: UIView
        private var blur: UIVisualEffectView?
        private var editing: Bool = false
        private (set) var blurContentView: UIView?
        private (set) var vibrancyContentView: UIView?

        var animationDuration: TimeInterval = 0.1

        /**
         * Blur style. After it is changed all subviews on
         * blurContentView & vibrancyContentView will be deleted.
         */
        var style: UIBlurEffect.Style = .light {
            didSet {
                guard oldValue != style,
                    !editing else { return }
                applyBlurEffect()
            }
        }
        /**
         * Alpha component of view. It can be changed freely.
         */
        var alpha: CGFloat = 0 {
            didSet {
                guard !editing else { return }
                if blur == nil {
                    applyBlurEffect()
                }
                let alpha = self.alpha
                UIView.animate(withDuration: animationDuration) {
                    self.blur?.alpha = alpha
                }
            }
        }

        init(to view: UIView) {
            self.superview = view
        }

        func setup(style: UIBlurEffect.Style, alpha: CGFloat) -> Self {
            self.editing = true

            self.style = style
            self.alpha = alpha

            self.editing = false

            return self
        }

        func enable(isHidden: Bool = false) {
            if blur == nil {
                applyBlurEffect()
            }

            self.blur?.isHidden = isHidden
        }

        private func applyBlurEffect() {
            blur?.removeFromSuperview()

            applyBlurEffect(
                style: style,
                blurAlpha: alpha
            )
        }

        private func applyBlurEffect(style: UIBlurEffect.Style,
                                     blurAlpha: CGFloat) {
            superview.backgroundColor = UIColor.clear

            let blurEffect = UIBlurEffect(style: style)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)

            let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
            let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
            blurEffectView.contentView.addSubview(vibrancyView)

            blurEffectView.alpha = blurAlpha

            superview.insertSubview(blurEffectView, at: 0)

            blurEffectView.addAlignedConstrains()
            vibrancyView.addAlignedConstrains()

            self.blur = blurEffectView
            self.blurContentView = blurEffectView.contentView
            self.vibrancyContentView = vibrancyView.contentView
        }
    }

    private func addAlignedConstrains() {
        translatesAutoresizingMaskIntoConstraints = false
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.top)
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.leading)
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.trailing)
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.bottom)
    }

    private func addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute) {
        superview?.addConstraint(
            NSLayoutConstraint(
                item: self,
                attribute: attribute,
                relatedBy: NSLayoutConstraint.Relation.equal,
                toItem: superview,
                attribute: attribute,
                multiplier: 1,
                constant: 0
            )
        )
    }
}

//public protocol LayoutGuideProvider {
//    var topAnchor: NSLayoutYAxisAnchor { get }
//    var bottomAnchor: NSLayoutYAxisAnchor { get }
//}
//extension UILayoutGuide: LayoutGuideProvider {}
//
//public class CustomLayoutGuide: LayoutGuideProvider {
//    public let topAnchor: NSLayoutYAxisAnchor
//    public let bottomAnchor: NSLayoutYAxisAnchor
//    init(topAnchor: NSLayoutYAxisAnchor, bottomAnchor: NSLayoutYAxisAnchor) {
//        self.topAnchor = topAnchor
//        self.bottomAnchor = bottomAnchor
//    }
//}
//
//@available(*, deprecated, message: "use gender instand of it")
//extension UIViewController {
//    @objc public var layoutInsets: UIEdgeInsets {
//        if #available(iOS 11.0, *) {
//            return view.safeAreaInsets
//        } else {
//            return UIEdgeInsets(top: topLayoutGuide.length,
//                                left: 0.0,
//                                bottom: bottomLayoutGuide.length,
//                                right: 0.0)
//        }
//    }
//
//    public var layoutGuide: LayoutGuideProvider {
//        if #available(iOS 11.0, *) {
//            return view!.safeAreaLayoutGuide
//        } else {
//            return CustomLayoutGuide(topAnchor: topLayoutGuide.bottomAnchor,
//                                     bottomAnchor: bottomLayoutGuide.topAnchor)
//        }
//    }
//}

//protocol SideLayoutGuideProvider {
//    var leftAnchor: NSLayoutXAxisAnchor { get }
//    var rightAnchor: NSLayoutXAxisAnchor { get }
//}
//
//extension UIView: SideLayoutGuideProvider {}
//extension UILayoutGuide: SideLayoutGuideProvider {}
//
//// The reason why UIView has no extensions of safe area insets and top/bottom guides
//// is for iOS10 compat.
//extension UIView {
//    var sideLayoutGuide: SideLayoutGuideProvider {
//        if #available(iOS 11.0, *) {
//            return safeAreaLayoutGuide
//        } else {
//            return self
//        }
//    }
//
//    var presentationFrame: CGRect {
//        return layer.presentation()?.frame ?? frame
//    }
//}

extension UIView {
//    func disableAutoLayout() {
//        let frame = self.frame
//        translatesAutoresizingMaskIntoConstraints = true
//        self.frame = frame
//    }
//    func enableAutoLayout() {
//        translatesAutoresizingMaskIntoConstraints = false
//    }

    static func performWithLinear(startTime: Double = 0.0, relativeDuration: Double = 1.0, _ animations: @escaping (() -> Void)) {
        UIView.animateKeyframes(withDuration: 0.0, delay: 0.0, options: [.calculationModeCubic], animations: {
            UIView.addKeyframe(withRelativeStartTime: startTime, relativeDuration: relativeDuration, animations: animations)
        }, completion: nil)
    }
}

extension UIView {
    /// 圆角
    public func setCorners(corners:UIRectCorner,corner: CGFloat = 6) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: corner, height: corner))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}

extension UIView {
    
//    static func activate(constraints: [NSLayoutConstraint]) {
//        constraints.forEach { ($0.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false }
//        NSLayoutConstraint.activate(constraints)
//    }
//    
//    public func pin(to view: UIView, insets: UIEdgeInsets = .zero) {
//        UIView.activate(constraints: [
//            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
//            leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left),
//            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom),
//            rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right)
//        ])
//    }
    
//    func center(in view: UIView, offset: UIOffset = .zero) {
//        UIView.activate(constraints: [
//            centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: offset.horizontal),
//            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: offset.vertical)
//        ])
//    }
    
    
    /// 🌿🌿🌿🌿🌿带约束的添加到父视图上
    /// - Parameters:
    ///   - subView: 子View
    ///   - insets: 间距
    public func addSubviewAnchor(subView: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        self.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        let top = subView.topAnchor.constraint(equalTo: self.topAnchor, constant: insets.top)
        let leading = subView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: insets.left)
        let trailing = subView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -insets.right)
        let bottom = subView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -insets.bottom)
        NSLayoutConstraint.activate([top, leading, trailing, bottom])
    }
    
}



public extension UIView {
    
    // MARK: 7.3、将 View 转换成图片
    /// 将 View 转换成图片
    /// - Returns: 图片
    func toImage() -> UIImage? {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        self.layer.render(in: context)
        let viewImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return viewImage
    }
}

#elseif os(macOS)
import Cocoa

public extension NSView {
    public func asImage() -> NSImage? {
        NSImage(size: bounds.size, flipped: false) { [weak self] rect in
            guard let self,
                  let rep = bitmapImageRepForCachingDisplay(in: rect)
            else { return false }

            cacheDisplay(in: rect, to: rep)
            return rep.draw()
        }
    }
}
#endif
