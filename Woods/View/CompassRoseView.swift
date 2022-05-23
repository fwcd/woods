//
//  CompassRoseView.swift
//  Woods
//
//  Created by Fredrik on 23.05.22.
//

import SwiftUI

struct CompassRoseView: View {
    var heading: Degrees = .zero
    
    var body: some View {
        ZStack {
            CompassRoseMarkers(heading: heading, markCount: 180)
                .stroke(lineWidth: 1)
            CompassRoseMarkers(heading: heading, markCount: 12)
                .stroke(lineWidth: 4)
            // TODO: Labels
            Text(heading.shortDescription)
                .font(.system(size: 48))
        }
    }
}

struct CompassRoseView_Previews: PreviewProvider {
    static var previews: some View {
        CompassRoseView(heading: .init(degrees: 30))
            .aspectRatio(1, contentMode: .fit)
    }
}
