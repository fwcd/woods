//
//  EditWaypointView.swift
//  Woods
//
//  Created by Fredrik on 19.04.22.
//

import SwiftUI

struct EditWaypointView: View {
    @Binding var waypoint: Waypoint
    var onCommit: (() -> Void)? = nil
    
    var body: some View {
        Form {
            Section("Waypoint") {
                HStack(spacing: 20) {
                    // TODO: Add a picker here for choosing the cache type
                    Image(systemName: waypoint.iconName)
                        .foregroundColor(waypoint.color)
                        .font(.title)
                    VStack {
                        TextField("ID (e.g. GC-Code)", text: $waypoint.id)
                            .font(.headline)
                        Divider()
                        TextField("Name", text: $waypoint.name)
                            .font(.title2)
                    }
                }
            }
            
            Section("Coordinates") {
                // TODO: Factor out into view that binds a Coordinates
                // TODO: Let user edit in other formats (e.g. decimal minutes, DMS, ...)
                // TODO: Use numberPad keyboard
                
                TextField("Latitude", text: stringBinding(for: $waypoint.location.latitude))
                TextField("Longitude", text: stringBinding(for: $waypoint.location.longitude))
            }
            
            // TODO: Other metadata
            
            if let onCommit = onCommit {
                Button("Save Waypoint") {
                    onCommit()
                }
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
    @State private static var waypoint = Waypoint()
    static var previews: some View {
        EditWaypointView(waypoint: $waypoint)
    }
}
