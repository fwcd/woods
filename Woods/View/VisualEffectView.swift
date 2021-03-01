//
//  VisualEffectView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//

import SwiftUI
import UIKit

struct VisualEffectView: UIViewRepresentable {
    let effect: UIVisualEffect
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: effect)
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = effect
    }
}
