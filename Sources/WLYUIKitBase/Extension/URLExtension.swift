//
//  File.swift
//  
//
//  Created by Laowang on 2023/5/15.
//

import UIKit
// MARK: - 一、基本的扩展
public extension URL {
    
    // MARK: 1.1、提取链接中的参数以字典像是显示
    /// 提取链接中的参数以字典形式显示
    var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true), let queryItems = components.queryItems else {
            return nil
        }
        var parameters = [String: String]()
        for item in queryItems {
            parameters[item.name] = item.value
        }
        return parameters
    }
    
    // MARK: 1.2、属性说明
    /// 属性说明
    func propertyDescription() {
        GConfig.log("完整的url字符串 absoluteString：\(self.absoluteString) 协议 scheme：\(self.scheme ?? "") 域名 host：\(self.host ?? "") 路径 path：\(self.path) 相对路径 relativePath：\(self.relativePath) 端口 port：\(self.port ?? 0) pathComponents：\(self.pathComponents) 参数 query：\(self.query ?? "")")
    }
    
    // MARK: 1.3、检测应用是否能打开这个URL实例
    /// 1.3、检测应用是否能打开这个URL实例
    /// - Returns: 结果
    func verifyUrl() -> Bool {
        return UIApplication.shared.canOpenURL(self)
    }
}
