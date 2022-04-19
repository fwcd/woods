//
//  EditWaypointView.swift
//  Woods
//
//  Created by Fredrik on 19.04.22.
//

import SwiftUI

struct EditWaypointView: View {
    let onCommit: (Waypoint) -> Void
    
    @State private var waypoint = Waypoint(
        id: "",
        name: "",
        location: Coordinates(latitude: 0, longitude: 0)
    )
    
    var body: some View {
        Form {
            Section("Waypoint") {
                TextField("ID (e.g. GC-Code)", text: $waypoint.id)
                TextField("Name", text: $waypoint.id)
            }
            
            Section("Coordinates") {
                // TODO: Factor out into view that binds a Coordinates
                // TODO: Let user edit in other formats (e.g. decimal minutes, DMS, ...)
                // TODO: Use numberPad keyboard
                
                TextField("Latitude", text: stringBinding(for: $waypoint.location.latitude))
                TextField("Longitude", text: stringBinding(for: $waypoint.location.longitude))
            }
            
            // TODO: Other metadata
            
            Button("Save Waypoint") {
                onCommit(waypoint)
            }
        }
    }
    
    private func stringBinding(for binding: Binding<Degrees>) -> Binding<String> {
        Binding(
            get: { String(binding.wrappedValue.totalDegrees) },
            set: {
                if let degrees = Double($0).map(Degrees.init(degrees:)) {
                    binding.wrappedValue = degrees
                }
            }
        )
    }
}

struct NewWaypointView_Previews: PreviewProvider {
    static var previews: some View {
        EditWaypointView { _ in }
    }
}
