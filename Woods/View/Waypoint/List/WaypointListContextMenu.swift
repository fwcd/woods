//
//  WaypointListContextMenu.swift
//  Woods
//
//  Created by Fredrik on 05.01.22.
//  Copyright © 2022 Fredrik.
//

import SwiftUI

struct WaypointListContextMenu: View {
    let listId: UUID
    
    @EnvironmentObject private var waypoints: Waypoints
    
    var body: some View {
        Group {
            Button {
                waypoints.listTree.remove(listId)
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
            WaypointListContextMenu(listId: waypoints.listTree.lists.values.first!.id)
        }
        .environmentObject(waypoints)
    }
}
