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
    
    case noNotifications
    case noBox
    case noCart
    case noFavorites
    case noLocation
    case noProfile
    case noSearch
    case noTags
    case noInternet
    case noIncome
    case inviteFriend
    case noData(imageName: UIImage?,actionName: String?, ti: String, des: String)
    case noInfo(imageName: String?,actionName: String?, ti: String, des: String)
    
    public var image: UIImage? {
        switch self {
        case .noNotifications: return UIImage(named: "Messages")
        case .noBox: return UIImage(named: "Box")
        case .noCart: return UIImage(named: "Cart")
        case .noFavorites: return UIImage(named: "Favorites")
        case .noLocation: return UIImage(named: "Location")
        case .noProfile: return UIImage(named: "Profile")
        case .noSearch: return UIImage(named: "Search")
        case .noTags: return UIImage(named: "Tags")
        case .noInternet: return UIImage(named: "Internet")
        case .noIncome: return UIImage(named: "Income")
        case .inviteFriend: return UIImage(named: "Invite")
            
        case .noData(let image,_,_, _): return image ?? UIImage(named: "Tags")
        case .noInfo(let imageName,_,_, _): return UIImage(named: imageName ?? "Tags")
            
        }
    }
    
    public var title: String? {
        switch self {
        case .noNotifications: return "无消息通知"
        case .noBox: return "这里是空的"
        case .noCart: return "这里是空的"
        case .noFavorites: return "还没有喜欢的"
        case .noLocation:  return "你在哪?"
        case .noProfile: return "未登录"
        case .noSearch: return "没有结果"
        case .noTags: return "没有收藏"
        case .noInternet: return "我们很抱歉"
        case .noIncome: return "No income"
        case .inviteFriend: return "Ask friend!"
            
        case .noData(_,_,let  ti, _) : return ti
        case .noInfo(_,_,let  ti, _) : return ti
        }
    }
    
    public var description: String? {
        switch self {
        case .noNotifications: return "对不起，您还没有消息。请稍后再来!"
        case .noBox: return "You dont have any email!"
        case .noCart: return "Please, select almost one item to purchase"
        case .noFavorites: return "先选择你最喜欢的项目!"
        case .noLocation: return "我们找不到你的位置"
        case .noProfile: return "请先注册或登录"
        case .noSearch: return "请尝试其他关键字搜索"
        case .noTags: return "Go to collect favorites products"
        case .noInternet: return "我们的工作人员仍在努力解决这个问题，以获得更好的体验"
        case .noIncome: return "You have no payment so contact your client"
        case .inviteFriend: return "You could borrow money from your network"
            
        case .noData(_,_,_, let des) : return des
        case .noInfo(_,_,_, let des) : return des
        }
    }
    
    public var titleButton: String? {
        switch self {
        case .noNotifications: return "加载数据?"
        case .noBox: return "加载数据?"
        case .noCart: return "返回"
        case .noFavorites: return "返回"
        case .noLocation: return nil
        case .noProfile: return nil
        case .noSearch: return "返回"
        case .noTags: return nil
        case .noInternet: return nil
        case .noIncome: return nil
        case .inviteFriend: return nil
            
        case .noData(_,let action, _, _) : return action
        case .noInfo(_,let action, _, _) : return action
        }
    }
}
