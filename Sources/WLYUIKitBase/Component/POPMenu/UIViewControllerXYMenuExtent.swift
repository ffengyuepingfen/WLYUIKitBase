//
//  UIViewControllerXYMenuExtent.swift
//  XYMenuSwiftDemo
//
//  Created by zhonghangxun on 2019/3/30.
//  Copyright © 2019 FireHsia. All rights reserved.
//

import UIKit

extension UIViewController {

    /// Description 弹框显示
    ///
    /// - Parameters:
    ///   - index: index description 当前d选择的第几个
    ///   - titles: titles description 所有的菜单的名称数组
    func showMessage(index: Int, titles: [String]) {
        let title = titles[index - 1]
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    /// Description  在UIbarButtonItem and UIButton 上弹出弹框
    ///
    /// - Parameters:
    ///   - sender: sender description  触发事件的来源
    ///   - type: type description 类型
    ///   - isNav: isNav description 是不是导航栏上
    func showXYMenu(sender: Any, type: XYMenuType, isNav: Bool) {
//        let images = ["code", "selected", "swap"]
//        let titles = ["付款码", "拍    照", "扫一扫"]
//        if isNav {
//            if let barButtonItem = sender as? UIBarButtonItem {
//                barButtonItem.xy_showXYMenu(images: images, titles: titles, currentNavVC: self.navigationController!, type: type, closure: { [unowned self] (index) in
//                    self.showMessage(index: index, titles: titles)
//                })
//            }
//        } else {
//            if let senderView = sender as? UIView {
//                senderView.xy_showXYMenu(images: images, titles: titles, type: type, closure: { [unowned self] (index) in
//                    self.showMessage(index: index, titles: titles)
//                })
//            }
//        }
    }
}
