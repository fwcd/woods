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
    @State private var clearConfirmationShown: Bool = false
    @EnvironmentObject private var waypoints: Waypoints
    
    var list: WaypointList? {
        waypoints.listTree[listId]
    }
    
    var body: some View {
        Form {
            Section {
                Button(action: { newListSheetShown = true }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("New List")
                    }
                }
                .sheet(isPresented: $newListSheetShown) {
                    NewWaypointListView { child in
                        waypoints.listTree.insert(under: listId, child: child)
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
                Button(action: { clearConfirmationShown = true }) {
                    HStack {
                        Image(systemName: "trash")
                        Text("Clear List")
                    }
                }
                .actionSheet(isPresented: $clearConfirmationShown) {
                    ActionSheet(
                        title: Text("Are you sure?"),
                        buttons: [
                            .destructive(Text("Clear \(list?.name ?? "List")")) {
                                for childId in waypoints.listTree[listId]?.childs ?? [] {
                                    waypoints.listTree.remove(childId)
                                }
                                
                                waypoints.listTree[listId]?.clearWaypoints()
                            },
                            .cancel()
                        ]
                    )
                }
            }
            Section(header: Text("Items")) {
                ForEach(list?.childs ?? [], id: \.self) { childId in
                    if let child = waypoints.listTree[childId] {
                        NavigationLink(destination: WaypointListView(listId: childId, largeTitle: false)) {
                            WaypointListSnippetView(list: child)
                        }
                    }
                }
                .onDelete { indexSet in
                    for childId in indexSet.map({ waypoints.listTree[listId]!.childs[$0] }) {
                        waypoints.listTree.remove(childId)
                    }
                }
                ForEach(list?.waypoints ?? []) { waypoint in
                    NavigationLink(destination: WaypointDetailView(waypoint: waypoint)) {
                        WaypointSmallSnippetView(waypoint: waypoint)
                    }
                }
                .onDelete { indexSet in
                    waypoints.listTree[listId]!.removeWaypoints(atOffsets: indexSet)
                }
            }
        }
        .navigationTitle(list?.name ?? "")
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
            WaypointListView(listId: waypoints.listTree.rootId)
                .environmentObject(waypoints)
        }
    }
}
