//
//  GlobalFun.swift
//  Alamofire
//
//  Created by wangxiangbo on 2020/4/17.
//

import Foundation
import StoreKit

/// 代码延迟运行
///
/// - Parameters:
///   - delayTime: 延时时间。比如：.seconds(5)、.milliseconds(500)
///   - qosClass: 要使用的全局QOS类（默认为 nil，表示主线程）
///   - closure: 延迟运行的代码
public func delay(by delayTime: TimeInterval, qosClass: DispatchQoS.QoSClass? = nil,
                  _ closure: @escaping () -> Void) {
    let dispatchQueue = qosClass != nil ? DispatchQueue.global(qos: qosClass!) : .main
    dispatchQueue.asyncAfter(deadline: DispatchTime.now() + delayTime, execute: closure)
}

////延迟5秒执行（在主线程上）
//delay(by: 5) {
//    print("时间1：", Date())
//}
//
////延迟5秒执行（在全局队列上，且优先级高）
//delay(by: 5, qosClass: .userInitiated) {
//    print("时间2：", Date())
//}

/// Description 倒计时
///
/// - Parameter sender: sender description
public func timeChange(sender: UIButton, maxCount: NSInteger) {
    var time = maxCount
    let codeTimer = DispatchSource.makeTimerSource(flags: .init(rawValue: 0), queue: DispatchQueue.global())
    codeTimer.schedule(deadline: .now(), repeating: .milliseconds(1000))  //此处方法与Swift 3.0 不同
    codeTimer.setEventHandler {
        time -= 1
        DispatchQueue.main.async {
            sender.isEnabled = false
        }
        if time < 0 {
            codeTimer.cancel()
            DispatchQueue.main.async {
                sender.isEnabled = true
                sender.setTitle("重新发送", for: .normal)
            }
            return
        }
        DispatchQueue.main.async {
            sender.setTitle("\(time)s后重新发送", for: .normal)
        }
    }
    if #available(iOS 10.0, *) {
        codeTimer.activate()
    } else {
        // Fallback on earlier versions
        codeTimer.resume()
    }
}

// 判断输入的字符串是否为数字，不含其它字符
public func isPurnFloat(string: String) -> Bool {
    
    let scan: Scanner = Scanner(string: string)
    
    var val:Float = 0
    
    return scan.scanFloat(&val) && scan.isAtEnd
    
}

/// 防止截图的父层view； 凡是放在这个视图上的子视图都能防止截图
/// - Returns:
public func makeSecView() -> UIView {
    let field = UITextField()
    field.isSecureTextEntry = true
    guard let view = field.subviews.first else {
        return UIView()
    }
    view.subviews.forEach { $0.removeFromSuperview() }
    view.isUserInteractionEnabled = true
    return view
}

/// Description: 系统功能评价
///  0:  系统内部弹框  一年三次
///   1： 跳转到appstore
///    2：app 内部加载appstore 页面
public func systemVersionEvaluation(type: String) {
//    只能评分，不能编写评论
//    有次数限制，一年只能使用三次
//    使用次数超限后，需要跳转appstore
    if SKStoreReviewController.responds(to: Selector("requestReview")) {
        //防止键盘遮挡
        UIApplication.shared.windows.first?.endEditing(true)
        SKStoreReviewController.requestReview()
    }
    
//    跳转到AppStore对应应用评论页面
//    可评分评论，无次数限制
    let nsStringToOpen = "itms-apps://itunes.apple.com/app/id\("AppID")?action=write-review"
    UIApplication.shared.open(URL(string: nsStringToOpen)!)
    
//    内部加载AppStore
//    在APP内部加载App Store 展示APP信息，但不能直接跳转到评论编辑页面。
//    再加载处App Store展示页面后，需要手动点击 评论→ 撰写评论
    
    let storeProductViewContorller = SKStoreProductViewController()
    storeProductViewContorller.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier: "APPID"]) { result, error in
        if error != nil {
            
        }else{
//            [self presentViewController:storeProductViewContorller animated:YES
        }
    }
}
