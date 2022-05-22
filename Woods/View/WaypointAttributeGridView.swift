//
//  WaypointAttributeGridView.swift
//  Woods
//
//  Created by Fredrik on 22.05.22.
//

import SwiftUI

struct WaypointAttributeGridView: View {
    let attributes: [WaypointAttribute: Bool]
    
    var body: some View {
        HStack {
            ForEach(attributes.keys.sorted { $0.rawValue < $1.rawValue }, id: \.self) { attribute in
                WaypointAttributeView(attribute: attribute, isEnabled: attributes[attribute]!)
            }
        }
    }
}

struct WaypointAttributeGridView_Previews: PreviewProvider {
    static var previews: some View {
        WaypointAttributeGridView(attributes: [
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
