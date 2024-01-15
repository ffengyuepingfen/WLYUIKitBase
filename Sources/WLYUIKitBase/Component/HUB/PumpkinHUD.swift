//
//  MBProgressHUD.swift
//  iOSExcel
//
//  Created by WXBPre on 2018/10/22.
//  Copyright © 2018 WXBPre. All rights reserved.
//

import Foundation
import MBProgressHUD
#if canImport(OC)
import OC
#endif

/// 测试
/**
 hud的样式

 - gray_background_style: 灰色背景
 - dim_background_style: 黑色背景
 */
public enum CustomHudStyle {
    case gray_background_style,dim_background_style
}

public class PumpkinHUDManager {
    static public let shard = PumpkinHUDManager()
    public var hudStyle:CustomHudStyle = .dim_background_style
    public var hudShowTime:TimeInterval = 2.0
    private init() {}
}

public class PumpkinHUD {
    
    /// 隐藏View
    /// - Parameter toView: toView description
    public class func hide(toView:UIView? = UIApplication.k_keyWindow?.rootViewController?.view, animated:Bool = true) {
        if let toview = toView {
            MBProgressHUD.hide(for: toview, animated: animated)
        }
    }

    /// Description 展示一个 toast
    ///
    /// - Parameters:
    ///   - message: message description
    ///   - view: view description
    public class func showMessage(_ message: String, toView:UIView? = UIApplication.k_keyWindow, delay:TimeInterval = 2.0) {
        if message.count == 0 { return }
        if let toView = toView {
            let hud = MBProgressHUD.showAdded(to: toView, animated: true)
            hud.bezelView.layer.cornerRadius = 5.0
            hud.detailsLabel.text = message
            hud.mode = .text
            
            if .gray_background_style == PumpkinHUDManager.shard.hudStyle {
                hud.bezelView.style = .solidColor
                hud.contentColor = UIColor.white
                hud.bezelView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
            }
            if .dim_background_style == PumpkinHUDManager.shard.hudStyle {
                //黑色背景
                hud.bezelView.style = .solidColor
                hud.bezelView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
                hud.contentColor = UIColor.white
            }
            hud.offset.y = CGFloat(Float((GConfig.ScreenH - GConfig.NavigationBarH - GConfig.BottomSafeH))/2 - 88)
            hud.detailsLabel.numberOfLines = 0
            hud.detailsLabel.font = UIFont.systemFont(ofSize: 16.0)
            hud.removeFromSuperViewOnHide = true
            DispatchQueue.main.async {
                hud.hide(animated: true, afterDelay: delay)
            }
        }
    }

    /// 展示一个带图片的toast
    /// - Parameters:
    ///   - message: message description
    ///   - icon: icon description
    ///   - toView: toView description
    ///   - delay: delay description
    public class func show(message:String, icon:Data, toView:UIView? = UIApplication.k_keyWindow?.rootViewController?.view, delay:TimeInterval = 2.0) {
        if let toView = toView, message.count != 0 {
            let hud = MBProgressHUD.showAdded(to: toView, animated: true)
            hud.bezelView.layer.cornerRadius = 5.0
            hud.label.text = message
            hud.mode = .customView
            var rederModel:UIImage.RenderingMode = .alwaysTemplate

            if .gray_background_style == PumpkinHUDManager.shard.hudStyle {
                hud.bezelView.style = .solidColor
                hud.contentColor = UIColor.white
                hud.bezelView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
                rederModel = .alwaysTemplate
            }
            if .dim_background_style == PumpkinHUDManager.shard.hudStyle {
                //黑色背景
                hud.bezelView.style = .solidColor
                hud.bezelView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
                hud.contentColor = UIColor.white
                rederModel = UIImage.RenderingMode.alwaysOriginal
            }

            let image = UIImage(data: icon)?.withRenderingMode(rederModel)
            hud.customView = UIImageView(image: image)
            hud.removeFromSuperViewOnHide = true
            DispatchQueue.main.async {
                hud.hide(animated: true, afterDelay: delay)
            }
        }
    }

    // MARK:- 显示loading状态
    public class func showLoading(message:String, toView:UIView? = UIApplication.k_keyWindow?.rootViewController?.view) {

