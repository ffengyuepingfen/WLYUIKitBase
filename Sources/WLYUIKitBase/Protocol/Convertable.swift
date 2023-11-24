//
//  Convertable.swift
//  DynamicBusClient
//
//  Created by zhonghangxun on 2019/7/24.
//  Copyright © 2019 WLY. All rights reserved.
//

import Foundation

/// 直接将Struct或Class转成Dictionary
public protocol Convertable: Codable {
    
}

extension Convertable {
    /// 直接将Struct或Class转成Dictionary
    public func convertToDict() -> Dictionary<String, Any>? {
        
        var dict: Dictionary<String, Any>? = nil
        
        do {
            print("init student")
            let encoder = JSONEncoder()
            
            let data = try encoder.encode(self)
            print("struct convert to data")
            
            dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any>
            
        } catch {
            print(error)
        }
        
        return dict
    }
}

/// 测试数据

//struct Student: Convertable {
//
//    var name: String
//    var age: Int
//    var classRoom: String
//
//    init(_ name: String, age: Int, classRoom: String) {
//        self.name = name
//        self.age = age
//        self.classRoom = classRoom
//    }
//}
//
//let student = Student("xiaoming", age: 10, classRoom: "五一班")
//
//print(student.convertToDict() ?? "nil")

