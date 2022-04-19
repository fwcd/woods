//
//  WaypointListView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

struct WaypointListView: View {
    let listId: UUID
    var largeTitle: Bool = true
    
    @State private var newListSheetShown: Bool = false
    @State private var newWaypoint = Waypoint()
    @State private var newWaypointSheetShown: Bool = false {
        willSet {
            if newValue != newWaypointSheetShown {
                newWaypoint = Waypoint()
            }
        }
    }
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
                    CancelNavigationView(title: "New Waypoint List") {
                        newListSheetShown = false
                    } inner: {
                        NewWaypointListView { child in
                            waypoints.listTree.insert(under: listId, child: child)
                            newListSheetShown = false
                        }
                        .padding(20)
                    }
                }
                Button(action: { newWaypointSheetShown = true }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("New Waypoint")
                    }
                }
                .sheet(isPresented: $newWaypointSheetShown) {
                    CancelNavigationView(title: "New Waypoint") {
                        newWaypointSheetShown = false
                    } inner: {
                        EditWaypointView(waypoint: $newWaypoint) {
                            waypoints.listTree[listId]?.add(waypoints: [newWaypoint])
                            newWaypointSheetShown = false
                        }
                    }
                }
                Button(action: { clearConfirmationShown = true }) {
                    HStack {
                        Image(systemName: "trash")
                        Text("Clear List")
                    }
                }
                .confirmationDialog("Are you sure?", isPresented: $clearConfirmationShown) {
                    Button {
                        for childId in waypoints.listTree[listId]?.childs ?? [] {
                            waypoints.listTree.remove(childId)
                        }
                        waypoints.listTree[listId]?.clearWaypoints()
                    } label: {
                        Text("Clear \(list?.name ?? "List")")
                    }
                    Button("Cancel", role: .cancel) {}
                }
            }
            Section(header: Text("Items")) {
                ForEach(list?.childs ?? [], id: \.self) { childId in
                    if let child = waypoints.listTree[childId] {
                        NavigationLink(destination: WaypointListView(listId: childId, largeTitle: false)) {
                            WaypointListSnippetView(list: child)
                                .contextMenu {
                                    WaypointListContextMenu(listId: childId)
                                }
                        }
                    }
                }
                .onDelete { indexSet in
                    for childId in indexSet.map({ waypoints.listTree[listId]!.childs[$0] }) {
                        waypoints.listTree.remove(childId)
                    }
                }
                let listWaypoints = list?.waypoints ?? []
                ForEach(0..<listWaypoints.count, id: \.self) { i in
                    NavigationLink {
                        NavigationWaypointDetailView(waypoint: Binding(
                            get: { listWaypoints[i] },
                            set: { waypoints.listTree[listId]?.waypoints[i] = $0 }
                        ))
                    } label: {
                        WaypointSmallSnippetView(waypoint: listWaypoints[i])
                    }
                }
                .onDelete { indexSet in
                    waypoints.listTree[listId]!.removeWaypoints(atOffsets: indexSet)
                }
            }
        }
        .navigationTitle(list?.name ?? "")
        #if !os(macOS)
        .navigationBarTitleDisplayMode(largeTitle ? .large : .inline)
        #endif
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
