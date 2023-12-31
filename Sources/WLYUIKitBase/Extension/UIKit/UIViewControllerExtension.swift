//
//  File.swift
//  
//
//  Created by Laowang on 2023/5/16.
//

import UIKit

// MARK: - 一、基本的扩展
public extension UIViewController {
    
    // MARK: 1.1、pop回上一个界面
    /// pop回上一个界面
    func popToPreviousVC() {
        guard let nav = self.navigationController else { return }
        if let index = nav.viewControllers.firstIndex(of: self), index > 0 {
            let vc = nav.viewControllers[index - 1]
            nav.popToViewController(vc, animated: true)
        }
    }
    
    // MARK: 1.2、获取push进来的 VC
    /// 获取push进来的 VC
    /// - Returns: push进来的 VC
    func getPreviousNavVC() -> UIViewController? {
        guard let nav = self.navigationController else { return nil }
        if nav.viewControllers.count <= 1 {
            return nil
        }
        if let index = nav.viewControllers.firstIndex(of: self), index > 0 {
            let vc = nav.viewControllers[index - 1]
            return vc
        }
        return nil
    }
    
    // MARK: 1.3、获取顶部控制器(类方法)
    /// 获取顶部控制器
    /// - Returns: VC
    static func topViewController() -> UIViewController? {
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first, let rootVC = window.rootViewController  else {
            return nil
        }
        return top(rootVC: rootVC)
    }
    
    // MARK: 1.4、获取顶部控制器(实例方法)
    /// 获取顶部控制器
    /// - Returns: VC
    func topViewController() -> UIViewController? {
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first, let rootVC = window.rootViewController  else {
            return nil
        }
        return Self.top(rootVC: rootVC)
    }
    
    private static func top(rootVC: UIViewController?) -> UIViewController? {
        if let presentedVC = rootVC?.presentedViewController {
            return top(rootVC: presentedVC)
        }
        if let nav = rootVC as? UINavigationController,
            let lastVC = nav.viewControllers.last {
            return top(rootVC: lastVC)
        }
        if let tab = rootVC as? UITabBarController,
            let selectedVC = tab.selectedViewController {
            return top(rootVC: selectedVC)
        }
        return rootVC
    }
    
    // MARK: 1.5、是否正在展示
    /// 是否正在展示
    var isCurrentVC: Bool {
        return self.isViewLoaded == true && (self.view!.window != nil)
    }
    
