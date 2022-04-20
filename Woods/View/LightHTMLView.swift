//
//  LightHTMLView.swift
//  Woods
//
//  Created by Fredrik on 3/3/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI
import SwiftSoup

struct LightHTMLView: View {
    let html: String
    
    var body: some View {
        let text = (try? SwiftSoup.parseBodyFragment(html)).flatMap { try? $0.text() } ?? html
        Text(text)
            .multilineTextAlignment(.leading)
            .textSelection(.enabled)
    }
}
