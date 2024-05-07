//
//  UserDefaultStorage.swift
//  
//
//  Created by Laowang on 2024/4/16.
//

import Foundation

//@propertyWrapper
//struct UserDefaultStorage<T: Codable> {
//    var value: T?
//
//    let key: String
//
//    let queue = DispatchQueue(label: (UUID().uuidString))
//
//    init(fileName: String) {
//        value = try? FileHelper.loadJSON(from: directory, fileName: fileName)
//        self.directory = directory
//        self.fileName = fileName
//    }
//
//    var wrappedValue: T? {
//        set {
//            value = newValue
//            let directory = self.directory
//            let fileName = self.fileName
//            queue.async {
//                if let value = newValue {
//                    try? FileHelper.writeJSON(value, to: directory, fileName: fileName)
//                } else {
//                    try? FileHelper.delete(from: directory, fileName: fileName)
//                }
//            }
//        }
//        
//        get { value }
//    }
//}
