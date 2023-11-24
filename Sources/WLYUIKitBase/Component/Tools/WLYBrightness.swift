//
//  WLYBrightness.swift
//  brightnessGradientDemo
//
//  Created by wangxiangbo on 2020/1/14.
//  Copyright © 2020 leon. All rights reserved.
//

import UIKit
/// 调整屏幕亮度的类
public class WLYBrightness:NSObject {
    let queue:OperationQueue!
    var value:CGFloat = 0.6
    
    public override init() {
        self.queue = OperationQueue()
        self.queue.maxConcurrentOperationCount = 1
    }
    
    /// 保存当前的亮度
    @objc public func saveDefaultBrightness() {
        value = UIScreen.main.brightness
    }
    
    /// 逐步设置亮度
    /// - Parameter value: 调整到的亮度
    @objc public func graduallySetBrightness(value1:CGFloat) {
        queue.cancelAllOperations()

        let brightness = UIScreen.main.brightness

        let step = 0.005 * ((value1 > brightness) ? 1 : -1)
        let times = Int(abs((value1 - brightness) / 0.005))

        //根据亮度差计算出时间和每个单位时间调节的亮度值
        for index in 0...times {
            queue.addOperation {
                Thread.sleep(forTimeInterval: 1 / 180.0)
                OperationQueue.main.addOperation {
                    UIScreen.main.brightness = brightness + CGFloat(index) * CGFloat(step)
                }
            }
        }
    }
    /// 逐步恢复亮度
    @objc public func graduallyResumeBrightness() {
        graduallySetBrightness(value1: value)
    }
    
    /// 考虑吧这个问题在这个类里面解决
    //    //成为激活状态，调高亮度
    //    -(void)DidBecomeActive{
    //    //    [JCBrightness graduallySetBrightness:0.8];
    //        [_brightness graduallySetBrightnessWithValue1:0.8];
    //    }
    //
    //    //失去激活状态，快速恢复之前的亮度
    //    -(void)willResignActive{
    //    //    [JCBrightness fastResumeBrightness];
    //        [_brightness graduallyResumeBrightness];
    //    }
    //
    //
    //    #pragma mark 移除本地所有通知
    //    -(void)removeNotification{
    //        [[NSNotificationCenter defaultCenter] removeObserver:self];
    //    }
}
