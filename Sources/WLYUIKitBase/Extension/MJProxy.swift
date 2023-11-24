//
//  MJProxy.swift
//  ElectronicBusCard
//
//  Created by Laowang on 2022/12/5.
//

import UIKit

/// 第二种定时器添加
extension CADisplayLink {
    
    // RunTime绑定的键值
    struct UnSafePointString {
        static let key = UnsafeRawPointer(bitPattern: "closures".hashValue)
        
    }
    
    // RUntime进行属性绑定
    static var closures : ((CADisplayLink) -> Void)? {
        get {
            return objc_getAssociatedObject(self, UnSafePointString.key!) as? (CADisplayLink) -> Void
        }
        set(newValue) {
            objc_setAssociatedObject(self, UnSafePointString.key!, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    //定时器的创建
    static public func creatDisplayLink(action:((CADisplayLink) -> Void)?) -> CADisplayLink{
        
        self.closures = action

        let displayLinks = CADisplayLink(target: self, selector: #selector(startTime(_:)))
        displayLinks.add(to: RunLoop.main, forMode: RunLoop.Mode.common)
        displayLinks.preferredFramesPerSecond = 1
        return displayLinks
    }
    
    
    // 闭包回调 实现计时
    @objc static func startTime(_ displayLink:CADisplayLink){

        if  let clo = closures {
            clo(displayLink)
        }
      
    }
    
    // 定时器的销毁
    public func removeFromRunLoop()  {
        self.invalidate()
        
    }
    
}
