//
//  UINavigationControllerEx.swift
//  WLYUIKitBase
//
//  Created by Laowang on 2023/8/24.
//

import UIKit

// MARK: - 一、基本的扩展
public extension UINavigationController {
    
    // MARK: 1.1、pop返回后再push进某个控制器
    /// pop返回后再push进某个控制器
    /// - Parameters:
    ///   - vc: 某个控制器
    ///   - animated: 是否要动画
    func popCurrentAndPush(vc: UIViewController, animated: Bool) {
        var vcs = self.viewControllers
        guard vcs.count >= 1  else {
            return
        }
        vcs.removeLast()
        vcs.append(vc)
        self.setViewControllers(vcs, animated: animated)
    }
    
    // MARK: 1.2、往前返回(Pop)几个控制器
    /// 往前返回(Pop)几个控制器
    /// - Parameters:
    ///   - count: 返回(Pop)几个控制器
    ///   - animated: 是否有动画
    func pop(count: Int, animated: Bool) {
        guard count >= 1 else {
            GConfig.log("can't pop count less 1")
            return
        }
        let vcsCount = self.viewControllers.count
        if count >= vcsCount {
            GConfig.log("count: \(count), must less than viewControllers count: \(vcsCount); will pop to root now!")
            self.popToRootViewController(animated: animated)
            return
        }
        
        let vc = self.viewControllers[vcsCount - count - 1]
        self.popToViewController(vc, animated: animated)
    }
    
    // MARK: 1.3、往前返回(Pop)几个控制器 后 push进某个控制器
    /// 往前返回(Pop)几个控制器 后 push进某个控制器
    /// - Parameters:
    ///   - count: 返回(Pop)几个控制器
    ///   - vc: 被push的控制器
    ///   - animated: 是否要动画
    func pop(count: Int, andPush vc: UIViewController, animated: Bool = true) {
        if count < 1 {
            GConfig.log("can't pop count less 1")
            return
        }
        
        let vcsCount = self.viewControllers.count
        if count >= vcsCount {
            GConfig.log("count: \(count), must less than viewControllers count: \(vcsCount); will pop to root now!")
            if let first = self.viewControllers.first {
                self.setViewControllers([first, vc], animated: animated)
            }
            return
        }
        
        var vcs = Array(self.viewControllers[0...(vcsCount - count - 1)])
        vcs.append(vc)
        self.setViewControllers(vcs, animated: animated)
    }
    
    // MARK: 1.4、pop 到某个vc，以传入的vc类型为准，从栈顶逐个便利，直到找到这个vc，如果遍历完成后没找到，则返回false
    /// pop 到某个vc，以传入的vc类型为准，从栈顶逐个便利，直到找到这个vc，如果遍历完成后没找到，则返回false
    /// - Parameters:
    ///   - aClass: 要pop到的vc的类型
    ///   - animated: 是否有动画
    /// - Returns: 成功找到vc并pop 返回true  否则 false
    @discardableResult
    func popToViewController(as aClass: AnyClass, animated: Bool) -> Bool {
        for vc in self.viewControllers.reversed() {
            if vc.isMember(of: aClass) {
                self.popToViewController(vc, animated: animated)
                return true
            }
        }
        self.popToRootViewController(animated: true)
        return false
    }
}
