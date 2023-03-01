//
//  WaypointAttributeGridView.swift
//  Woods
//
//  Created by Fredrik on 22.05.22.
//

import SwiftUI
import FlowStackLayout

struct WaypointAttributeGridView: View {
    let attributes: [WaypointAttribute: Bool]
    
    var body: some View {
        let spacing: CGFloat = 8
        let keys = attributes.keys
            .sorted { $0.rawValue < $1.rawValue }
        FlowStack(
            horizontalSpacing: spacing,
            verticalSpacing: spacing
        ) {
            ForEach(
                keys,
                id: \.self
            ) { attribute in
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
