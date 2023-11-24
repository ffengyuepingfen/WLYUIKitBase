//
//  UITableViewEx.swift
//  RealTimeBusThird
//
//  Created by Laowang on 2023/11/3.
//

import UIKit

public typealias UITableViewableProcol = UITableViewDataSource & UITableViewDelegate

extension UITableView {
    
    public static func customFixLayoutTableView(cells: [UITableViewCell.Type], target: UITableViewableProcol, estimatedRowHeight: CGFloat = 128) -> UITableView {
        let tt = UITableView(frame: CGRect.zero, style: .plain)
        tt.delegate = target
        tt.dataSource = target
        cells.forEach { c in
            tt.register(cellClass: c)
        }
        tt.backgroundColor = UIColor.backGroundColor()
        tt.layer.cornerRadius = 6.0
        tt.rowHeight = UITableView.automaticDimension
        tt.estimatedRowHeight = estimatedRowHeight
        tt.separatorStyle = .none
        tt.tableFooterView = UIView(frame: CGRect.zero)
        return tt
    }
    
    // MARK: 1.1、tableView 在 iOS 11 上的适配
    /// tableView 在 iOS 11 上的适配
    func tableViewNeverAdjustContentInset() {
        if #available(iOS 11, *) {
            self.estimatedRowHeight = 0
            self.estimatedSectionFooterHeight = 0
            self.estimatedSectionHeaderHeight = 0
            self.contentInsetAdjustmentBehavior = .never
        }
    }
    
//    // MARK: 1.2、是否滚动到顶部
//    /// 是否滚动到顶部
//    /// - Parameter animated: 是否要动画
//    func scrollToTop(animated: Bool) {
//        self.setContentOffset(CGPoint(x: 0, y: 0), animated: animated)
//    }
//    
//    // MARK: 1.3、是否滚动到底部
//    /// 是否滚动到底部
//    /// - Parameter animated: 是否要动画
//    func scrollToBottom(animated: Bool) {
//        let y = self.contentSize.height - self.frame.size.height
//        if y < 0 { return }
//        self.setContentOffset(CGPoint(x: 0, y: y), animated: animated)
//    }
//    
//    // MARK: 1.4、滚动到什么位置（CGPoint）
//    /// 滚动到什么位置（CGPoint）
//    /// - Parameter animated: 是否要动画
//    func scrollToOffset(offsetX: CGFloat = 0, offsetY: CGFloat = 0, animated: Bool) {
//        self.setContentOffset(CGPoint(x: offsetX, y: offsetY), animated: animated)
//    }
    
    // MARK: 1.5、注册自定义cell
    /// 注册自定义cell
    /// - Parameter cellClass: UITableViewCell类型
    func register<T: UITableViewCell>(cellClass: T.Type) {
        self.register(cellClass, forCellReuseIdentifier: cellClass.w_identifier)
    }
    
    // MARK: 1.7、创建UITableViewCell(注册后使用该方法)
    /// 创建UITableViewCell(注册后使用该方法)
    /// - Parameters:
    ///   - cellType: UITableViewCell类型
    ///   - indexPath: indexPath description
    /// - Returns: 返回UITableViewCell类型
    public func dequeueReusableCell<T: UITableViewCell>(cellType: T.Type, cellForRowAt indexPath: IndexPath) -> T  {
        return self.dequeueReusableCell(withIdentifier: cellType.w_identifier, for: indexPath) as! T
    }
}
