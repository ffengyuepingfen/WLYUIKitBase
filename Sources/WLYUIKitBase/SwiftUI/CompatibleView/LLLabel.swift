//
//  LLLabel.swift
//
//
//  Created by Laowang on 2024/1/10.
//

import SwiftUI

public struct LLLabel: View {
    let title: String
    let name: String
    public var body: some View {
        if #available(iOS 14, *) {
            // 在 iOS 14 或更高版本上可用的 API
            Label(title, systemImage: name)
        } else {
            // 在 iOS 13 以下版本上的备用方案
            HStack {
                Image(systemName: name)
                Text(title)
            }
        }
    }
    public init(_ title: String, systemImage name: String) {
        self.title = title
        self.name = name
    }
}

#Preview {
    LLLabel("ceshi", systemImage: "location.fill")
}
