//
//  WebHTMLView.swift
//  Woods
//
//  Created by Fredrik on 3/3/21.
//  Copyright © 2021 Fredrik.
//

import WebKit
import SwiftUI

struct WebHTMLView: UIViewRepresentable {
    let html: String
    
    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = false
        view.configuration.defaultWebpagePreferences = prefs
        view.loadHTMLString(html, baseURL: nil)
        return view
    }
    
    func updateUIView(_ view: WKWebView, context: Context) {
        view.loadHTMLString(html, baseURL: nil)
    }
}
