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
        if let document = try? SwiftSoup.parseBodyFragment(html), let text = try? document.text() {
            Text(text)
                .multilineTextAlignment(.leading)
        } else {
            Text(html)
                .multilineTextAlignment(.leading)
        }
    }
}
