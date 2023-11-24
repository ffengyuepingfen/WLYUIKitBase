//
//  HTMLStringView.swift
//  jinrongjiagou
//
//  Created by Laowang on 2023/1/5.
//

import WebKit
import SwiftUI

struct HTMLStringView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: url))
    }
}
