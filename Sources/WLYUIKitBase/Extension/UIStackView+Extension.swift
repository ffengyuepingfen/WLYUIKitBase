//
//  UIStackView+Extension.swift
//  WGEstate
//
//  Created by Xiangbo Wang on 2022/10/6.
//

import UIKit

// MARK: UIStackView扩展
extension UIStackView {
    
    /// 便捷初始化方法
    public convenience init(
        arrangedSubviews: [UIView],
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat = 0.0,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill) {

        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
    
    /// 添加管理视图
    public func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
    
    /// 添加管理视图 并且 设置约束
    public func addArrangedSubviews(_ views: [UIView], makeConstraint:() -> (Void))  {
        makeConstraint()
        for view in views {
            addArrangedSubview(view)
            view.makeConstraint()
        }
    }
    
    /// 添加管理视图 并且 设置约束
    public func insertArrangedSubview(_ view: UIView, at: Int, makeConstraint:() -> (Void))  {
        makeConstraint()
        insertArrangedSubview(view, at: at)
        view.makeConstraint()
    }
    
    /// 移除管理视图
    public func removeArrangedSubviews() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
        }
    }
    
    /// 生成一个指定间隔的填充区域
    public func spacer(_ space: CGFloat) -> UIView {
        let spacer = UIView()
        switch self.axis {
        case .horizontal:
            spacer.widthConstraint = space
        case .vertical:
            spacer.heightConstraint = space
        default:
            break
        }
        return spacer
    }
    
    /// 生成一个填充区域
    public func spacer() -> UIView {
        let spacer = UIView()
        return spacer
    }
}

