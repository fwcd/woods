//
//  WaypointRouteView.swift
//  Woods
//
//  Created by Fredrik on 05.03.23.
//

import SwiftUI

struct WaypointRouteView: View {
    let route: WaypointRoute
    
    var body: some View {
        switch route {
        case .list(let listId):
            WaypointListView(listId: listId, largeTitle: false)
        case .waypoint(let waypoint):
            ScrollView {
                WaypointDetailView(waypoint: waypoint)
            }
        }
    }
}
