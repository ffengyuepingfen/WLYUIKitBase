//
//  WLYNotificationManager.swift
//  DynamicBusClient
//
//  Created by zhonghangxun on 2019/6/21.
//  Copyright © 2019 WLY. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications
/**
 # IMPORTANT: iOS通送:
 iOS通送分为本地和远程.
 1. 在用户日常生活中会有很多种情形需要通知，比如：新闻提醒、定时吃药、定期体检、到达某个地方提醒用户等等，这些功能在 UserNotifications 中都提供了相应的接口。
 1. Write anything important you want to emphasize
 1. End with  at a new line.
 ---
 [More info - 我的通知博客](<#https://boxueio.com#>)
 [More info - 参考地址](https://www.cnblogs.com/oc-bowen/p/6061280.html)
 */

public class WLYNotificationManager: NSObject {
    
    static public var shared: WLYNotificationManager {
        struct Static {
            static let instance: WLYNotificationManager = WLYNotificationManager()
        }
        return Static.instance
    }
    private override init() {}
    
    public func replyPushNotificationAuthorization(application: UIApplication)  {
        
        /// 目前只考虑iOS10
        let center = UNUserNotificationCenter.current()
        //必须写代理，不然无法监听通知的接收与点击事件
        center.delegate = self;
        center.requestAuthorization(options: [.badge ,.alert ,.sound]) { (granted, error) in
            if granted , error == nil {
                GConfig.log("通知注册成功")
            }else{
                GConfig.log("通知注册失败")
            }
            
            // 可以通过 getNotificationSettingsWithCompletionHandler 获取权限设置
            //之前注册推送服务，用户点击了同意还是不同意，以及用户之后又做了怎样的更改我们都无从得知，现在 apple 开放了这个 API，我们可以直接获取到用户的设定信息了。注意UNNotificationSettings是只读对象哦，不能直接修改！
            center.getNotificationSettings(completionHandler: { settings in
                GConfig.log(settings)
            })
        }
        application.registerForRemoteNotifications()
    }
}
// 发送通知
extension WLYNotificationManager {
    /// 本地通知
    public static func triggerLocalNotification(infoData:(title: String,subtitle: String,body: String, badge:Int , userInfo:[String:String], requestIdentifier:String)) {
        // 1. 创建一个触发器（trigger）
        // 1、新功能trigger可以在特定条件触发，有三类:UNTimeIntervalNotificationTrigger、UNCalendarNotificationTrigger、UNLocationNotificationTrigger
        //timeInterval：单位为秒（s）  repeats：是否循环提醒
        //50s后提醒
        let trigger1 = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        // //在每周一的14点3分提醒
        var components = DateComponents()
        components.weekday = 2
        components.hour = 16
        components.minute = 3
        _ = UNCalendarNotificationTrigger(dateMatching: components , repeats: true)
        // 进行注册，地区信息使用CLRegion的子类CLCircularRegion，可以配置region属性 notifyOnEntry和notifyOnExit，是在进入地区、从地区出来或者两者都要的时候进行通知，
        // 这个测试过程专门从公司跑到家时刻关注手机有推送嘛，果然是有的（定点推送）
        
        //首先得导入#import <CoreLocation/CoreLocation.h>，不然会regin创建有问题。
        // 创建位置信息
        let center1 = CLLocationCoordinate2DMake(39.788857, 116.5559392)
        let region = CLCircularRegion(center: center1, radius: 500, identifier: "hahhaha")
        
        region.notifyOnEntry = true
        region.notifyOnExit = true
        // region 位置信息 repeats 是否重复 （CLRegion 可以是地理位置信息）
        _ = UNLocationNotificationTrigger(region: region, repeats: true)
        // 2. 创建推送的内容（UNMutableNotificationContent）
        // UNNotificationContent：属性readOnly
        // UNMutableNotificationContent：属性有title、subtitle、body、badge、sound、lauchImageName、userInfo、attachments、categoryIdentifier、threadIdentifier
        /*
         本地消息内容    内容限制大小     展示
         title         NSString       限制在一行，多出部分省略号
         subtitle       NSString        限制在一行，多出部分省略号
         body            NSString     通知栏出现时，限制在两行，多出部分省略号；预览时，全部展示
         */
        
        // 注意点: body中printf风格的转义字符，比如说要包含%，需要写成%% 才会显示，\同样
        
        // 创建通知内容 UNMutableNotificationContent, 注意不是 UNNotificationContent ,此对象为不可变对象。
        let content = UNMutableNotificationContent()
        content.title = infoData.title
        content.subtitle = infoData.subtitle
//        let badgeInt = UIApplication.shared.applicationIconBadgeNumber
        content.body = infoData.body
        content.badge = 0
//        NSNumber(integerLiteral: infoData.badge + badgeInt)
        content.sound = UNNotificationSound.default
        content.userInfo = infoData.userInfo
        // // 创建通知标示
        let requestIdentifier = infoData.requestIdentifier
        // 3. 创建推送请求（UNNotificationRequest）
        // 创建通知请求 UNNotificationRequest 将触发条件和通知内容添加到请求中
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger1)
        
