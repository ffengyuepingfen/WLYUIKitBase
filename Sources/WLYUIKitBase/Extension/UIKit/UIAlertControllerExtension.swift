//
//  File.swift
//  
//
//  Created by Laowang on 2023/5/16.
//

import UIKit

// MARK: - 一、基本的扩展
public extension UIAlertController {
    
    // MARK: 1.1、初始化创建 UIAlertController
    /// 初始化创建 UIAlertController
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 详细的信息
    @discardableResult
    convenience init(title: String?, message: String?) {
        self.init(title: title, message: message, preferredStyle: .alert)
    }
    
    // MARK: 1.2、添加 UIAlertAction 事件
    /// 添加 UIAlertAction 事件
    /// - Parameters:
    ///   - alertActionTitle: 弹出的标题
    ///   - alertActionStyle: 风格
    ///   - handler: 事件处理block
    /// - Returns: 返回自身
    @discardableResult
    func addAction(_ alertActionTitle: String?, _ alertActionStyle: UIAlertAction.Style = .default, handler: (@escaping () -> Void) = {}) -> Self {
        let action = UIAlertAction(title: alertActionTitle, style: alertActionStyle) { _ in
            handler()
        }
        addAction(action)
        return self
    }
    
    // MARK: 1.3、添加 UIAlertAction 事件
    /// 添加 UIAlertAction 事件
    /// - Parameter action: UIAlertAction 事件
    /// - Returns: 返回自身
    @discardableResult
    func addAction(action: UIAlertAction) -> Self {
        addAction(action)
        return self
    }
    
    // MARK: 1.4、跳转 UIAlertController
    /// UIAlertController
    func show() {
        UIApplication.k_keyWindow?.rootViewController?.present(self, animated: true, completion: nil)
    }

    // MARK: 1.5、跳转 UIAlertController，不做操作自动返回
    /// 跳转 UIAlertController，不做操作自动返回
    /// - Parameters:
    ///   - vc: 控制器
    ///   - deadline: 多长时间自动返回
    func show(_ vc: UIViewController? = UIViewController.topViewController(), dismiss deadline: TimeInterval? = nil) {
        guard let inVC = vc else {
            return
        }
        inVC.present(self, animated: true, completion: nil)
        guard let deadline = deadline else {
            return
        }
        JKAsyncs.asyncDelay(deadline, {}) { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.dismiss(animated: true, completion: nil)
        }
    }
}

