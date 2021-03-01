//
//  Handle.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//

import SwiftUI
import UIKit

// Source: https://www.mozzafiller.com/posts/swiftui-slide-over-card-like-maps-stocks

struct Handle: View {
    var handleThickness = CGFloat(5.0)
    
    var body: some View {
        RoundedRectangle(cornerRadius: handleThickness / 2.0)
            .frame(width: 40, height: handleThickness)
            .foregroundColor(Color.secondary)
            .padding(5)
    }
}
