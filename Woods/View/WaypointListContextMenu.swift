//
//  WaypointListContextMenu.swift
//  Woods
//
//  Created by Fredrik on 05.01.22.
//  Copyright © 2022 Fredrik. All rights reserved.
//

import SwiftUI

struct WaypointListContextMenu: View {
    let list: WaypointList
    
    @EnvironmentObject private var waypoints: Waypoints
    
    var body: some View {
        Group {
            Button {
                waypoints.listTree.remove(list.id)
            } label: {
                Text("Delete")
                Image(systemName: "trash")
            }
        }
    }
}

struct WaypointListContextMenu_Previews: PreviewProvider {
    @StateObject static var waypoints = Waypoints(accounts: Accounts(testMode: true), lists: [
        WaypointList(name: "Child 1", waypoints: mockGeocaches())
    ])
    static var previews: some View {
        VStack {
            WaypointListContextMenu(list: waypoints.listTree.lists.values.first!)
        }
        .environmentObject(waypoints)
    }
}
