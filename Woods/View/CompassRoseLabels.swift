//
//  CompassRoseLabels.swift
//  Woods
//
//  Created by Fredrik on 23.05.22.
//

import SwiftUI

struct CompassRoseLabels: View {
    var heading: Degrees = .zero
    var labelCount: Int = 12
    var scaling: CGFloat = 0.8
    
    var body: some View {
        let headingRadians = heading.totalRadians
        let strideDeg = 360 / labelCount
        let stride = 2 * .pi / CGFloat(labelCount)
        GeometryReader { geometry in
            let size = geometry.size
            let offsetX = size.width / 2
            let offsetY = size.height / 2
            let radius = scaling * min(size.width, size.height) / 2
            ZStack {
                ForEach(0..<labelCount, id: \.self) { i in
                    let angle = stride * CGFloat(i) - headingRadians - .pi / 2
                    let baseX = cos(angle)
                    let baseY = sin(angle)
                    Text("\(i * strideDeg)°")
                        .position(x: offsetX + baseX * radius, y: offsetY + baseY * radius)
                }
            }
        }
    }
}

struct CompassRoseLabels_Previews: PreviewProvider {
    static var previews: some View {
        CompassRoseLabels()
    }
}
