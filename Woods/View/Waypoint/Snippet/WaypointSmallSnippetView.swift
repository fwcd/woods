//
//  WaypointSmallSnippetView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

struct WaypointSmallSnippetView: View {
    let waypoint: Waypoint
    
    var body: some View {
        Label {
            VStack(alignment: .leading) {
                Text(waypoint.name)
                    .font(.headline)
                Text(waypoint.location.description)
                    .font(.subheadline)
            }
        } icon: {
            Image(systemName: waypoint.iconName)
                .foregroundColor(waypoint.color)
        }
    }
}

struct WaypointSmallSnippetView_Previews: PreviewProvider {
    static var previews: some View {
        WaypointSmallSnippetView(waypoint: mockGeocaches().first!)
    }
}
