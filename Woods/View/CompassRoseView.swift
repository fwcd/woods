//
//  CompassRoseView.swift
//  Woods
//
//  Created by Fredrik on 23.05.22.
//

import SwiftUI

struct CompassRoseView: View {
    var body: some View {
        ZStack {
            CompassRoseMarkers(markCount: 180)
                .stroke(lineWidth: 1)
            CompassRoseMarkers(markCount: 12)
                .stroke(lineWidth: 4)
            // TODO: Labels
        }
    }
}

struct CompassRoseView_Previews: PreviewProvider {
    static var previews: some View {
        CompassRoseView()
            .aspectRatio(1, contentMode: .fit)
    }
}
