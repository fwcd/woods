//
//  WaypointSnippetView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import SwiftUI

struct WaypointSnippetView: View {
    let waypoint: Waypoint
    
    var body: some View {
        HStack {
            Image(systemName: waypoint.iconName)
                .foregroundColor(waypoint.color)
                .font(.title)
            VStack(alignment: .leading) {
                Text(waypoint.id)
                    .font(.headline)
                Text(waypoint.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

struct WaypointSnippetView_Previews: PreviewProvider {
    static var previews: some View {
        WaypointSnippetView(waypoint: mockGeocaches().first!)
    }
}
