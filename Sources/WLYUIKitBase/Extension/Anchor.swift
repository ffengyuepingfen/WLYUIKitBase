//
//  Anchor.swift
//  WLYUIKitBase
//
//  Created by JianjiaCoder on 2021/1/22.
//

import UIKit

extension UIView {

    public func jjjAnchorPutIn(faView: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let top = self.topAnchor.constraint(equalTo: faView.topAnchor, constant: insets.top)
        let leading = self.leadingAnchor.constraint(equalTo: faView.leadingAnchor, constant: insets.left)
        let trailing = self.trailingAnchor.constraint(equalTo: faView.trailingAnchor, constant: -insets.right)
        let bottom = self.bottomAnchor.constraint(equalTo: faView.bottomAnchor, constant: -insets.bottom)
        NSLayoutConstraint.activate([top, leading, trailing, bottom])
    }

}

extension UIViewController {

    public func jjjAnchorPutIn(childView: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        childView.translatesAutoresizingMaskIntoConstraints = false
        let top = childView.topAnchor.constraint(equalTo: self.layoutGuide.topAnchor, constant: insets.top)
        let leading = childView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: insets.left)
        let trailing = childView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -insets.right)
        let bottom = childView.bottomAnchor.constraint(equalTo: self.layoutGuide.bottomAnchor, constant: -insets.bottom)
        NSLayoutConstraint.activate([top, leading, trailing, bottom])
    }
}
