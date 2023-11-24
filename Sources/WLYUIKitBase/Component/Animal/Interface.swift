//
//  File.swift
//  
//
//  Created by Laowang on 2023/5/15.
//

import UIKit

public struct Interface {
    public var name: String
    public var icon: UIImage
    public var color: UIColor
    public var type: InterfaceViewController.Type
}

extension Interface {
    
    public static var all: [Interface] {
        return [
            Interface(name: "Calculator button", icon: #imageLiteral(resourceName: "icon_calc"), color: UIColor(hex: 0x999999), type: CalculatorButtonInterfaceViewController.self),
            Interface(name: "Spring animations", icon: #imageLiteral(resourceName: "icon_spring"), color: UIColor(hex: 0x64CCF7), type: SpringInterfaceViewController.self),
            Interface(name: "Flashlight button", icon: #imageLiteral(resourceName: "icon_flash"), color: UIColor(hex: 0xEDEDED), type: FlashlightButtonInterfaceViewController.self),
            Interface(name: "Rubberbanding", icon: #imageLiteral(resourceName: "icon_rubber"), color: UIColor(hex: 0xFF5B50), type: RubberbandingInterfaceViewController.self),
            Interface(name: "Acceleration pausing", icon: #imageLiteral(resourceName: "icon_acceleration"), color: UIColor(hex: 0x64FF8F), type: AccelerationInterfaceViewController.self),
            Interface(name: "Rewarding momentum", icon: #imageLiteral(resourceName: "icon_momentum"), color: UIColor(hex: 0x73B2FF), type: MomentumInterfaceViewController.self),
            Interface(name: "FaceTime PiP", icon: #imageLiteral(resourceName: "icon_pip"), color: UIColor(hex: 0xF2F23A), type: PipInterfaceViewController.self),
            Interface(name: "Rotation", icon: #imageLiteral(resourceName: "icon_rotation"), color: UIColor(hex: 0xFF28A5), type: RotationInterfaceViewController.self),
        ]
    }
    
}
