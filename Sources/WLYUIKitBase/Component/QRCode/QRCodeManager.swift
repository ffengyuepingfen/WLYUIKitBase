//
//  QRCodeManager.swift
//  DynamicBusClient
//
//  Created by zhonghangxun on 2019/6/25.
//  Copyright © 2019 WLY. All rights reserved.
//

import UIKit

public class QRCodeManager {
    
    /// 字符串生成二维码
    public static func imageOfQRFromContect(content: String, qrColor: UIColor = .black) -> UIImage? {
        if content == "" {
            return nil
        }
        
//        let size = QRCodeManager.limitCodeSize(codeSize: codeSize)
        
        let outputImage = QRCodeManager.QRFromContent(content: content, color: qrColor)
//        let finalImage = QRCodeManager.createUIImageFormCIImage(image: outputImage, size: size)
        return outputImage
    }
    /// data生成二维码
    public static func imageOfQRFromContect2(content: Data, qrColor: UIColor = .black) -> UIImage? {
        
//        let size = QRCodeManager.limitCodeSize(codeSize: codeSize)
        
        let outputImage = QRCodeManager.QRFromContent(content: content, color: qrColor)
//        let finalImage = QRCodeManager.createUIImageFormCIImage(image: outputImage, size: size)
        return outputImage
    }
    
    /// 生成带logo的二维码
    public static func imageOfQRFromContect(content: String,
                                            qrColor: UIColor = .black,
                                            logoName: Data?,
                                            radius:CGFloat,
                                            borderWidth:CGFloat,
                                            borderColor:UIColor) -> UIImage? {
        
        guard let orginQRImage = QRCodeManager.QRFromContent(content: content, color: qrColor) else { return nil }
//        self.imageOfQRFromContect(content: content, codeSize: 200)
        
        guard let imageData = logoName else { return orginQRImage }
        
        //根据二维码图片设置生成水印图片rect
        let waterImageRect = QRCodeManager.getWaterImageRectFromOutputQRImage(orginQRImage: orginQRImage )
        
        guard let logo = UIImage(data: imageData)?.scaleToSize(size: waterImageRect.size) else { return orginQRImage }
        //生成水印图片 rect 从00 开始
        let logoImage = logo.toCircleRadious(rect: CGRect(x: 0, y: 0, width: waterImageRect.size.width, height: waterImageRect.size.height), radious: radius, borderWith: borderWidth, borderColor: borderColor)
        //添加水印图片
        return orginQRImage.waterImage(waterImage: logoImage, waterImageRect: waterImageRect)
    }
    
    fileprivate static func getWaterImageRectFromOutputQRImage(orginQRImage:UIImage) -> CGRect {
        let linkSize = CGSize(width: orginQRImage.size.width / 6, height: orginQRImage.size.height / 6)
        let linkX:CGFloat = (orginQRImage.size.width - linkSize.width)/2
        let linkY:CGFloat = (orginQRImage.size.height - linkSize.height)/2
        return CGRect(x: linkX, y: linkY, width: linkSize.width, height: linkSize.height)
    }
    
    
    /// 根据url 创建CIImage
    fileprivate static func QRFromContent(content:String, color: UIColor = .black) -> UIImage? {
        
        guard !content.isEmpty else {
            return nil
        }
        
        // 1、创建滤镜对象
        let filter = CIFilter(name: "CIQRCodeGenerator")
        // 恢复滤镜的默认属性
        filter?.setDefaults()
        // 2、设置数据
        let infoData = content.data(using: .utf8)
        filter?.setValue(infoData, forKey: "inputMessage")
        // 3、获得滤镜输出的图像
        let outputImage = filter?.outputImage
        
        return QRCodeManager.fixQRColor(image: outputImage, color: color)
    }

    
    fileprivate static func fixQRColor(image: CIImage?, color: UIColor = .black) -> UIImage? {

        // 创建一个颜色滤镜，黑白色
        let colorFilter = CIFilter(name: "CIFalseColor")
        colorFilter?.setDefaults()
        colorFilter?.setValue(image, forKey: "inputImage")
        // 二维码颜色
        colorFilter?.setValue(CIColor(cgColor: color.cgColor), forKey: "inputColor0")
        // 二维码背景色
        colorFilter?.setValue(CIColor(cgColor: UIColor.white.cgColor), forKey: "inputColor1")
        
        guard let i = colorFilter?.outputImage else { return nil }
        
        // 返回二维码image
        let codeImage = UIImage(ciImage: i.transformed(by: CGAffineTransform(scaleX: 5, y: 5)))

        return codeImage
    }
    
    fileprivate static func QRFromContent(content:Data, color: UIColor = .black) -> UIImage? {
        // 1、创建滤镜对象
        let filter = CIFilter(name: "CIQRCodeGenerator")
        // 恢复滤镜的默认属性
        filter?.setDefaults()
        // 2、设置数据
//        let infoData = content.data(using: .utf8)
        filter?.setValue(content, forKey: "inputMessage")
        // 3、获得滤镜输出的图像
        let outputImage = filter?.outputImage
        return QRCodeManager.fixQRColor(image: outputImage, color: color)
    }
    
    /** 根据CIImage生成指定大小的UIImage */
    fileprivate static func createUIImageFormCIImage(image:CIImage,size:CGFloat) -> UIImage {
        let extent = image.extent.integral
        let scale = min(size/extent.width, size/extent.height)
        // 1.创建bitmap
        let width:size_t = size_t(extent.width*scale)
        let height:size_t = size_t(extent.height*scale)
        
        let cs = CGColorSpaceCreateDeviceGray()
        
        let bitmapRef = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: CGImageAlphaInfo.none.rawValue)
        let context = CIContext()
        
        let bitmapImage = context.createCGImage(image, from: extent)
//        bitmapImage?.colorSpace
        bitmapRef?.interpolationQuality = .none
        bitmapRef?.scaleBy(x: scale, y: scale)
        
        bitmapRef?.draw(bitmapImage!, in: extent)
        
        // 2.保存bitmap到图片
        let scaledImage = bitmapRef?.makeImage()
        
        return UIImage(cgImage: scaledImage!)
        
    }
    
    //限制大小
    fileprivate static func limitCodeSize(codeSize:CGFloat) -> CGFloat {
        var size:CGFloat = 0.0
        size = max(160.0,codeSize)
        size = min(UIScreen.main.bounds.width,codeSize)
        return size
    }
}
