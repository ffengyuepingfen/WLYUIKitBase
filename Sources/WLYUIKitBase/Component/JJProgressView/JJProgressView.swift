//
//  JJProgressView.swift
//  FlosSophorae
//
//  Created by wangxiangbo on 2020/7/6.
//

import UIKit

public class JJProgressView: UIView {
    
    public var percent = 0.0{
        didSet {
            if percent <= 0.0 {
                percent = 0.0
            }
            if percent >= 1.0 {
                percent = 1.0
            }
            
            
            UIView.animate(withDuration: 2.5) {
                switch self.percent {
                case 0.0...0.33:
                    self.percentView.backgroundColor = JJProgressView.rich()
                    self.backgroundColor = JJProgressView.graybackgroud()
                        JJProgressView.richBackgroud()
                case 0.33...0.66:
                    self.percentView.backgroundColor = JJProgressView.normal()
                    self.backgroundColor = JJProgressView.graybackgroud()
//                        JJProgressView.normalBackgroud()
                case 0.66...1.0:
                    self.percentView.backgroundColor = JJProgressView.full()
                    self.backgroundColor = JJProgressView.graybackgroud()
//                        JJProgressView.fullBackground()
                default:
                    self.percentView.backgroundColor = JJProgressView.rich()
                    self.backgroundColor = JJProgressView.graybackgroud()
//                        JJProgressView.richBackgroud()
                }
                self.percentViewTrailing = self.width*CGFloat(1 - self.percent)
                self.layoutIfNeeded()
            }
        }
    }
    
    private var percentViewTrailing:CGFloat = 0{
        didSet {
            self.ttAnchor.isActive = false
            self.ttAnchor = self.percentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.percentViewTrailing)
            self.ttAnchor.isActive = true
        }
    }
    private var ttAnchor:NSLayoutConstraint!
    private var width:CGFloat = 0
    private var height:CGFloat = 0
    private var percentView:UIView!
    
    public init(percent:Double,frame:CGRect) {
        super.init(frame: frame)
        self.width = frame.size.width
        self.height = frame.size.height
        self.percent = percent
        self.layer.cornerRadius = 4.0
        self.percentViewTrailing = width
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI()  {
        self.backgroundColor = JJProgressView.graybackgroud()
        percentView = UIView(frame: CGRect.zero)
        percentView.backgroundColor = JJProgressView.rich()
        percentView.layer.cornerRadius = 4.0
        self.addSubview(percentView)
        percentView.translatesAutoresizingMaskIntoConstraints = false
        percentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        percentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        percentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        ttAnchor = percentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -percentViewTrailing)
        ttAnchor.isActive = true
    }
    
}

extension JJProgressView {
    
    /// Description 富足:小于百分之33 绿色
    /// - Returns: description
    static func rich() -> UIColor {
        return UIColor.hex(hexString: "#4CAF50")
    }
    
    /// Description 富足:小于百分之33 绿色
    /// - Returns: description
    static func richBackgroud() -> UIColor {
        return UIColor.hex(hexString: "#A5D6A7")
    }
    
    /// Description 一般情况 百分之33 - 66 蓝色
    /// - Returns: description
    static func normal() -> UIColor {
        return UIColor.hex(hexString: "#2196F3")
    }
    
    /// Description 一般情况 百分之33 - 66 蓝色
    /// - Returns: description
    static func normalBackgroud() -> UIColor {
        return UIColor.hex(hexString: "#90CAF9")
    }
    
    /// Description  火爆 大于百分之66
    /// - Returns: description
    static func full() -> UIColor {
        return UIColor.hex(hexString: "#F44336")
    }
    
    /// Description  火爆 大于百分之66
    /// - Returns: description
    static func fullBackground() -> UIColor {
        return UIColor.hex(hexString: "#FFCDD2")
    }
    
    static func graybackgroud() -> UIColor {
        return UIColor.hex(hexString: "#EEEEEE")
    }
}
