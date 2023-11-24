//
//  File.swift
//  
//
//  Created by Laowang on 2023/5/15.
//

import UIKit

/// Base class for all interface view controllers.
public class InterfaceViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(white: 0.05, alpha: 1) // reduces screen tearing on iPhone X
        navigationItem.largeTitleDisplayMode = .never
        
    }
    
}