        // 4. 推送请求添加到推送管理中心（UNUserNotificationCenter）中
        let center = UNUserNotificationCenter.current()
        // 将通知请求 add 到 UNUserNotificationCenter
        center.add(request) { (error) in
            if error == nil {
//                UIAlertController.showConfirm(message: "成功添加推送", confirm: { (alert) in
//
//                })
            }
        }
    }
    /// 远程
    func triggerRemoteNotification() {
        
    }
    
}

extension WLYNotificationManager: UNUserNotificationCenterDelegate {
    //App处于前台接收通知时
    // 下面这个代理方法，只会是app处于前台状态 前台状态 and 前台状态下才会走，后台模式下是不会走这里的
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //收到推送的请求
        let request = notification.request
        //收到推送的内容
        let content = request.content
        //收到用户的基本信息
        let userInfo = content.userInfo
        //收到推送消息的角标
        let badge:Int = (content.badge?.intValue) ?? 0
        //收到推送消息body
        let body = content.body
        //推送消息的声音
        let sound = content.sound
        // 推送消息的副标题
        let subtitle = content.subtitle
        // 推送消息的标题
        let title = content.title
        
//        let badgeInt = UIApplication.shared.applicationIconBadgeNumber
//        UIApplication.shared.applicationIconBadgeNumber = badgeInt - badge
        
        if let trigger = notification.request.trigger, trigger.isKind(of: UNPushNotificationTrigger.self) {
            GConfig.log("iOS10 收到远程通知")
        }else{
            /// 本地通知
            //此处省略一万行需求代码。。。。。。
            GConfig.log("iOS10 收到本地通知:{\\\\nbody:\(body)，\\\\ntitle:\(title),\\\\nsubtitle:\(subtitle),\\\\nbadge:\(String(describing: badge))，\\\\nsound:\(String(describing: sound))，\\\\nuserInfo:\(userInfo)\\\\n}")
        }
        // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
        completionHandler([.badge, .sound, .alert])
    }
    //App通知的点击事件
    // 下面这个代理方法，只会是用户点击消息才会触发，如果使用户长按（3DTouch）、弹出Action页面等并不会触发。点击Action的时候会触发！
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //收到推送的请求
        let request = response.notification.request
        //收到推送的内容
        let content = request.content
        //收到用户的基本信息
        let userInfo = content.userInfo
        //收到推送消息的角标
        let badge:Int = (content.badge?.intValue) ?? 0
        //收到推送消息body
        let body = content.body
        //推送消息的声音
        let sound = content.sound
        // 推送消息的副标题
        let subtitle = content.subtitle
        // 推送消息的标题
        let title = content.title
        
//        let badgeInt = UIApplication.shared.applicationIconBadgeNumber
//        UIApplication.shared.applicationIconBadgeNumber = badgeInt - badge
        
        
        if let trigger = response.notification.request.trigger, trigger.isKind(of: UNPushNotificationTrigger.self) {
            print("ios10 收到的远程通知 \(userInfo)")
        }else{
            // 判断为本地通知
            //此处省略一万行需求代码。。。。。。
            GConfig.log("iOS10 收到本地通知:{\\\\nbody:\(body)，\\\\ntitle:\(title),\\\\nsubtitle:\(subtitle),\\\\nbadge:\(String(describing: badge))，\\\\nsound:\(String(describing: sound))，\\\\nuserInfo:\(userInfo)\\\\n}")
        }
        
        completionHandler() // 系统要求执行这个方法
        
    }
}
