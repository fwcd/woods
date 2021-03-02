//
//  WaypointListView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import SwiftUI

struct WaypointListView: View {
    let listId: UUID
    var largeTitle: Bool = true
    let showNewItemSheet: (UUID) -> Void
    
    @EnvironmentObject private var waypoints: Waypoints
    
    var list: WaypointList {
        waypoints.lists[listId]!
    }
    
    var body: some View {
        List {
            ForEach(list.childs, id: \.self) { childId in
                if let child = waypoints.lists[childId] {
                    NavigationLink(destination: WaypointListView(listId: childId, largeTitle: false, showNewItemSheet: showNewItemSheet)) {
                        WaypointListSnippetView(list: child)
                    }
                }
            }
            ForEach(list.waypoints) { waypoint in
                NavigationLink(destination: WaypointDetailView(waypoint: waypoint)) {
                    WaypointSmallSnippetView(waypoint: waypoint)
                }
            }
        }
        .navigationTitle(list.name)
        .navigationBarTitleDisplayMode(largeTitle ? .large : .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showNewItemSheet(listId) }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct WaypointListView_Previews: PreviewProvider {
    @StateObject static var waypoints = Waypoints(accounts: Accounts(testMode: true), lists: [
        WaypointList(name: "Child 1", waypoints: mockGeocaches()),
        WaypointList(name: "Child 2")
    ])
    static var previews: some View {
        NavigationView {
            WaypointListView(listId: waypoints.rootListId) { _ in }
                .environmentObject(waypoints)
        }
    }
}
