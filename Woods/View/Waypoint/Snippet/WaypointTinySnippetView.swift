//
//  WaypointTinySnippetView.swift
//  Woods
//
//  Created on 07.03.23
//

import SwiftUI

struct WaypointTinySnippetView: View {
    let waypoint: Waypoint
    
    var body: some View {
        Label {
            Text(waypoint.displayName)
        } icon: {
            Image(systemName: waypoint.iconName)
                .foregroundColor(waypoint.color)
        }
    }
}

struct WaypointTinySnippetView_Previews: PreviewProvider {
    static var previews: some View {
        WaypointTinySnippetView(waypoint: mockGeocaches().first!)
    }
}
