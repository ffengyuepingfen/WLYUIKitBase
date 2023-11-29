//
//  GlobalConfig.swift
//  WLYUIKit
//
//  Created by ZHXMAC on 2019/9/5.
//  Copyright © 2019 ZHXMAC. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

extension UIApplication {
    
    public static var k_keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }.first?.windows.first
    }
}

public struct GConfig {
    
    public static let ScreenW = UIScreen.main.bounds.width
    public static let ScreenH = UIScreen.main.bounds.height
    
    public static let NavigationBarH: CGFloat = isFullScreen() ? 88 : 64
    public static let BottomSafeH: CGFloat = isFullScreen() ? 34 : 0
    public static let TopSafeH: CGFloat = isFullScreen() ? 44 : 20
    
    public static let NavAndBottomBarH = NavigationBarH + BottomSafeH
    
    // MARK: - 自定义打印
    /// 自定义打印
    /// - Parameter msg: 打印的内容
    public static func log(_ msg: Any...) {
        GCLog.info(msg)
    }

    static func isFullScreen() -> Bool {
        if #available(iOS 11, *) {
            guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
                return false
            }
            if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
                print(unwrapedWindow.safeAreaInsets)
                return true
            }
        }
        return false
    }
    public static let userDefault = UserDefaults.standard
    /// 打开应用内部浏览器
    public static func openWebPage(url: URL) {
        CicSFSafariManager.openPage(url: url)
    }
}

class CicSFSafariManager: NSObject {

    static func openPage(url: URL) {
        
        let config = SFSafariViewController.Configuration()
        // 默认情况下，当页面往上滚动，顶部和底部的菜单栏会隐藏，如果不想隐藏可以设置
        config.barCollapsingEnabled = false
        // 默认情况下，Safari 的阅读模式是禁用的，如果想打开，只需要设置
        config.entersReaderIfAvailable = true
        let vc = SFSafariViewController(url: url, configuration: config)
        /*
         在 iOS 15 中，SFSafariViewController 提供了一个类方法 prewarmConnections，参数是一个 URL 数组，支持预加载一批网页。按照苹果的文档，返回的 token 对象必须强引用才行。
         let urls = [URL(string: "https://apple.com")!]
         let token = SFSafariViewController.prewarmConnections(to: urls)
         */
        // 设置顶部和底部 bar 的颜色为红色
        vc.preferredBarTintColor = .systemBlue
        // 设置按钮和和文本的渲染颜色为蓝色
        vc.preferredControlTintColor = .white
        // 设置左上角 dismiss 按钮的文案为 cancel
        vc.dismissButtonStyle = .close
        k_keyWindow?.rootViewController?.present(vc, animated: true)
    }
}
