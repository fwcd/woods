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
    
    @State private var newItemSheetShown: Bool = false
    @State private var newListSheetShown: Bool = false
    @State private var newWaypointSheetShown: Bool = false
    @EnvironmentObject private var waypoints: Waypoints
    
    var list: WaypointList {
        waypoints.lists[listId]!
    }
    
    var body: some View {
        List {
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
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { newItemSheetShown = true }) {
                    Image(systemName: "plus")
                }
            }
        }
        .actionSheet(isPresented: $newItemSheetShown) {
            ActionSheet(
                title: Text("New Item"),
                buttons: [
                    .default(Text("New Waypoint")) {
                        newWaypointSheetShown = true
                    },
                    .default(Text("New List")) {
                        newListSheetShown = true
                    },
                    .cancel()
                ]
            )
        }
        .sheet(isPresented: $newListSheetShown) {
            NewWaypointListView { child in
                waypoints.lists[child.id] = child
                waypoints.lists[listId]!.childs.append(child.id)
                newListSheetShown = false
            }
            .padding(20)
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
            WaypointListView(listId: waypoints.rootListId)
                .environmentObject(waypoints)
        }
    }
}
