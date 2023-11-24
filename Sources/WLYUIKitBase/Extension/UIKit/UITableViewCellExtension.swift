//
//  File.swift
//  
//
//  Created by Laowang on 2023/5/16.
//

import UIKit

// MARK: - 一、基本的扩展
public extension UITableViewCell {
    
    // MARK: 返回cell所在的UITableView
    /// 返回cell所在的UITableView
    /// - Returns: cell 所在的UITableView
    func superTableView() -> UITableView? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let tableView = view as? UITableView  {
                return tableView
            }
        }
        return nil
    }
    
    // MARK: 标识符
    var identifier: String {
        get {
            let classStr = NSStringFromClass(Self.self)
            // 获取类名
            return classStr.components(separatedBy: ".").last!
        }
    }
    
}
