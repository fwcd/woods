//
//  CompassRoseView.swift
//  Woods
//
//  Created by Fredrik on 23.05.22.
//

import SwiftUI

struct CompassRoseView: View {
    var body: some View {
        CompassRoseMarkers()
            .stroke(lineWidth: 2)
    }
}

struct CompassRoseView_Previews: PreviewProvider {
    static var previews: some View {
        CompassRoseView()
            .aspectRatio(1, contentMode: .fit)
    }
}
