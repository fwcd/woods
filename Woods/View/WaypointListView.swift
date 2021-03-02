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
    
    @State private var newListSheetShown: Bool = false
    @State private var newWaypointSheetShown: Bool = false
    @EnvironmentObject private var waypoints: Waypoints
    
    var list: WaypointList {
        waypoints.lists[listId]!
    }
    
    var body: some View {
        List {
            Button(action: { newListSheetShown = true }) {
                HStack {
                    Image(systemName: "plus")
                    Text("New List")
                }
            }
            .sheet(isPresented: $newListSheetShown) {
                NewWaypointListView { child in
                    waypoints.lists[child.id] = child
                    waypoints.lists[listId]!.childs.append(child.id)
                    newListSheetShown = false
                }
                .padding(20)
            }
            Button(action: { newWaypointSheetShown = true }) {
                HStack {
                    Image(systemName: "plus")
                    Text("New Waypoint")
                }
            }
            ForEach(list.childs, id: \.self) { childId in
                if let child = waypoints.lists[childId] {
                    NavigationLink(destination: WaypointListView(listId: childId, largeTitle: false)) {
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
    }
}

struct WaypointListView_Previews: PreviewProvider {
    @StateObject static var waypoints = Waypoints(accounts: Accounts(testMode: true), lists: [
        WaypointList(name: "Child 1", waypoints: mockGeocaches()),
        WaypointList(name: "Child 2")
    ])
    static var previews: some View {
        NavigationView {
            WaypointListView(listId: waypoints.rootListId)
                .environmentObject(waypoints)
        }
    }
}
