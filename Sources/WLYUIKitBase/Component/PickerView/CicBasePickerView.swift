//
//  CicPickerView.swift
//  
//
//  Created by Laowang on 2024/1/19.
//

import UIKit

class CicBasePickerView: UIView {

    var manager: CicPickerConfig = CicPickerConfig()
    /// 背景视图
    lazy var backgroundView: UIView = {
        let _backgroundView = UIView(frame: UIScreen.main.bounds)
        _backgroundView.backgroundColor = UIColor.init(white: 0, alpha: 0.2)
        let myTap = UITapGestureRecognizer(target: self, action: #selector(didTapBackgroundView))
        _backgroundView.addGestureRecognizer(myTap)
        return _backgroundView
    }()
    // 弹出视图
    lazy var alertView: UIView = {
        let _alertView = UIView(frame: CGRect(x: 0, y: GConfig.ScreenH - manager.kTopViewH - manager.kPickerViewH - GConfig.BottomSafeH, width: GConfig.ScreenW, height: manager.kTopViewH + manager.kPickerViewH + GConfig.BottomSafeH))
        _alertView.backgroundColor = .white
    
        return _alertView;
    }()
    // 顶部视图
    lazy var topView: UIView = {
        let _topView = UIView(frame: CGRect(x: 0, y: 0, width: GConfig.ScreenW, height: manager.kTopViewH + 0.5))
        return _topView
    }()
    // 左边取消按钮
    lazy var leftBtn: UIButton = {
        let _leftBtn = UIButton(type: .custom)
        _leftBtn.frame = CGRect(x: 5, y: 7, width: 60, height: self.manager.kTopViewH-14)
        _leftBtn.backgroundColor = manager.leftBtnBGColor
        _leftBtn.layer.cornerRadius = self.manager.leftBtnCornerRadius
        _leftBtn.layer.borderColor = self.manager.leftBtnborderColor.cgColor
        _leftBtn.layer.borderWidth = self.manager.leftBtnBorderWidth
        _leftBtn.layer.masksToBounds = true
        _leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: manager.leftBtnTitleSize)
        _leftBtn.setTitleColor(self.manager.leftBtnTitleColor, for: .normal)
        _leftBtn.setTitle(manager.leftBtnTitle, for: .normal)
        _leftBtn.addTarget(self, action: #selector(clickLeftBtn), for: .touchUpInside)
        return _leftBtn
    }()
    // 右边确定按钮
    lazy var rightBtn: UIButton = {
        let _rightBtn = UIButton(type: .custom)
        _rightBtn.frame = CGRect(x: GConfig.ScreenW - 65, y: 7, width: 60, height: self.manager.kTopViewH-14);
        _rightBtn.backgroundColor = self.manager.rightBtnBGColor
        _rightBtn.layer.cornerRadius = self.manager.rightBtnCornerRadius
        _rightBtn.layer.masksToBounds = true
        _rightBtn.layer.borderWidth = self.manager.rightBtnBorderWidth
        _rightBtn.layer.borderColor = self.manager.rightBtnborderColor.cgColor
        _rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: manager.rightBtnTitleSize)
        _rightBtn.setTitleColor(self.manager.rightBtnTitleColor, for: .normal)
        _rightBtn.setTitle(manager.rightBtnTitle, for: .normal)
        _rightBtn.addTarget(self, action: #selector(clickRightBtn), for: .touchUpInside)
        return _rightBtn
    }()
    // 中间标题
    lazy var titleLabel: UILabel = {
        let _titleLabel = UILabel(frame: CGRect(x: 65, y: 0, width: GConfig.ScreenW - 130, height: manager.kTopViewH))
        _titleLabel.backgroundColor = self.manager.titleLabelBGColor
        _titleLabel.font = UIFont.systemFont(ofSize: manager.titleSize)
        _titleLabel.textColor = self.manager.titleLabelColor
        _titleLabel.textAlignment = .center
        return _titleLabel
    }()
    // 分割线视图
    lazy var lineView: UIView = {
        let _lineView = UIView(frame: CGRect(x: 0, y: manager.kTopViewH, width: GConfig.ScreenW, height: 0.5))
        _lineView.backgroundColor  = self.manager.lineViewColor
        self.alertView.addSubview(_lineView)
        return _lineView
    }()

    /** 初始化子视图 */
    func initUI() {
        self.frame = UIScreen.main.bounds
        // 背景遮罩图层
        self.addSubview(backgroundView)
        // 弹出视图
        self.addSubview(alertView)
        // 设置弹出视图子视图
        // 添加顶部标题栏
        alertView.addSubview(topView)
        // 添加左边取消按钮
        topView.addSubview(leftBtn)
        // 添加右边确定按钮
        topView.addSubview(rightBtn)
        // 添加中间标题按钮
        topView.addSubview(titleLabel)
        // 添加分割线
        topView.addSubview(lineView)
    }
    
    /** 点击背景遮罩图层事件 */
    @objc func didTapBackgroundView(sender: UITapGestureRecognizer) {
        
    }

    /** 取消按钮的点击事件 */
    @objc func clickLeftBtn() {
        
    }
    /** 确定按钮的点击事件 */
    @objc func clickRightBtn() {
        
    }
    
    func dismissWithAnimation() {
        // 关闭动画
        UIView.animate(withDuration: 0.2) {
            var rect = self.alertView.frame
            rect.origin.y += self.manager.kTopViewH + self.manager.kPickerViewH
            self.alertView.frame = rect
            self.backgroundView.alpha = 0
        } completion: { finished in
            self.removeFromSuperview()
        }
    }

    func showWithAnimation() {
        //1. 获取当前应用的主窗口
        guard let keyWindow = UIApplication.k_keyWindow else { return }
        keyWindow.addSubview(self)
        
        var rect = self.alertView.frame
        rect.origin.y = GConfig.ScreenH
        self.alertView.frame = rect
        
        UIView.animate(withDuration: 0.3) {
            var rect = self.alertView.frame
            rect.origin.y -= self.manager.kTopViewH + self.manager.kPickerViewH
            self.alertView.frame = rect
        }
    }
    
}

struct CicPickerConfig {
    
    var themeColor: UIColor = UIColor.systemBlue
    
    var kPickerViewH: CGFloat = 300
    var kTopViewH: CGFloat = 50
    /// 字体大小  默认15
    var pickerTitleSize: CGFloat  = 18
    /// 字体颜色  默认黑色
    var pickerTitleColor = UIColor.textBlack()
    /// 分割线颜色
    var lineViewColor = UIColor.white
    /// 中间标题颜色
    lazy var titleLabelColor = themeColor
    var titleSize: CGFloat = 16
    /// 中间标题背景颜色
    var titleLabelBGColor = UIColor.white
    
    var rightBtnTitle = "确定"
    lazy var rightBtnBGColor =  themeColor;
    var rightBtnTitleSize: CGFloat = 16
    var rightBtnTitleColor = UIColor.white
    
    lazy var rightBtnborderColor = themeColor
    var rightBtnCornerRadius: CGFloat = 6
    var rightBtnBorderWidth: CGFloat = 1
    
    var leftBtnTitle = "取消"
    lazy var leftBtnBGColor =  themeColor
    var leftBtnTitleSize: CGFloat = 16
    var leftBtnTitleColor = UIColor.white
    
    lazy var leftBtnborderColor = themeColor
    var leftBtnCornerRadius: CGFloat = 6
    var leftBtnBorderWidth: CGFloat = 1
}
