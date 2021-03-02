//
//  WaypointListsView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import SwiftUI

struct WaypointListsView: View {
    @EnvironmentObject private var waypoints: Waypoints
    
    var body: some View {
        NavigationView {
            WaypointListView(listId: waypoints.rootListId)
        }
    }
}

struct WaypointListsView_Previews: PreviewProvider {
    @StateObject static var waypoints = Waypoints(accounts: Accounts(testMode: true))
    static var previews: some View {
        WaypointListsView()
            .environmentObject(waypoints)
    }
}
