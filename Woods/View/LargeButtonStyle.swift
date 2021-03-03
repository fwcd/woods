//
//  LargeButtonStyle.swift
//  Woods
//
//  Created by Fredrik on 3/3/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import SwiftUI

struct LargeButtonStyle: ButtonStyle {
    var radius: CGFloat = 5
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(12)
            .foregroundColor(.white)
            .background(configuration.isPressed ? Color.blue.opacity(0.5) : Color.blue)
            .cornerRadius(radius)
    }
}

struct LargeButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {}) {
            Text("Test")
        }
        .buttonStyle(LargeButtonStyle())
    }
}
