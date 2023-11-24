//
//  InputValidator.swift
//  Alamofire
//
//  Created by wangxiangbo on 2020/7/8.
//

import Foundation

public class InputValidator {
    /// 验证邮箱正确性
    public class func isValidEmail(email: String) -> Bool {
        let re = try? NSRegularExpression(
            pattern: "^\\S+@\\S+\\.\\S+$",
            options: .caseInsensitive)
        
        if let re = re {
            let range = NSMakeRange(0,
                                    email.lengthOfBytes(
                                        using: String.Encoding.utf8))
            
            let result = re.matches(in: email,
                                    options: .reportProgress,
                                    range: range)
            
            return result.count > 0
        }
        
        return false
    }
    
    /// Description 验证 8 位密码
    /// - Parameter password: password description
    /// - Returns: description
    public class func isValidPassword(
        password: String) -> Bool {
        return password.count >= 8
    }
    
    /// Description 验证身份证
    ///
    /// - Parameter IDNumber: IDNumber description
    /// - Returns: return value description
    public static func isValidIDNumber(IDNumber:String) -> Bool {
        if IDNumber == "", IDNumber.count != 15 && IDNumber.count != 18 {
            return false
        }
        return true
    }
}
