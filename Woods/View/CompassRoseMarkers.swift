//
//  CompassRoseMarkers.swift
//  Woods
//
//  Created by Fredrik on 23.05.22.
//

import SwiftUI

struct CompassRoseMarkers: Shape {
    var heading: Degrees = .zero
    var markCount: Int = 180
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let headingRadians = heading.totalRadians
        let size = rect.size
        let stride = 2 * .pi / CGFloat(markCount)
        let markLength = (size.width + size.height) / 20
        
        for i in 0..<markCount {
            let angle = CGFloat(i) * stride - headingRadians
            let outerRadiusX = size.width / 2
            let outerRadiusY = size.height / 2
            let innerRadiusX = outerRadiusX - markLength
            let innerRadiusY = outerRadiusY - markLength
            let baseX = cos(angle)
            let baseY = sin(angle)
            
            path.move(to: CGPoint(
                x: rect.midX + baseX * outerRadiusX,
                y: rect.midY + baseY * outerRadiusY
            ))
            path.addLine(to: CGPoint(
                x: rect.midX + baseX * innerRadiusX,
                y: rect.midY + baseY * innerRadiusY
            ))
            path.closeSubpath()
        }
        
        return path
    }
}

struct CompassRoseMarkers_Previews: PreviewProvider {
    static var previews: some View {
        CompassRoseMarkers()
            .stroke(lineWidth: 2)
            .aspectRatio(1, contentMode: .fit)
    }
}
