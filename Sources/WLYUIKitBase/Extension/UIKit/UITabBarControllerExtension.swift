//
//  File.swift
//  
//
//  Created by Laowang on 2023/5/16.
//

import Foundation
import UIKit

// MARK: - 一、基本的扩展
public extension UITabBarController {
    // MARK: 1.1、当前选择索引
    /// 当前选择索引
    static var selectedIdx: Int {
        guard let keyWindow = k_keyWindow,
              let rootController = keyWindow.rootViewController as? UITabBarController else { return 0}
        return rootController.selectedIndex
    }

    /// 用特定数据源刷新tabBar (暂时不可用)
    /// - Parameter list: 参照HomeViewController数据源
    fileprivate func reloadTabarItems(_ list: [[String]]) {
        for e in self.viewControllers!.enumerated(){
            let itemList = list[e.offset]
            let title = itemList[itemList.count - 4]
            let img = UIImage(named: itemList[itemList.count - 3])?.withRenderingMode(.alwaysOriginal)
            let imgH = UIImage(named: itemList[itemList.count - 2])?.withRenderingMode(.alwaysTemplate)
            e.element.tabBarItem = UITabBarItem(title: title, image: img, selectedImage: imgH)
        }
    }
}

