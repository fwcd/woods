//
//  GeocacheDetailView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import SwiftUI

struct WaypointDetailView: View {
    let waypoint: Waypoint
    
    var body: some View {
        VStack(alignment: .leading) {
            WaypointSnippetView(waypoint: waypoint)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            Form {
                Section(header: Text("Info")) {
                    Text(waypoint.location.description)
                    HStack {
                        Image(systemName: "chart.bar.fill")
                        StarsView(
                            rating: waypoint.difficulty ?? 0,
                            maxRating: Waypoint.ratings.upperBound,
                            step: 2
                        )
                        Divider()
                        Image(systemName: "leaf.fill")
                        StarsView(
                            rating: waypoint.terrain ?? 0,
                            maxRating: Waypoint.ratings.upperBound,
                            step: 2
                        )
                    }
                }
                if let description = waypoint.description {
                    Section(header: Text("Description")) {
                        Text(description)
                    }
                }
                if let hint = waypoint.hint {
                    Section(header: Text("Hint")) {
                        Text(hint)
                    }
                }
                if !waypoint.logs.isEmpty {
                    Section(header: Text("Logs")) {
                        List(waypoint.logs) { log in
                            WaypointLogView(waypointLog: log)
                        }
                    }
                }
            }
        }
    }
}

struct GeocacheDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WaypointDetailView(waypoint: mockGeocaches().first!)
    }
}
