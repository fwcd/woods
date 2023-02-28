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
    
    @EnvironmentObject private var waypoints: Waypoints
    
    var list: WaypointList? {
        waypoints.listTree[listId]
    }
    
    var body: some View {
        Form {
            Section {
                WaypointListButtons(id: listId, name: list?.name)
            }
            Section(header: Text("Items")) {
                ForEach(list?.childs ?? [], id: \.self) { childId in
                    if let child = waypoints.listTree[childId] {
                        NavigationLink {
                           WaypointListView(listId: childId, largeTitle: false)
                        } label: {
                            WaypointListSnippetView(list: child)
                                .contextMenu {
                                    WaypointListContextMenu(listId: childId)
                                }
                        }
                    }
                }
                .onMove { indexSet, offset in
                    waypoints.listTree[listId]!.childs.move(fromOffsets: indexSet, toOffset: offset)
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
                        ), hasMap: true)
                    } label: {
                        WaypointSmallSnippetView(waypoint: listWaypoints[i])
                    }
                }
                .onMove { indexSet, offset in
                    waypoints.listTree[listId]!.moveWaypoints(fromOffsets: indexSet, toOffset: offset)
                }
                .onDelete { indexSet in
                    waypoints.listTree[listId]!.removeWaypoints(atOffsets: indexSet)
                }
            }
        }
        .navigationTitle(list?.name ?? "")
        .toolbar {
            ToolbarItemGroup {
                #if !os(macOS)
                EditButton()
                #endif
            }
        }
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
