//
//  EmptyState.swift
//  StateView
//
//  Created by Alberto Aznar de los Ríos on 23/05/2019.
//  Copyright © 2019 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

public protocol EmptyStateDelegate: AnyObject {
    func emptyState(emptyState: EmptyState, didPressButton button: UIButton)
}

public protocol EmptyStateDataSource: AnyObject {
    func imageForState(_ state: CustomState, inEmptyState emptyState: EmptyState) -> UIImage?
    func titleForState(_ state: CustomState, inEmptyState emptyState: EmptyState) -> String?
    func descriptionForState(_ state: CustomState, inEmptyState emptyState: EmptyState) -> String?
    func titleButtonForState(_ state: CustomState, inEmptyState emptyState: EmptyState) -> String?
}

public class EmptyState {
    
    public weak var delegate: EmptyStateDelegate?
    public weak var dataSource: EmptyStateDataSource?
    
    private var emptyStateView: EmptyStateView!
    private var tableView: UITableView?
    private var separatorStyle: UITableViewCell.SeparatorStyle = .none
    
    /// Show or hide view
    private var hidden = true {
        didSet {
            emptyStateView?.isHidden = hidden
        }
    }
    
    /// State mode
    private var state: CustomState? {
        didSet {
            guard let state = state else { return }
            if let dataSource = dataSource {
                emptyStateView.viewModel = EmptyStateView.ViewModel(
                    image: dataSource.imageForState(state, inEmptyState: self),
                    title: dataSource.titleForState(state, inEmptyState: self),
                    description: dataSource.descriptionForState(state, inEmptyState: self),
                    titleButton: dataSource.titleButtonForState(state, inEmptyState: self))
            } else {
                emptyStateView.viewModel = EmptyStateView.ViewModel(
                    image: state.image,
                    title: state.title,
                    description: state.description,
                    titleButton: state.titleButton)
            }
        }
    }
    
    public var format = EmptyStateFormat() {
        didSet {
            emptyStateView.format = format
        }
    }
    
    init(inView view: UIView?) {
        
        // Create empty state view
        emptyStateView = EmptyStateView()
        emptyStateView.isHidden = true
        emptyStateView.actionButton = { [weak self] (button) in
            self?.didPressActionButton(button)
        }
        
        // Add it to your view
        if let view = view as? UITableView {
            view.backgroundView = emptyStateView
            tableView = view
            separatorStyle = view.separatorStyle
        } else if let view = view as? UICollectionView {
            view.backgroundView = emptyStateView
        } else {
            if let view {
                emptyStateView.frame = view.bounds
                view.addSubviewAnchor(subView: emptyStateView)
            }
        }
    }
}

extension EmptyState {
    
    public func show(_ state: CustomState? = nil) {
        self.state = state
        self.format = EmptyStateFormat()
        hidden = false
        tableView?.separatorStyle = .none
        emptyStateView.play()
    }
    
    public func hide() {
        hidden = true
        tableView?.separatorStyle = separatorStyle
    }
}

extension EmptyState {
    
    private func didPressActionButton(_ button: UIButton) {
        delegate?.emptyState(emptyState: self, didPressButton: button)
    }
}


public enum CictecState: CustomState {
    
    case noMessages
    case noBox
    case noCart
    case noFavorites
    case noLocation
    case noProfile
    case noSearch
    case noData
    case noInfo(imageName: String? = nil,actionName: String? = nil, ti: String, des: String)
    case noDataInfo(imageName: UIImage? = nil,actionName: String? = nil, ti: String, des: String)
    
    public var image: UIImage? {
        switch self {
        case .noMessages: return UIImage(named: "messages")
        case .noBox: return UIImage(named: "box")
        case .noCart: return UIImage(named: "cart")
        case .noFavorites: return UIImage(named: "favorites")
        case .noLocation: return UIImage(named: "location")
        case .noProfile: return UIImage(named: "profile")
        case .noSearch: return UIImage(named: "search")
            
        case .noData: return UIImage(named: "tags")
        case .noInfo(let imageName,_,_, _): return UIImage(named: imageName ?? "tags")
        case .noDataInfo(let image,_,_, _): return image ?? UIImage(named: "tags")
            
        }
    }
    
    public var title: String? {
        switch self {
        case .noMessages: return "无消息通知"
        case .noBox: return "这里是空的"
        case .noCart: return "这里是空的"
        case .noFavorites: return "还没有喜欢的"
        case .noLocation:  return "你在哪?"
        case .noProfile: return "未登录"
        case .noSearch: return "没有结果"
            
        case .noData: return "这里是空的"
        case .noInfo(_,_,let ti, _) : return ti
        case .noDataInfo(_,_,let ti, _): return ti
            
        }
    }
    
    public var description: String? {
        switch self {
        case .noMessages: return "对不起，您还没有消息。请稍后再来!"
        case .noBox: return "You dont have any email!"
        case .noCart: return "Please, select almost one item to purchase"
        case .noFavorites: return "先选择你最喜欢的项目!"
        case .noLocation: return "我们找不到你的位置"
        case .noProfile: return "请先注册或登录"
        case .noSearch: return "请尝试其他关键字搜索"
            
        case .noData: return "这里还没有数据，去别处看看吧"
        case .noInfo(_,_,_, let des) : return des
        case .noDataInfo(_,_,_, let des) : return des
        }
    }
    
    public var titleButton: String? {
        switch self {
        case .noMessages: return "加载数据?"
        case .noBox: return "加载数据?"
        case .noCart: return "返回"
        case .noFavorites: return "返回"
        case .noLocation: return nil
        case .noProfile: return nil
        case .noSearch: return "返回"
            
        case .noData: return nil
        case .noInfo(_,let action, _, _) : return action
        case .noDataInfo(_,let action, _, _) : return action
        }
    }
}
