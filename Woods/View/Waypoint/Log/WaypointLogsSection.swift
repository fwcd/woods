//
//  WaypointLogsSection.swift
//  Woods
//
//  Created by Fredrik on 02.03.23.
//

import SwiftUI

struct WaypointLogsSection: View {
    let waypoint: Waypoint
    
    var body: some View {
        SimpleSection {
            WaypointLogsView(waypoint: waypoint)
                .frame(maxWidth: .infinity)
        } header: {
            Label("Logs", systemImage: "book.closed.fill")
        }
    }
}

struct WaypointLogsSection_Previews: PreviewProvider {
    static var previews: some View {
        WaypointLogsSection(waypoint: mockGeocaches()[0])
    }
}