    // MARK: 1.6、关闭当前的控制器
    /// 关闭当前的控制器
    func closeCurrentVC() {
        guard let nav = self.navigationController else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        if nav.viewControllers.count > 1 {
            nav.popViewController(animated: true)
        } else if let _ = nav.presentingViewController {
            nav.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - 二、Storyboard 的 VC 交互
/**
 提示：
 1、Storyboard 一定要设置一个初始化的控制器，勾选：Is Initial View Controller
 2、VC 之间的连线，比如 button，按住 ctrl 拖到其他的VC后，松开后在弹出界面选择跳转的方式
 3、在进行 Storyboard 里面指定 VC 跳转的时候记得设置 identifier，不然找不到对应的VC
 */
public extension UIViewController {
    
    // MARK: 2.1、push跳转Storyboard(首个初始化的控制器)，一定要设置一个初始化的控制器，勾选：Is Initial View Controller
    /// push跳转Storyboard(首个初始化的控制器)
    /// - Parameters:
    ///   - storyboardName: storyboardName 的名字
    ///   - sender: 处理携带参数
    func pushStoryboard(_ storyboardName: String, sender: ((UIViewController) -> Void)?) {
        // 1、获取 UIStoryboard
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        // 2.1、入口为UIViewController
        guard var vc = storyboard.instantiateInitialViewController() else {
            GConfig.log("一定要设置一个初始化的控制器，勾选：Is Initial View Controller")
            return
        }
        if let nc = vc as? UINavigationController, let topVc = nc.topViewController {
            // 2.2、入口为 UINavigationController
            vc = topVc
        }
        // 3、数据处理
        sender?(vc)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: 2.2、push跳转到Storyboard中指定UIViewController
    /// push跳转到Storyboard中指定UIViewController
    /// - Parameters:
    ///   - storyboardName: storyboardName的名字
    ///   - identifier: 定位UIViewController的标示符
    ///   - sender: 处理携带参数
    func pushStoryboard(_ storyboardName: String, identifier: String, sender: ((UIViewController) -> Void)?) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        sender?(vc)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

@objc extension UIViewController {
    
    override public class func initializeMethod() {
        super.initializeMethod()
        
        if self == UIViewController.self {
            let onceToken = "Hook_\(NSStringFromClass(classForCoder()))"
            DispatchQueue.once(token: onceToken) {
                let oriSel = #selector(viewDidLoad)
                let repSel = #selector(hook_viewDidLoad)
                _ = hookInstanceMethod(of: oriSel, with: repSel)
                                
                let oriSel1 = #selector(viewWillAppear(_:))
                let repSel1 = #selector(hook_viewWillAppear(animated:))
                _ = hookInstanceMethod(of: oriSel1, with: repSel1)
                
                let oriSel2 = #selector(viewWillDisappear(_:))
                let repSel2 = #selector(hook_viewWillDisappear(animated:))
                _ = hookInstanceMethod(of: oriSel2, with: repSel2)
                
                let oriSelPresent = #selector(present(_:animated:completion:))
                let repSelPresent = #selector(hook_present(_:animated:completion:))
                _ = hookInstanceMethod(of: oriSelPresent, with: repSelPresent)
            }
        } else if self == UINavigationController.self {
            let onceToken = "Hook_\(NSStringFromClass(classForCoder()))"
            DispatchQueue.once(token: onceToken) {
                let oriSel = #selector(UINavigationController.pushViewController(_:animated:))
                let repSel = #selector(UINavigationController.hook_pushViewController(_:animated:))
                _ = hookInstanceMethod(of:oriSel , with: repSel)
            }
        }
    }
    
    private func hook_viewDidLoad(animated: Bool) {
        hook_viewDidLoad(animated: animated)
    }
    
    private func hook_viewWillAppear(animated: Bool) {
        // 需要注入的代码写在此处
        hook_viewWillAppear(animated: animated)
    }
    
    private func hook_viewWillDisappear(animated: Bool) {
        // 需要注入的代码写在此处
        hook_viewWillDisappear(animated: animated)
    }
    
    private func hook_present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        if viewControllerToPresent.presentationController == nil {
            viewControllerToPresent.presentationController?.presentedViewController.dismiss(animated: false, completion: nil)
            GConfig.log("viewControllerToPresent.presentationController 不能为 nil")
            return
        }
        hook_present(viewControllerToPresent, animated: flag, completion: completion)
    }
}

@objc extension UINavigationController{
    
    public func hook_pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 判断是否是根控制器
        if viewControllers.count > 0 {
           
        }
        // push进入下一个控制器
        hook_pushViewController(viewController, animated: animated)
    }

}

import UIKit
import AudioToolbox
import AVFoundation

extension UIViewController {
    /// Long vibration 长震动
    public func longVibration() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    /// Long vibration 长震动
    public func longVibration(completion:(()->Void)?) {
        AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate, completion)
    }
    
    /// Short vibration
    public func shortVibrationPeek() {
        AudioServicesPlaySystemSound(1519)
    }
    public func shortVibrationPop() {
        AudioServicesPlaySystemSound(1520)
    }
    /// 震动三次
    public func shortVibrationThree() {
        AudioServicesPlaySystemSound(1521)
    }
    /// 点击反馈
    public func feedbackGenerator() {
        let feedBackGenertor = UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle.heavy)
        feedBackGenertor.impactOccurred()
    }
    
    public func playSystemSound(resourceName:String? = nil,type:String? = nil) {
        var path = "/System/Library/Audio/UISounds/sms-received2.caf"
        if let resourceName = resourceName, let type = type {
            path = "/System/Library/Audio/UISounds/\(resourceName).\(type)"
        }
        
        guard let urlCF = URL(string: path) as CFURL? else {
            return
        }
        var systemSoundID: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(urlCF, &systemSoundID)
        AudioServicesPlayAlertSoundWithCompletion(systemSoundID)
        {
            print("播放完成")
            // 三. 释放资源
            AudioServicesDisposeSystemSoundID(systemSoundID)

        }
    }
    /// 播放本地声音
    public func playLocalSound(resourceName:String) {
        guard let urlCF = URL(string: resourceName) as CFURL? else {
            GConfig.log("找不到播放文件")
            return
        }
        var systemSoundID: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(urlCF, &systemSoundID)
        AudioServicesPlayAlertSoundWithCompletion(systemSoundID)
        {
            GConfig.log("播放完成")
            // 三. 释放资源
            AudioServicesDisposeSystemSoundID(systemSoundID)

        }
    }
    
}

extension UIView {
    /// Long vibration 长震动
    public func longVibration() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    /// Long vibration 长震动
    public func longVibration(completion:(()->Void)?) {
        AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate, completion)
    }
    
    /// Short vibration
    public func shortVibrationPeek() {
        AudioServicesPlaySystemSound(1519)
    }
    public func shortVibrationPop() {
        AudioServicesPlaySystemSound(1520)
    }
    /// 震动三次
    public func shortVibrationThree() {
        AudioServicesPlaySystemSound(1521)
    }
    /// 点击反馈
    public func feedbackGenerator() {
        let feedBackGenertor = UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle.heavy)
        feedBackGenertor.impactOccurred()
    }
    
    public func playSystemSound(resourceName:String? = nil,type:String? = nil) {
        var path = "/System/Library/Audio/UISounds/sms-received2.caf"
        if let resourceName = resourceName, let type = type {
            path = "/System/Library/Audio/UISounds/\(resourceName).\(type)"
        }
        
        guard let urlCF = URL(string: path) as CFURL? else {
            return
        }
        var systemSoundID: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(urlCF, &systemSoundID)
        AudioServicesPlayAlertSoundWithCompletion(systemSoundID)
        {
            print("播放完成")
            // 三. 释放资源
            AudioServicesDisposeSystemSoundID(systemSoundID)

        }
    }
}


// 屏幕方向
extension UIViewController {
    var isLandscape: Bool {
        if #available(iOS 13.0, *) {
            return view.window?.windowScene?.interfaceOrientation.isLandscape ?? false
        } else {
            return UIApplication.shared.statusBarOrientation.isLandscape
        }
    }
}
