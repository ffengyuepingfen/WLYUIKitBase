//
//  File.swift
//  
//
//  Created by Laowang on 2023/12/7.
//

import UIKit

public class CicStepTagView: UIView {
    
    let symbolConfig = UIImage.SymbolConfiguration(pointSize: 24)
    static let itemWidth: CGFloat = 34.0
    static let space: CGFloat = 1.0
    
    private lazy var reduce: UIButton = {
        let bb = UIButton(frame: CGRect(x: CicStepTagView.space, y: CicStepTagView.space, width: CicStepTagView.itemWidth, height: CicStepTagView.itemWidth))
        let image = UIImage(systemName: "minus.circle.fill")?.withRenderingMode(.alwaysTemplate).withConfiguration(symbolConfig)
        bb.setImage(image, for: .normal)
        bb.setImage(image, for: .highlighted)
        bb.tintColor = UIColor.systemRed
        bb.addTarget(self, action: #selector(reduceAction), for: .touchUpInside)
        return bb
    }()
    
    private lazy var inputTextView: UILabel = {
        let bb = UILabel(frame: CGRect(x: CicStepTagView.space*2 + CicStepTagView.itemWidth, y: CicStepTagView.space, width: CicStepTagView.itemWidth*2, height: CicStepTagView.itemWidth))
        bb.text = "1"
        bb.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        bb.textAlignment = .center
        return bb
    }()
    
    private lazy var increase: UIButton = {
        let bb = UIButton(frame: CGRect(x: CicStepTagView.space*3 + CicStepTagView.itemWidth*3, y: CicStepTagView.space, width: CicStepTagView.itemWidth, height: CicStepTagView.itemWidth))
        let image = UIImage(systemName: "plus.circle.fill")?.withRenderingMode(.alwaysTemplate).withConfiguration(symbolConfig)
        bb.setImage(image, for: .normal)
        bb.setImage(image, for: .highlighted)
        bb.tintColor = UIColor.systemGreen
        bb.addTarget(self, action: #selector(increaseAction), for: .touchUpInside)
        return bb
    }()
    
    private var callBack:(((NSInteger))-> Void)!
    
    private var maxCount = 999
    
    private var minCount = 1
    
    private var currentCount = 1 {
        didSet {
            inputTextView.text = "\(currentCount)"
        }
    }
    
    private var initialValue = 1
    
    public init(origin: CGPoint = CGPoint(x: 0, y: 0), initial: NSInteger = 1, max: NSInteger = 999, min: NSInteger = 1, callBack:@escaping (((NSInteger))-> Void)) {
        let height = CicStepTagView.itemWidth + CicStepTagView.space*2
        let width = CicStepTagView.itemWidth*4 + CicStepTagView.space*4
        super.init(frame: CGRect(x: origin.x, y: origin.y, width: width, height: height))
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.callBack = callBack
        self.maxCount = max
        self.minCount = min
        self.initialValue = initial
        self.currentCount = initial
        self.inputTextView.text = "\(currentCount)"
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        addSubview(reduce)
        addSubview(inputTextView)
        addSubview(increase)
    }
    /// 加一
    @objc private func increaseAction() {
        if currentCount == maxCount {
            PumpkinHUD.showMessage("不能大于\(maxCount)")
            return
        }
        currentCount += 1
        callBack(currentCount)
    }
    
    @objc private func reduceAction() {
        
        if currentCount == minCount {
            PumpkinHUD.showMessage("不能小于\(minCount)")
            return
        }
        currentCount -= 1
        callBack(currentCount)
    }
}
