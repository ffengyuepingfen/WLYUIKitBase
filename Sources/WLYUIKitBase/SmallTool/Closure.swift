//
//  File.swift
//  
//
//  Created by Laowang on 2023/5/15.
//

import UIKit

/// View的闭包
public typealias ViewClosure = ((UITapGestureRecognizer?, UIView, NSInteger) ->Void)
/// 手势的闭包
public typealias RecognizerClosure = ((UIGestureRecognizer) ->Void)
/// UIControl闭包
public typealias ControlClosure = ((UIControl) ->Void)
