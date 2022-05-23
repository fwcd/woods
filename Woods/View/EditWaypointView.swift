//
//  EditWaypointView.swift
//  Woods
//
//  Created by Fredrik on 19.04.22.
//

import SwiftUI

/// An 'editable' version of WaypointDetailView.
struct EditWaypointView: View {
    @Binding var waypoint: Waypoint
    var onCommit: (() -> Void)? = nil
    
    @State private var newAdditionalWaypoint = Waypoint()
    @State private var newAdditionalWaypointSheetShown = false {
        willSet {
            if newValue != newAdditionalWaypointSheetShown {
                newAdditionalWaypoint = Waypoint()
            }
        }
    }
    @State private var editedAdditionalWaypointIndex: Int = 0
    @State private var editAdditionalWaypointSheetShown: Bool = false
    
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
                CoordinatesEditor(coordinates: $waypoint.location)
            }
            
            Section("Info") {
                let range = Double(Waypoint.ratings.lowerBound)...Double(Waypoint.ratings.upperBound)
                HStack {
                    // TODO: Abstract out a common view, e.g. 'EditStarsView'
                    VStack {
                        StarsView(rating: waypoint.difficulty ?? 0, maxRating: Waypoint.ratings.upperBound, step: 2)
                        Slider(
                            value: roundingFloatBinding(for: unwrappingBinding(for: $waypoint.difficulty, defaultingTo: 0)),
                            in: range
                        )
                        Text("Difficulty")
                            .font(.caption)
                    }
                    VStack {
                        StarsView(rating: waypoint.terrain ?? 0, maxRating: Waypoint.ratings.upperBound, step: 2)
                        Slider(
                            value: roundingFloatBinding(for: unwrappingBinding(for: $waypoint.terrain, defaultingTo: 0)),
                            in: range
                        )
                        Text("Terrain")
                            .font(.caption)
                    }
                }
                .padding(.vertical, 10)
                
                // TODO: Cache size
            }
            
            Section("Description") {
                TextEditor(text: unwrappingBinding(for: $waypoint.description, defaultingTo: ""))
            }
            
            Section("Hint") {
                TextField("Hint", text: unwrappingBinding(for: $waypoint.hint, defaultingTo: ""))
            }
            
            Section("Additional Waypoints") {
                List {
                    ForEach(0..<waypoint.additionalWaypoints.count, id: \.self) { i in
                        Button {
                            editedAdditionalWaypointIndex = i
                            editAdditionalWaypointSheetShown = true
                        } label: {
                            WaypointSmallSnippetView(waypoint: waypoint.additionalWaypoints[i])
                        }
                    }
                    .onMove { indexSet, offset in
                        waypoint.additionalWaypoints.move(fromOffsets: indexSet, toOffset: offset)
                    }
                    .onDelete { indexSet in
                        waypoint.additionalWaypoints.remove(atOffsets: indexSet)
                    }
                    .sheet(isPresented: $editAdditionalWaypointSheetShown) {
                        CancelNavigationView(title: "Edit Additional Waypoint") {
                            editAdditionalWaypointSheetShown = false
                        } inner: {
                            EditWaypointView(waypoint: $waypoint.additionalWaypoints[editedAdditionalWaypointIndex]) {
                                editAdditionalWaypointSheetShown = false
                            }
                            .toolbar {
                                ToolbarItem(placement: .primaryAction) {
                                    Button("Done") {
                                        editAdditionalWaypointSheetShown = false
                                    }
                                }
                            }
                        }
                    }
                    let commitAdditionalWaypoint = {
                        newAdditionalWaypoint.generateIdIfEmpty()
                        waypoint.additionalWaypoints.append(newAdditionalWaypoint)
                        newAdditionalWaypointSheetShown = false
                    }
                    Button {
                        newAdditionalWaypointSheetShown = true
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add Waypoint...")
                        }
                    }
                    .sheet(isPresented: $newAdditionalWaypointSheetShown) {
                        CancelNavigationView(title: "New Additional Waypoint") {
                            newAdditionalWaypointSheetShown = false
                        } inner: {
                            EditWaypointView(waypoint: $newAdditionalWaypoint, onCommit: commitAdditionalWaypoint)
                                .toolbar {
                                    ToolbarItem(placement: .primaryAction) {
                                        Button("Save", action: commitAdditionalWaypoint)
                                    }
                                }
                        }
                    }
                }
            }
            
            // TODO: Other metadata
            
            if let onCommit = onCommit {
                Button("Save Waypoint") {
                    onCommit()
                }
            }
        }
    }
}

struct NewWaypointView_Previews: PreviewProvider {
    @State private static var waypoint = Waypoint()
    static var previews: some View {
        EditWaypointView(waypoint: $waypoint)
    }
}