        if let toView = toView {
            //在显示新的之前需要隐藏掉旧的，否则会导致多个loading页面重叠
            MBProgressHUD.hide(for: toView, animated: true)

            let hud = MBProgressHUD.showAdded(to: toView, animated: true)
            hud.bezelView.layer.cornerRadius = 5.0
            hud.label.text = message
            hud.removeFromSuperViewOnHide = true
            hud.mode = .indeterminate
            if .gray_background_style == PumpkinHUDManager.shard.hudStyle {
                hud.bezelView.style = .solidColor
                hud.contentColor = UIColor.white
                hud.bezelView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
            }
            if .dim_background_style == PumpkinHUDManager.shard.hudStyle {
                //黑色背景
                hud.bezelView.style = .solidColor
                hud.bezelView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
                hud.contentColor = UIColor.white
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                MBProgressHUD.hide(for: toView, animated: true)
            }
        }
    }

    //MARK: - 显示带icon的信息
    /// 展示成功的toast
    public class func showSuccess(message:String, toView:UIView? = UIApplication.k_keyWindow?.rootViewController?.view, delay:TimeInterval = 2.0) {
        if let image = UIImage(named: "success", in: .i18n, compatibleWith: nil),
           let data = image.pngData() {
            self.show(message: message, icon: data, toView: toView, delay: delay)
        }
    }

    /// 展示失败的toast
    public class func showError(message:String, toView:UIView? = UIApplication.k_keyWindow?.rootViewController?.view, delay:TimeInterval = 2.0) {

        if let image = UIImage(named: "error", in: .i18n, compatibleWith: nil),
           let data = image.pngData() {
            self.show(message: message, icon: data, toView: toView, delay: delay)
        }

    }

    /// 展示警告的toast
    public class func showWarning(message:String, toView:UIView? = UIApplication.k_keyWindow?.rootViewController?.view, delay:TimeInterval = 2.0) {

        if let image = UIImage(named: "warning", in: .i18n, compatibleWith: nil),
           let data = image.pngData() {
            self.show(message: message, icon: data, toView: toView, delay: delay)
        }
    }
    
    /// Description : 获取用于显示提示框的View
    ///
    /// - Returns: view
    class func viewToshow() -> UIView {
        var window = UIApplication.k_keyWindow
        if window?.windowLevel != UIWindow.Level.normal {
            let windowArray = UIApplication.shared.windows
            for tempWin in windowArray {
                if tempWin.windowLevel == UIWindow.Level.normal {
                    window = tempWin
                    break
                }
            }
        }
        return window!
    }
    
}

extension UIView {
    /// Description 展示一个 toast
    ///
    /// - Parameters:
    ///   - message: message description
    ///   - view: view description
    public func showMessage(_ message: String, delay:TimeInterval = 2.0) {
        PumpkinHUD.showMessage(message,toView: self,delay: delay)
    }

    /// 展示一个带图片的toast
    /// - Parameters:
    ///   - message: message description
    ///   - icon: icon description
    ///   - toView: toView description
    ///   - delay: delay description
    public func show(message:String, icon:Data, delay:TimeInterval = 2.0) {
        PumpkinHUD.show(message: message, icon: icon, toView: self, delay: delay)
    }

    // MARK:- 显示loading状态
    public func showLoading(message:String) {
        PumpkinHUD.showLoading(message: message,toView: self)
    }

    //MARK: - 显示带icon的信息
    
    /// 展示成功的toast
    /// - Parameters:
    ///   - message: message description
    ///   - toView: toView description
    ///   - delay: delay description
    public func showSuccess(message:String, toView:UIView? = UIApplication.k_keyWindow, delay:TimeInterval = 2.0) {
        PumpkinHUD.showSuccess(message: message,toView: self, delay: delay)
    }

    /// 展示失败的toast
    public func showError(message:String, toView:UIView? = UIApplication.k_keyWindow, delay:TimeInterval = 2.0) {

        PumpkinHUD.showError(message: message, toView: self, delay: delay)

    }

    /// 展示警告的toast
    public func showWarning(message:String, toView:UIView? = UIApplication.k_keyWindow, delay:TimeInterval = 2.0) {

        PumpkinHUD.showWarning(message: message, toView: self, delay:  delay)
    }

}


/*
 MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
 hud.mode = MBProgressHUDModeAnnularDeterminate;
 hud.label.text = @"Loading";
 [self doSomethingInBackgroundWithProgressCallback:^(float progress) {
     hud.progress = progress;
 } completionCallback:^{
     [hud hideAnimated:YES];
 }];
 */
