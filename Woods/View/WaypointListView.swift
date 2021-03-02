//
//  WaypointListView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import SwiftUI

struct WaypointListView: View {
    let list: WaypointList
    
    var body: some View {
        List {
            ForEach(list.childs) { child in
                WaypointListSnippetView(list: child)
            }
            ForEach(list.waypoints) { waypoint in
                WaypointSmallSnippetView(waypoint: waypoint)
            }
        }
    }
}

struct WaypointListView_Previews: PreviewProvider {
    static var previews: some View {
        let caches = mockGeocaches()
        WaypointListView(list: WaypointList(
            name: "Root",
            childs: [
                WaypointList(name: "Child 1", waypoints: Array(caches[1...])),
                WaypointList(name: "Child 2")
            ],
            waypoints: [
                caches[0]
            ]
        ))
    }
}
