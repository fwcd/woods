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
            // TODO: Let user edit in other formats (e.g. decimal minutes, DMS, ...)
            // TODO: Use numberPad keyboard
            
            TextField("Latitude", text: stringBinding(for: $coordinates.latitude))
            TextField("Longitude", text: stringBinding(for: $coordinates.longitude))
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
