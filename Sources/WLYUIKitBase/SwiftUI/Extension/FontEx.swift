//
//  File.swift
//  
//
//  Created by Laowang on 2024/1/10.
//

import SwiftUI

extension Font {
    
    public static let title22: Font = {
        if #available(iOS 14.0, *) {
            return Font.title2
        } else {
            return Font.subheadline
        }
    }()
    
    public static let title33: Font = {
        if #available(iOS 14.0, *) {
            return Font.title3
        } else {
            return Font.subheadline
        }
    }()
    
    public static let caption22: Font = {
        if #available(iOS 14.0, *) {
            return Font.caption2
        } else {
            return Font.caption
        }
    }()
}
