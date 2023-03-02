//
//  WaypointAttributeSection.swift
//  Woods
//
//  Created by Fredrik on 02.03.23.
//

import SwiftUI

struct WaypointAttributeSection: View {
    let attributes: [WaypointAttribute: Bool]
    
    var body: some View {
        SimpleSection {
            WaypointAttributeGridView(attributes: attributes)
        } header: {
            Label("Attributes", systemImage: "tag.fill")
        }
    }
}

struct WaypointAttributeSection_Previews: PreviewProvider {
    static var previews: some View {
        WaypointAttributeSection(attributes: [
            .motorcycles: true,
            .nightCache: true,
            .significantHike: false,
            .treeClimbing: false,
            .needsMaintenance: true,
            .teamworkRequired: true,
            .takesLessThanAnHour: true,
            .availableAtAllTimes: true,
            .uvLightRequired: true,
            .seasonalAccess: true,
            .touristFriendly: false
        ])
    }
}
