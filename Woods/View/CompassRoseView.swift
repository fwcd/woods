//
//  CompassRoseView.swift
//  Woods
//
//  Created by Fredrik on 23.05.22.
//

import SwiftUI

struct CompassRoseView: View {
    var radius: CGFloat = 200
    var markCount: Int = 180
    var markLength: CGFloat? = nil
    var markThickness: CGFloat = 1
    
    var body: some View {
        Path { path in
            let stride = 2 * .pi / CGFloat(markCount)
            let markLength = markLength ?? (radius / 10)
            
            for i in 0..<markCount {
                let angle = CGFloat(i) * stride
                let outerRadius = radius
                let innerRadius = radius - markLength
                let baseX = cos(angle)
                let baseY = sin(angle)
                
                path.move(to: CGPoint(x: baseX * outerRadius, y: baseY * outerRadius))
                path.addLine(to: CGPoint(x: baseX * innerRadius, y: baseY * innerRadius))
                path.closeSubpath()
            }
        }
        .stroke(lineWidth: markThickness)
    }
}

struct CompassRoseView_Previews: PreviewProvider {
    static var previews: some View {
        CompassRoseView()
    }
}
