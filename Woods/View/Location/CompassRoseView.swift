//
//  CompassRoseView.swift
//  Woods
//
//  Created by Fredrik on 23.05.22.
//

import SwiftUI

struct CompassRoseView: View {
    var heading: Degrees = .zero
    var markCount: Int = 12
    var roseScale: CGFloat = 0.6
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ZStack {
                Group {
                    CompassRoseMarkers(heading: heading, markCount: 180)
                        .stroke(lineWidth: 1)
                    CompassRoseMarkers(heading: heading, markCount: markCount)
                        .stroke(lineWidth: 4)
                }
                .frame(width: size.width * roseScale, height: size.height * roseScale)
                CompassRoseLabels(heading: heading, labelCount: markCount)
                // TODO: Labels
                Text(heading.shortDescription)
                    .font(.system(size: 48))
            }
        }
    }
}

struct CompassRoseView_Previews: PreviewProvider {
    static var previews: some View {
        CompassRoseView(heading: .init(degrees: 30))
            .aspectRatio(1, contentMode: .fit)
    }
}
