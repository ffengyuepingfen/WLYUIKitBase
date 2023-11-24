//
//  UIImageExtensions.swift
//  U17
//
//  Created by charles on 2017/10/27.
//  Copyright © 2017年 None. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit

extension UIImage {
    /// 字符串转图片
     public static func imageWithUIView(str:String,textColor:UIColor = UIColor.pumkinBlue()) -> UIImage? {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.textAlignment = .center
        label.text = str
        label.textColor = textColor
        label.bounds = CGRect(x: 0, y: 0, width: 48.0, height: 16.0)
        
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, UIScreen.main.scale)
//        UIGraphicsBeginImageContext(label.bounds.size)
        guard let ctx = UIGraphicsGetCurrentContext() else { return nil }
        label.layer.render(in: ctx)
        let tImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tImage
    }

    public class func image(_ text:String,size:(CGFloat,CGFloat),backColor:UIColor=UIColor.clear,textColor:UIColor = UIColor.pumkinBlue(),isCircle:Bool=false) -> UIImage?{
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textAlignment = .center
        label.text = text
        label.textColor = textColor
        label.backgroundColor = backColor
        label.bounds = CGRect(x: 0, y: 0, width: size.0, height: size.1)
        
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, UIScreen.main.scale)
        guard let ctx = UIGraphicsGetCurrentContext() else { return nil }
        if isCircle {
            UIBezierPath(roundedRect: label.bounds, cornerRadius: size.0*0.5).addClip()
        }
        ctx.setFillColor(backColor.cgColor)
        label.layer.render(in: ctx)
        let tImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tImage
    }
    
    /// 生成一张指定颜色的图片
    public static func createImageWithColor(_ color: UIColor, frame: CGRect) -> UIImage? {
        /// 开始绘制 图片的绘制上下文
        UIGraphicsBeginImageContext(frame.size)
        let context = UIGraphicsGetCurrentContext()
        /// 设置填充的颜色
        context?.setFillColor(color.cgColor)
        ///使用填充颜色填充区域
        context?.fill(frame)
        /// 获取当前绘制的图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        /// 结束绘制
        UIGraphicsEndImageContext()
        return image
    }

    /// 生成圆形图片
    public func toCircle() -> UIImage {
        //取最短边长
        let shotest = min(self.size.width, self.size.height)
        //输出尺寸
        let outputRect = CGRect(x: 0, y: 0, width: shotest, height: shotest)
        //开始图片处理上下文（由于输出的图不会进行缩放，所以缩放因子等于屏幕的scale即可） false代表透明
        UIGraphicsBeginImageContextWithOptions(outputRect.size, false, 0)
        let context = UIGraphicsGetCurrentContext()!
        //添加圆形裁剪区域
        context.addEllipse(in: outputRect)
        context.clip()
        //绘制图片
        self.draw(in: CGRect(x: (shotest-self.size.width)/2,
                             y: (shotest-self.size.height)/2,
                             width: self.size.width,
                             height: self.size.height))
        //获得处理后的图片
        let maskedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return maskedImage
        
//        // 第二种实现方向
//        //1、开启上下文
//        UIGraphicsBeginImageContext(self.size)
//        //2.设置剪裁区域
//        let path = UIBezierPath(ovalIn: outputRect)
//        path.addClip()
//        //绘制图片
//        self.draw(at:CGPoint.zero)
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
//        return  newImage
    }
    /// 裁剪带边框的圆形图片
    func toCircle(borderColor:UIColor,borderWidth:CGFloat) -> UIImage {
        
        //取最短边长
        let shotest = min(self.size.width, self.size.height)
        //输出尺寸
        let outputRect = CGRect(x: 0, y: 0, width: shotest, height: shotest)
        
        UIGraphicsBeginImageContext(self.size)
        
        //2、设置边框
        let path = UIBezierPath(ovalIn: outputRect)
        borderColor.setFill()
        path.fill()
        
        //3、设置裁剪区域
        let clipPath = UIBezierPath(ovalIn: CGRect(x: outputRect.origin.x + borderWidth, y: outputRect.origin.x + borderWidth, width: outputRect.size.width - borderWidth * 2, height: outputRect.size.height - borderWidth*2))
        clipPath.addClip()
        
        //3、绘制图片
        self.draw(at: CGPoint.zero)
        
        //4、获取新图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        //5、关闭上下文
        UIGraphicsEndImageContext()
        //6、返回新图片
        return newImage;
    }
    
    /// 固定尺寸的图片
    public func scaleToSize(size:CGSize) -> UIImage {
        /// 添加屏幕的缩放值 避免图片过分模糊
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        // 绘制改变大小的图片
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        // 从当前context中创建一个改变大小后的图片
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        // 使当前的context出堆栈
        UIGraphicsEndImageContext()
        return scaledImage!
    }
    
    // 压缩图片质量 Kb
    public func compressQualityWithMaxLength(_ maxLength: NSInteger) -> Data? {
        var compression: CGFloat = 1.0
        let maxDatalength = maxLength*1024
        guard var vData = self.jpegData(compressionQuality: 1) else { return nil }
//        print("压缩前kb: \( Double((vData.count)/1024))")
        if vData.count < maxDatalength {
            return vData
        }
        var max: CGFloat = 1.0
        var min: CGFloat = 0.0
        
        for _ in 1...6 {
            compression = (min + max)/2
            vData = self.jpegData(compressionQuality: compression)!
            if vData.count < maxDatalength*Int(0.9) {
                min = compression
            }else if vData.count > maxDatalength {
                max = compression
            }else{
//                print("跳过了")
                break
            }
//            print("压缩比: \(compression)")
//            print("压缩后kb: \(Double((vData.count)/1024))")
        }
//        print("压缩后kb: \(Double((vData.count)/1024))")
        return vData
    }
    
    func toCircleRadious(rect:CGRect,radious:CGFloat) -> UIImage {
        //1、开启上下文
        UIGraphicsBeginImageContext(self.size)
        //2、设置裁剪区域
        let path = UIBezierPath(roundedRect: rect, cornerRadius: radious)
        path.addClip()
        //3、绘制图片
        self.draw(at: CGPoint.zero)
        //4、获取新图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        //5、关闭上下文
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// 裁剪带边框的图片 可设置圆角 边框颜色
    func toCircleRadious(rect:CGRect,radious:CGFloat,borderWith:CGFloat,borderColor:UIColor) -> UIImage {
        //1、开启上下文
        UIGraphicsBeginImageContext(self.size)
        //2、设置裁剪区域
        let path = UIBezierPath(roundedRect: rect, cornerRadius: radious)
        borderColor.setFill()
        path.fill()
        
        let clipPath = UIBezierPath(roundedRect: CGRect(x: rect.origin.x + borderWith, y: rect.origin.x + borderWith, width: rect.size.width - borderWith * 2, height: rect.size.height - borderWith*2), cornerRadius: radious)
        clipPath.addClip()
        //3、绘制图片
        self.draw(at: CGPoint.zero)
        //4、获取新图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        //5、关闭上下文
        UIGraphicsEndImageContext()
        return newImage
    }
    /// 添加水印图片
    func waterImage(waterImage:UIImage,waterImageRect:CGRect) -> UIImage {
        //1、开启上下文
        UIGraphicsBeginImageContext(self.size)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        waterImage.draw(in: waterImageRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        //5、关闭上下文
        UIGraphicsEndImageContext()
        return newImage
    }
    /// 改变图片的颜色
    func imageChangeColor(color:UIColor) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        color.setFill()
        let bounds = CGRect(origin: CGPoint.zero, size: self.size)
        //画笔沾取颜色
        UIRectFill(bounds)
        //绘制一次
        self.draw(in: bounds, blendMode: .overlay, alpha: 1.0)
        //再绘制一次
        self.draw(in: bounds, blendMode: .destinationIn, alpha: 1.0)
        //获取图片
        let imgResult = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let img = imgResult else {
            return self
        }
        return img
    }

}

#endif


