//
//  WLYsegementView.swift
//  DynamicBusClient
//
//  Created by zhonghangxun on 2019/4/25.
//  Copyright © 2019 WLY. All rights reserved.
//

/**
 # IMPORTANT: WLYsegementView:
 创建一个新闻标题样式的管理页面.
 1. Start with
 1. Write anything important you want to emphasize
 1. End with  at a new line.
 ---
 [More info - https://github.com/kingsic/SGPagingView](https://github.com/kingsic/SGPagingView)
 */

import UIKit

public enum SegementViewTitleType {
    case Center
    case Left
}

public class CICSegementView:NSObject {
    /// 当前选中的位置
    public var selectedIndex = 0
    public var selectedIndexBlock:((_ index:NSInteger)->Void)?
    /// 题目
    private var pageTitleView: SGPageTitleView? = nil
    /// 内容
    private var pageContentView: SGPageContentScrollView? = nil
    ///
    private var titleArray: [String] = []
    ///
    private var vcs: [UIViewController] = []
    ///
    private weak var parentVC: UIViewController!
    ///
    private var titleType:SegementViewTitleType = .Center

    private var titleBackView:UIView? = nil
    /// 主题颜色
    private var tinColor:UIColor!
    /// 容器
    var containerView:UIView? = nil
    /// 标题的北京颜色
    var titleBackCorlor:UIColor?
    /// 标题的颜色
    var titleColor: UIColor? = nil
    
    var bannerView:UIView? = nil
    
    public init(titleArray: [String],
                vcs: [UIViewController],
                parentVC: UIViewController,
                type:SegementViewTitleType = SegementViewTitleType.Center,
                tinColor:UIColor = UIColor.hex(hexString: "#3ccd5C"),
                superView:UIView? = nil,titleBackCorlor:UIColor? = nil,bannerView:UIView? = nil,titleColor: UIColor? = nil) {
        self.titleArray = titleArray
        self.vcs = vcs
        self.parentVC = parentVC
        self.titleType = type
        self.tinColor = tinColor
        self.containerView = superView
        self.titleBackCorlor = titleBackCorlor
        self.bannerView = bannerView
        self.titleColor = titleColor
        super.init()
        self.setupPageView()
    }
    private func setupPageView() {

        let configure = SGPageTitleViewConfigure()
        configure.titleSelectedColor =   self.tinColor
        configure.indicatorColor =  .systemOrange
        configure.indicatorStyle = .Dynamic
        configure.titleAdditionalWidth = 35.0
        configure.bottomSeparatorColor = UIColor.clear
        configure.titleGradientEffect = true
        configure.indicatorHeight = 4.0
        configure.indicatorCornerRadius = 2.0
        if titleBackCorlor != nil {
            configure.titleColor = UIColor.white
        }
        if titleColor != nil {
            configure.titleColor = titleColor!
        }
        /// pageTitleView
        /// 计算title的宽度
        var defaultWidth:CGFloat = GConfig.ScreenW
        if let containerView = containerView  {
            defaultWidth = containerView.bounds.width
        }
        
        var width:CGFloat = defaultWidth
        
        if titleType == .Left {
            width = titleArray.reduce(0) { (num, str) in
                return num + str.getNormalStrW(strFont: 15.0, h: 20.0)
            }
            width += CGFloat(titleArray.count) * configure.titleAdditionalWidth + 20.0
            if width >= defaultWidth {
                width = defaultWidth
            }
        }
        
        pageTitleView = SGPageTitleView(frame: CGRect(x: 0,
                                                      y: 0,
                                                      width: width,
                                                      height: 44),
                                        delegate: self,
                                        titleNames: titleArray,
                                        configure: configure)

        titleBackView = UIView(frame: CGRect(x: 0, y: 0, width: defaultWidth, height: 44))
        if titleBackCorlor != nil {
            pageTitleView?.backgroundColor = titleBackCorlor
            titleBackView?.backgroundColor = titleBackCorlor
        }else{
            titleBackView?.backgroundColor = UIColor.white
        }
        
        titleBackView?.addSubview(pageTitleView!)
        var backView: UIView = (parentVC?.view) ?? UIView()
        if let containerView = containerView {
            backView = containerView
        }
        
        backView.addSubview(titleBackView!)
        var contentViewHeight = backView.frame.size.height - self.pageTitleView!.frame.maxY
        var Y = (pageTitleView?.frame.maxY)!
        /// bannerview
        if let bannerView = bannerView {
            backView.addSubview(bannerView)
            contentViewHeight = contentViewHeight - backView.frame.size.width/4
            Y = Y + backView.frame.size.width/4
        }
        let contentRect = CGRect(x: 0, y: Y, width: defaultWidth, height: contentViewHeight)
        pageContentView = SGPageContentScrollView(frame: contentRect, parentVC: parentVC, childVCs: vcs)
        pageContentView?.delegateScrollView = self
        backView.addSubview(pageContentView!)
    }

    public func clearData() {
        pageContentView?.removeFromSuperview()
        
        titleBackView?.removeFromSuperview()
    }
    
}

extension CICSegementView: SGPageTitleViewDelegate, SGPageContentScrollViewDelegate {
    
    
    func pageTitleView(pageTitleView: SGPageTitleView, index: Int) {
        pageContentView?.setPageContentScrollView(index: index)
        if let selectedIndexBlock = selectedIndexBlock {
            selectedIndexBlock(index)
        }
        self.selectedIndex = index
    }
    
    func pageContentScrollView(pageContentScrollView: SGPageContentScrollView, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        pageTitleView?.setPageTitleView(progress: progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
    
    func pageContentScrollView(pageContentScrollView: SGPageContentScrollView, index: Int) {
        if let selectedIndexBlock = selectedIndexBlock {
            selectedIndexBlock(index)
        }
        self.selectedIndex = index
    }

}
