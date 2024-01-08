//
//  File.swift
//  
//
//  Created by Laowang on 2023/11/24.
//

import UIKit

extension UITextField {
    
    public static func inputTextView(textContentType: UITextContentType = .emailAddress,
                              keyboardType: UIKeyboardType = .emailAddress,
                              placeholder: String,
                              image: UIImage? = nil,
                              isSecure: Bool = false) -> UITextField {
        let input = UITextField()
        input.backgroundColor = UIColor.systemBackground
        input.placeholder = placeholder
        input.keyboardType = keyboardType
        input.textContentType = textContentType
        input.autocapitalizationType = .none
        input.autocorrectionType = .no
        input.font = UIFont.systemFont(ofSize: 16.0)
        input.isSecureTextEntry = isSecure

        let imageView = UIImageView(frame: CGRect(x: 16, y: 14, width: 15, height: 16))
        imageView.image = image
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        leftView.addSubview(imageView)
        input.leftView = leftView
        input.leftViewMode = .always
        input.heightAnchor.constraint(equalToConstant: 44).isActive = true
//        input.layer.borderColor = UIColor.AccentColor().cgColor
//        input.layer.borderWidth = 1.0
        input.layer.cornerRadius = 10
        return input
    }
    
    
    public static func titleInputTextView(textContentType: UITextContentType = .emailAddress,
                              keyboardType: UIKeyboardType = .emailAddress,
                              placeholder: String,
                              name: String,
                              isSecure: Bool = false) -> UITextField {
        let input = UITextField()
        input.backgroundColor = UIColor.systemBackground
        input.placeholder = placeholder
        input.keyboardType = keyboardType
        input.textContentType = textContentType
        input.autocapitalizationType = .none
        input.autocorrectionType = .no
        input.font = UIFont.systemFont(ofSize: 16.0)
        input.isSecureTextEntry = isSecure

        let label = UILabel.footnote(name)
        label.frame = CGRect(x: 12, y: 7, width: 98, height: 28)
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 110, height: 44))
        leftView.addSubview(label)
        input.leftView = leftView
        input.leftViewMode = .always
        input.heightAnchor.constraint(equalToConstant: 44).isActive = true
//        input.layer.borderColor = UIColor.AccentColor().cgColor
//        input.layer.borderWidth = 1.0
        input.layer.cornerRadius = 10
        return input
    }
    
    
}
