//
//  WaypointDatesSection.swift
//  Woods
//
//  Created by Fredrik on 02.03.23.
//

import SwiftUI

struct WaypointDatesSection: View {
    let waypoint: Waypoint
    
    var body: some View {
        let formatter = DateFormatter.standardDate()
        SimpleSection {
            if let placedAt = waypoint.placedAt {
                LabeledContent("Placed") {
                    Text(formatter.string(from: placedAt))
                }
            }
            if let lastFoundAt = waypoint.lastFoundAt {
                LabeledContent("Last Found") {
                    Text(formatter.string(from: lastFoundAt))
                }
            }
        } header: {
            Label("Dates", systemImage: "calendar")
        }
    }
}

struct WaypointDatesSection_Previews: PreviewProvider {
    static var previews: some View {
        WaypointDatesSection(waypoint: mockGeocaches()[0])
    }
}
