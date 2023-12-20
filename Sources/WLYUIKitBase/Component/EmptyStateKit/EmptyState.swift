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
    
    case noData
    case noInfo(actionName: String?, ti: String, des: String)
    
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
            
        case .noData: return UIImage(named: "profile")
        case .noInfo: return UIImage(named: "profile")
            
        }
    }
    
    public var title: String? {
        switch self {
        case .noNotifications: return "No message notifications"
        case .noBox: return "The box is empty"
        case .noCart: return "The cart is empty"
        case .noFavorites: return "线路收藏"
        case .noLocation:  return "Where are you?"
        case .noProfile: return "Not logged In"
        case .noSearch: return "No results"
        case .noTags: return "No collections"
        case .noInternet: return "We’re Sorry"
        case .noIncome: return "No income"
        case .inviteFriend: return "Ask friend!"
            
        case .noData: return "无数据"
        case .noInfo(_,let  ti, _) : return ti
        }
    }
    
    public var description: String? {
        switch self {
        case .noNotifications: return "Sorry, you don't have any message. Please come back later!"
        case .noBox: return "You dont have any email!"
        case .noCart: return "Please, select almost one item to purchase"
        case .noFavorites: return "快去线路列表收藏吧"
        case .noLocation: return "We can't find your location"
        case .noProfile: return "Please register or log in first"
        case .noSearch: return "Please try another search item"
        case .noTags: return "Go to collect favorites products"
        case .noInternet: return "Our staff is still working on the issue for better experience"
        case .noIncome: return "You have no payment so contact your client"
        case .inviteFriend: return "You could borrow money from your network"
            
        case .noData: return "还没有数据，去别处看看吧"
        case .noInfo(_,_, let des) : return des
        }
    }
    
    public var titleButton: String? {
        switch self {
        case .noNotifications: return "Search again?"
        case .noBox: return "Search again?"
        case .noCart: return "Go back"
        case .noFavorites: return "去收藏"
        case .noLocation: return "Locate now!"
        case .noProfile: return "Log in now!"
        case .noSearch: return "Go back"
        case .noTags: return "Go shopping"
        case .noInternet: return "Try again?"
        case .noIncome: return "Request payment"
        case .inviteFriend: return "View contact"
            
        case .noData: return nil
        case .noInfo(let action, _, _) : return action
        }
    }
}
