//
//  UIAlertExtension.swift
//  CICScheduling
//
//  Created by 中行讯 on 2018/4/18.
//  Copyright © 2018年 Beijing CIC Technology Co., Ltd. All rights reserved.
//

/*
 使用样例
 //弹出普通消息提示框
 UIAlertController.showAlert(message: "保存成功!")
 
 //弹出确认选择提示框
 UIAlertController.showConfirm(message: "是否提交?") { (_) in
 print("点击了确认按钮!")
 }
 */


/*
 //修改title
 NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:@"提示"];
 [alertControllerStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
 [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, 2)];
 [alertController setValue:alertControllerStr forKey:@"attributedTitle"];
 
 //修改message
 NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:@"提示内容"];
 [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0, 4)];
 [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 4)];
 [alertController setValue:alertControllerMessageStr forKey:@"attributedMessage"];
 
 //修改按钮
 if (cancelAction valueForKey:@"titleTextColor") {
 [cancelAction setValue:[UIColor redColor] forKey:@"titleTextColor"];
 }
 */

import UIKit

extension UIAlertController {
    
    /// Description : 展示一个默认两秒后消失的弹框（不带任何选项按钮）
    ///
    /// - Parameters:
    ///   - message: message description:弹框内容
    ///   - duration: duration description:弹框展示时间 默认两秒
    public static func showAlertMessage(message: String,duration:TimeInterval = 2.0) {
        let alertController = UIAlertController(title: message,
                                                message: nil,
                                                preferredStyle: .alert)
        //显示提示框
        if let vc = UIApplication.k_keyWindow?.rootViewController {
            vc.present(alertController, animated: true, completion: nil)
        }
        
        //两秒钟后自动消失
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            if let vc = UIApplication.k_keyWindow?.rootViewController {
                vc.presentedViewController?.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    /// Description 展示一个图片弹框 或者actionSheet
    ///
    /// - Parameters:
    ///   - viewController: 指定的控制器上
    ///   - imageName: 图片的名字
    public static func showImage(in viewController: UIViewController,image:UIImage) {
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
                                                message: nil,
                                                preferredStyle: .actionSheet)
        let width = alertController.view.bounds.size.width - 40
        
        //添加imageView控件
        let imageView = UIImageView(image: image)
        //actionSheet样式尺寸
        imageView.frame = CGRect(x: 10, y: 20,
                                 width: width,
                                 height: width)
        alertController.view.addSubview(imageView)

        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    /// Description 展示一个自定义视图
    ///
    /// - Parameters:
    ///   - custView: custView
    ///   - complated: 回掉确定的内容
    public static func showTextView(custView: UIView,title:String,message:String,cancleTitle:String = "取消",OKTitle:String = "确认",cancled: ((_ message: String) -> Void)? = nil ,complated:@escaping (_ message: String) -> Void) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let count = message.count - 3
        custView.frame = CGRect(x: 10, y: 50,
                                 width: 250,
                                 height: 20*count)
        custView.layer.cornerRadius = 10.0
        alertController.view.addSubview(custView)
        let cancelAction = UIAlertAction(title: cancleTitle, style: .cancel) { (_) in
            if let cancle = cancled {
                cancle("cancle")
            }
        }
        let okAction = UIAlertAction(title: OKTitle, style: .default, handler: {
            _ in
//            print("点击了确定")
            complated("textView.text--send message")
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        if let vc = UIApplication.k_keyWindow?.rootViewController {
            vc.present(alertController, animated: true, completion: nil)
        }
    }

    /// 在指定视图控制器上弹出富文本消息提示框
    static func showAlert(title:String? = nil,message: NSAttributedString,
                          viewController: UIViewController,
                          cancle:Bool = false,
                          complated:(() -> Void)? = nil,
                          tinColor:UIColor = UIColor.pumkinBlue()) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
       
        let sureAction = UIAlertAction(title: "确定", style: .default) { (alert) in
            if let complated = complated {
                complated()
            }
        }
        sureAction.setValue(tinColor, forKey: "titleTextColor")
        alert.addAction(sureAction)
        
        if cancle {
            let canclebutton = UIAlertAction(title: "取消", style: .cancel)
            canclebutton.setValue(tinColor, forKey: "titleTextColor")
            alert.addAction(canclebutton)
        }
        
        //修改按钮
        let paragraph = NSMutableParagraphStyle()
        // 设置行间距
        paragraph.lineSpacing = 3.0
        // 设置段间距
        paragraph.paragraphSpacingBefore = 5.0
        paragraph.alignment = .left

        /* 修改message */
        let attMsgString = NSMutableAttributedString(attributedString: message)
        attMsgString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraph, range: NSRange(location: 0, length: attMsgString.length))
        // 设置字体
        attMsgString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 14.0), range: NSRange(location: 0, length: attMsgString.length))
        // 设置颜色
//        attMsgString.addAttribute(NSAttributedString.Key.foregroundColor, value: tinColor, range: NSRange(location: 0, length: attMsgString.length))
        alert.setValue(attMsgString, forKey: "attributedMessage")
        viewController.present(alert, animated: true)
    }

    
    /// 在根视图控制器上弹出富文本消息提示框
    ///
    /// - Parameters:
    ///   - message: message
    ///   - cancle: 是否有取消按钮
    ///   - complated: 是否有确定回调
    ///   - tinColor: 颜色
    public static func showAlertAttMsg(title:String? = nil,message: NSAttributedString,cancle:Bool = false,complated:(() -> Void)? = nil,tinColor:UIColor = UIColor.pumkinBlue()) {
        if let vc = UIApplication.k_keyWindow?.rootViewController {
            showAlert(title:title,message: message, viewController: vc, cancle: cancle, complated: complated, tinColor: tinColor)
        }
    }

    ///在指定视图控制器上弹出确认框(只有一个确认按钮)
    public static func showConfirm(title: String? = nil,message: String, in viewController: UIViewController,
                            confirm: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: confirm))
        viewController.present(alert, animated: true)
    }

    ///在根视图控制器上弹出确认框(只有一个确认按钮)
    public static func showConfirm(message: String, confirm: ((UIAlertAction) -> Void)?) {
        if let vc = UIApplication.k_keyWindow?.rootViewController {
            showConfirm(message: message, in: vc, confirm: confirm)
        }
    }
    /// 常规的带有确定和取消的弹框
    public static func showNormalAlert(title:String? = nil,message: String,sureMessage:String = "确定", cancleMessage:String = "取消",in viewController: UIViewController? = nil, confirm: ((UIAlertAction) -> Void)?) {
        var cacheviewController = viewController
        if cacheviewController == nil {
            cacheviewController = UIApplication.k_keyWindow?.rootViewController
        }
        if let vc = cacheviewController {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: sureMessage, style: .default, handler: confirm))
            alert.addAction(UIAlertAction(title: cancleMessage, style: .cancel, handler: nil))
            vc.present(alert, animated: true)
        }
    }
    /// Description 弹出一个单输入框
    ///
    /// - Parameters:
    ///   - message: 输入框的title
    ///   - placeholder: 单输入框的提示文字
    ///   - confirm: 确定后的回调
    ///   - isNumber: 键盘的样式
    public static func showSingleTextFiled(message: String,isSecureTextEntry:Bool = false,isNumber:Bool = false,placeholder:String, confirm: ((String) -> Void)?) {
        if let vc = UIApplication.k_keyWindow?.rootViewController {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.placeholder = placeholder
                textField.isSecureTextEntry = isSecureTextEntry
                if isNumber {
                    textField.keyboardType = .asciiCapableNumberPad
                }
            }
            alert.addAction(UIAlertAction(title: "提交", style: .default, handler: { (_) in
                if let textFile = alert.textFields?.first?.text,let confirm = confirm {
                    confirm(textFile)
                }
            }))
            alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
            vc.present(alert, animated: true)
        }
    }

}
