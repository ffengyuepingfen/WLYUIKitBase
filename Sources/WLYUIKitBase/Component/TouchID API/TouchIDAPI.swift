//
//  TouchIDAPI.swift
//  SwiftDemo
//
//  Created by 中行讯 on 2018/7/24.
//  Copyright © 2018年 Beijing CIC Technology Co., Ltd. All rights reserved.
//

import UIKit
import LocalAuthentication

/// Description:发起指纹
func touchID(finished: @escaping ([String:String])->(),faile:@escaping (String)->()) {
    
    let authenticationContext = LAContext()
    // 这个属性是设置指纹输入失败之后的弹出框的选项
    authenticationContext.localizedFallbackTitle = "忘记密码"
    var error: NSError?
    //1:检查Touch ID 是否可用
    if authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
        //2:执行认证策略
        authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "请安住Home键完成验证") { (success, error) in
            if success {
                let dic:[String:String] = GConfig.userDefault.object(forKey: "touchIDLogin") as! [String : String]
                finished(dic)
            }else{
                print("失败")
                if let error = error as NSError? {
                    // 获取错误信息
                    let message = errorMessageForLAErrorCode(errorCode: error.code)
                    print(message)
                    faile(message)
                }

            }
        }
    }else{
        // 获取错误信息
        if let error = error as NSError? {
            // 获取错误信息
            let message = errorMessageForLAErrorCode(errorCode: error.code)
            print(message)
            faile(message)
        }
        //todo goto 输入密码页面
        print("error ====\(error ?? NSError())")
        print("抱歉，touchId 不可用");
    }
}

func errorMessageForLAErrorCode(errorCode: Int) -> String {
    var message = ""
    
    switch errorCode {
    case LAError.appCancel.rawValue:
        message = "Authentication was cancelled by application"
        
    case LAError.authenticationFailed.rawValue:
        message = "The user failed to provide valid credentials"
        
    case LAError.invalidContext.rawValue:
        message = "The context is invalid"
        
    case LAError.passcodeNotSet.rawValue:
        message = "Passcode is not set on the device"
        
    case LAError.systemCancel.rawValue:
        message = "Authentication was cancelled by the system"

    case LAError.userCancel.rawValue:
        message = "The user did cancel"
        
    case LAError.userFallback.rawValue:
        message = "The user chose to use the fallback"
        
    default:
        message = "Did not find error code on LAError object"
    }
    return message
}

