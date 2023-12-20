//
//  EmptyStateFormat.swift
//  StateView
//
//  Created by Alberto Aznar de los Ríos on 23/05/2019.
//  Copyright © 2019 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

public struct EmptyStateFormat {
    
    /// Title attributes
    public var titleAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "AvenirNext-DemiBold", size: 26)!, .foregroundColor: UIColor.darkGray]
    
    /// Description attributes
    public var descriptionAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Avenir Next", size: 14)!, .foregroundColor: UIColor.darkGray]
    
    /// Button attributes
    public var buttonAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "AvenirNext-DemiBold", size: 14)!, .foregroundColor: UIColor.white]
    
    /// Button color
    public var buttonColor: UIColor = .red
    
    /// Image animation type
    public var animation: EmptyStateAnimation? = .scale(0.3, 0.3)
    
    /// Alpha container
    public var alpha: CGFloat = 1.0

    /// Tint color for template image
    public var imageTintColor: UIColor? = nil
    
    /// Background color
    public var backgroundColor: UIColor = UIColor.clear
    
    /// Background Gradient color
    public var gradientColor: (UIColor, UIColor)? = nil//(UIColor.randomColor(), UIColor.randomColor())
    
    public init() {}
}