// MARK: HStack
public class HHStack: UIStackView {
    public convenience init (
        spacing: CGFloat = 0.0,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill) {

        self.init(arrangedSubviews: [], axis: .horizontal, spacing: spacing, alignment:alignment, distribution: distribution)

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .horizontal
        self.spacing = 0.0
        self.alignment = .fill
        self.distribution = .fill
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: VStack
public class VVStack: UIStackView {
    /// 便捷初始化方法
    public convenience init (
        spacing: CGFloat = 0.0,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill) {
            
        self.init(arrangedSubviews: [], axis: .vertical, spacing: spacing, alignment:alignment, distribution: distribution)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.spacing = 0.0
        self.alignment = .fill
        self.distribution = .fill
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private var widthConstraintKey = "widthConstraintKey"
private var heightConstraintKey = "heightConstraintKey"
private var sizeConstraintKey = "sizeConstraintKey"

// MARK: UIView支持StackView的扩展
extension UIView {
    /// 宽度约束量
    public var widthConstraint: CGFloat {
        get {
            return objc_getAssociatedObject(self, &widthConstraintKey) as? CGFloat ?? 0
        }
        set {
            objc_setAssociatedObject(self, &widthConstraintKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    /// 高度约束量
    public var heightConstraint: CGFloat {
        get {
            return objc_getAssociatedObject(self, &heightConstraintKey) as? CGFloat ?? 0
        }
        set {
            objc_setAssociatedObject(self, &heightConstraintKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    /// 尺寸约束量
    public var sizeConstraint: CGSize {
        get {
            return objc_getAssociatedObject(self, &sizeConstraintKey) as? CGSize ?? .zero
        }
        set {
            objc_setAssociatedObject(self, &sizeConstraintKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    /// 根据设置约束
    func makeConstraint() {
        if (widthConstraint > 0) { makeWidthConstraint(widthConstraint) }
        
        if (heightConstraint > 0) { makeHeightConstraint(heightConstraint) }
        
        if (sizeConstraint.width > 0 || sizeConstraint.height > 0) {
            makeWidthConstraint(sizeConstraint.width)
            makeHeightConstraint(sizeConstraint.height)
        }
    }
    
    /// 设置高度约束
    func makeHeightConstraint(_ height: CGFloat) {
        let heightCons = NSLayoutConstraint.init(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: height)
        NSLayoutConstraint.activate([heightCons])
    }
    
    /// 设置宽度约束
    func makeWidthConstraint(_ width: CGFloat) {
        let widthCons = NSLayoutConstraint.init(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: width)
        NSLayoutConstraint.activate([widthCons])
    }

}

/// 页面主要流式布局 容器  UIKit时代使用的
public class CICMianFlowView: UIView, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    private lazy var scrollView: UIScrollView = {
        let ss = UIScrollView()
        ss.backgroundColor = UIColor.clear
        ss.showsHorizontalScrollIndicator = false
        ss.showsVerticalScrollIndicator = false
        ss.delegate = self
        
        ss.bounces = isBounces
        return ss
    }()
    
    private var stackView: UIStackView!
    private var isBounces = true
    
    public var callIndex: ((Int)->Void)?
    
    public var updateAction: (()->Void)?
    
    private var themeColor = UIColor.PrimaryBackground()
    
    public init(isVStack: Bool = true,
                insets: UIEdgeInsets = UIEdgeInsets.sixteen,
                isBounces: Bool = true,
                isShowLoading: Bool = false,
                fillColor: UIColor = UIColor.PrimaryBackground()) {
        self.isBounces = isBounces
        self.themeColor = fillColor
        super.init(frame: CGRect.zero)
        if isVStack {
            stackView = VVStack(spacing: 12.0, alignment: .center)
        }else{
            stackView = HHStack(alignment: .center)
            self.scrollView.isPagingEnabled = true
            self.scrollView.isDirectionalLockEnabled = true
        }
        
        if isShowLoading {
            stackView.backgroundColor = .PrimaryBackground()
            // 初始化下拉刷新控件
            let refreshControl = UIRefreshControl()
            refreshControl.tintColor = UIColor.white
            // 设置刷新动作
            refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
            // 添加到 tableView
            scrollView.refreshControl = refreshControl
        }
        initUI(insets: insets)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI(insets: UIEdgeInsets) {
        self.addSubviewAnchor(subView: scrollView)
        scrollView.addSubviewAnchor(subView: stackView, insets: insets)
    }
    
    @objc func refreshData() {
        if let updateAction {
            updateAction()
        }
        scrollView.refreshControl?.endRefreshing()
    }
    
    /// 生成一个指定间隔的填充区域
    public func spacer(_ space: CGFloat) -> UIView {
        let spacer = UIView()
        switch self.stackView.axis {
        case .horizontal:
            spacer.widthConstraint = space
        case .vertical:
            spacer.heightConstraint = space
        default:
            break
        }
        return spacer
    }
    
    /// 生成一个填充区域
    public func spacer() -> UIView {
        let spacer = UIView()
        return spacer
    }
    
    /// 追加一组视图
    /// - Parameter views: views
    public func addArrangedSubviews(views: [UIView], makeConstraint:() -> (Void)) {
        
        stackView.addArrangedSubviews(views, makeConstraint: makeConstraint)
    }
    
    /// 追加一个视图
    /// - Parameter view: view
    public func addArrangedSubview(view: UIView, makeConstraint:() -> (Void)) {
        stackView.addArrangedSubviews([view], makeConstraint: makeConstraint)
    }
    
    /// 插入一个视图在指定的位置
    /// - Parameters:
    ///   - view: 插入的视图
    ///   - index: 插入的位置
    public func insertArrangedSubview(view: UIView, index: NSInteger, makeConstraint:() -> (Void)) {
        stackView.insertArrangedSubview(view, at: index, makeConstraint: makeConstraint)
    }
    
    /// 移除指定的视图
    /// - Parameter view: view
    public func remove(view: UIView) {
        stackView.removeArrangedSubview(view)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        if let callIndex {
            callIndex(Int(pageIndex))
        }
    }
   
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewHeight = scrollView.bounds.size.height
        let contentHeight = scrollView.contentSize.height
        let yOffset = scrollView.contentOffset.y
        let maxOffset = scrollView.contentInset.top + scrollViewHeight - contentHeight

        // 判断是否正在下拉
        if yOffset < 0 {
            // 用户正在下拉
            print("下拉中...")
            // 这里可以添加你的逻辑，比如触发加载更多数据等
            scrollView.backgroundColor = themeColor
        }else{
            scrollView.backgroundColor = .PrimaryBackground()
        }
    }
}
