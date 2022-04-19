//
//  CoordinatesEditor.swift
//  Woods
//
//  Created by Fredrik on 19.04.22.
//

import SwiftUI

struct CoordinatesEditor: View {
    @Binding var coordinates: Coordinates
    
    var body: some View {
        VStack {
            CoordinateEditor<LatitudeCardinal>(degrees: $coordinates.latitude)
            CoordinateEditor<LongitudeCardinal>(degrees: $coordinates.longitude)
        }
    }
}

struct CoordinatesEditor_Previews: PreviewProvider {
    @State static var coordinates = Coordinates()
    static var previews: some View {
        Form {
            Section("Coordinates") {
                CoordinatesEditor(coordinates: $coordinates)
            }
        }
    }
}
