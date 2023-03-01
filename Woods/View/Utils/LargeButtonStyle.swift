//
//  LargeButtonStyle.swift
//  Woods
//
//  Created by Fredrik on 3/3/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

struct LargeButtonStyle: ButtonStyle {
    var radius: CGFloat = 5
    var padding: CGFloat = 12
    var color: Color = .accentColor
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(padding)
            .foregroundColor(.white)
            .background(configuration.isPressed ? color.opacity(0.4) : color.opacity(0.7))
            .cornerRadius(radius)
    }
}

struct LargeButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("Test") {
        }
        .buttonStyle(LargeButtonStyle())
    }
}
