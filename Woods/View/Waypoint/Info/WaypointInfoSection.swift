//
//  WaypointInfoSection.swift
//  Woods
//
//  Created by Fredrik on 02.03.23.
//

import SwiftUI

struct WaypointInfoSection: View {
    let waypoint: Waypoint
    
    var body: some View {
        SimpleSection {
            WaypointInfoView(waypoint: waypoint)
        } header: {
            Label("Info", systemImage: "paperclip")
        }
    }
}

struct WaypointDetailInfoSection_Previews: PreviewProvider {
    static var previews: some View {
        WaypointInfoSection(waypoint: mockGeocaches()[0])
    }
}
