//
//  EmptyStateView.swift
//  StateView
//
//  Created by Alberto Aznar de los Ríos on 23/05/2019.
//  Copyright © 2019 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

class EmptyStateView: UIView {

    lazy var messageView: UIView = {
        let vv = UIView()
//        vv.backgroundColor = UIColor.clear
        return vv
    }()
    
    lazy var imageView: UIImageView = {
        let vv = UIImageView()
        vv.contentMode = .scaleAspectFit
        return vv
    }()
    
    lazy var titleLabel: UILabel = {
        let tt = UILabel()
        return tt
    }()
    
    lazy var descriptionLabel: UILabel = {
        let tt = UILabel()
        return tt
    }()
    
    lazy var primaryButton: UIButton = {
        let b = UIButton()
        b.layer.cornerRadius = 20
        b.addTarget(self, action: #selector(didPressPrimaryButton), for: .touchUpInside)
        return b
    }()
    
    struct ViewModel {
        var image: UIImage?
        var title: String?
        var description: String?
        var titleButton: String?
    }
    
    var viewModel = ViewModel() {
        didSet { fillView() }
    }
    
    var format = EmptyStateFormat() {
        didSet { updateUI() }
    }
    
    var actionButton: ((UIButton)->())?
    
    private var gradientLayer: CAGradientLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didPressPrimaryButton(sender: UIButton) {
        actionButton?(sender)
    }
}

extension EmptyStateView {
    
    private func setUpView() {
        
        self.addSubviewAnchor(subView: messageView, insets: UIEdgeInsets.userDefine(horizontal: 16, vertical: 130))
        
        let vStack = VStack(spacing: 16, alignment: .center)
        vStack.addArrangedSubviews([imageView, titleLabel, descriptionLabel, vStack.spacer(), primaryButton]) {
            imageView.sizeConstraint = CGSize(width: 200, height: 200)
            titleLabel.heightConstraint = 44
            descriptionLabel.heightConstraint = 38
            primaryButton.sizeConstraint = CGSize(width: 128, height: 40)
        }
        
        messageView.addSubviewAnchor(subView: vStack, insets: UIEdgeInsets.sixteen)
    }
    
    private func fillView() {
        
        imageView.image = viewModel.image

        if let title = viewModel.title {
            titleLabel.isHidden = false
            titleLabel.attributedText = NSAttributedString(string: title, attributes: format.titleAttributes)
        } else {
            titleLabel.isHidden = true
        }

        if let description = viewModel.description {
            descriptionLabel.isHidden = false
            descriptionLabel.attributedText = NSAttributedString(string: description, attributes: format.descriptionAttributes)
        } else {
            descriptionLabel.isHidden = true
        }

        if let titleButton = viewModel.titleButton {
            primaryButton.isHidden = false
            primaryButton.setAttributedTitle(NSAttributedString(string: titleButton, attributes: format.buttonAttributes), for: .normal)
        } else {
            primaryButton.isHidden = true
        }
    }
    
    private func updateUI() {
        
        imageView.isHidden = false
        if let imageTintColor = format.imageTintColor {
            imageView.tintColor = imageTintColor
        } else {
            imageView.tintColor = .systemBlue
        }

        // Primary button format
        primaryButton.backgroundColor = format.buttonColor
        primaryButton.layer.shadowColor = format.buttonColor.cgColor
        primaryButton.layer.shadowOffset = CGSize(width: 0.0, height: 0)
        primaryButton.layer.masksToBounds = false
        primaryButton.layer.shadowOpacity = 0.5
        
        // Message format
        messageView.alpha = format.alpha
        
        // Background format
        backgroundColor = format.backgroundColor
        
        // Background gradient format
        if let gradientColor = format.gradientColor {
            gradientLayer?.removeFromSuperlayer()
            gradientLayer = CAGradientLayer()
            gradientLayer?.colors = [gradientColor.0.cgColor, gradientColor.1.cgColor]
            gradientLayer?.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer?.endPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer?.locations = [0, 1]
            gradientLayer?.frame = bounds
            layer.insertSublayer(gradientLayer!, at: 0)
        } else {
            gradientLayer?.removeFromSuperlayer()
        }
    }
    
}

extension EmptyStateView {
    
    func play() {
        format.animation?.play?(self)
    }
}
