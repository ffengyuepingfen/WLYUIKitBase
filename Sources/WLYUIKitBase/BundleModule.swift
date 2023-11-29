//
//  File.swift
//  
//
//  Created by Laowang on 2023/4/4.
//

import Foundation

private class BundleFinder {}

extension Foundation.Bundle {
    
    static let i18n: Bundle = {
        let bundleName = "WLYUIKitBase_WLYUIKitBase"
        let bundleResourceURL = Bundle(for: BundleFinder.self).resourceURL
        let candidates = [
            Bundle.main.resourceURL,
            bundleResourceURL,
            Bundle.main.bundleURL,
            // Bundle should be present here when running previews from a different package "…/Debug-iphonesimulator/"
            bundleResourceURL?.deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent(),
            bundleResourceURL?.deletingLastPathComponent().deletingLastPathComponent(),
            // other Package
            bundleResourceURL?.deletingLastPathComponent()
        ]
        
        for candidate in candidates {
            // 对于非 mac 苹果，可以需要使用 resources 尾缀
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        fatalError("unable to find bundle named \(bundleName)")
    }()
}
