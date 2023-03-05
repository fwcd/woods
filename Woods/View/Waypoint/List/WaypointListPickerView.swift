//
//  WaypointListPickerView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

struct WaypointListPickerView: View {
    let onPick: (UUID) -> Void
    
    @State private var newListSheetShown: Bool = false
    @EnvironmentObject private var waypoints: Waypoints
    
    var body: some View {
        Form {
            Section {
                Button {
                    newListSheetShown = true
                } label: {
                    Label("New List", systemImage: "plus")
                }
                .popover(isPresented: $newListSheetShown) {
                    PopoverNavigation(title: "New Waypoint List") {
                        newListSheetShown = false
                    } inner: {
                        NewWaypointListView { child in
                            waypoints.listTree.insert(under: waypoints.listTree.rootId, child: child)
                            newListSheetShown = false
                        }
                        #if !os(macOS)
                        .padding(10)
                        #endif
                    }
                }
            }
            Section {
                Button {
                    onPick(waypoints.listTree.rootId)
                } label: {
                    WaypointListSnippetView(list: waypoints.listTree.root)
                }
            }
            List(waypoints.listRootWrapper.childs ?? [], children: \.childs) { listWrapper in
                Button {
                    onPick(listWrapper.id)
                } label: {
                    if let list = listWrapper.list {
                        WaypointListSnippetView(list: list)
                    }
                }
            }
            #if os(macOS)
            .frame(minWidth: 200, minHeight: 200)
            #endif
        }
    }
}

struct WaypointListPickerView_Previews: PreviewProvider {
    @StateObject static var waypoints = Waypoints(accounts: Accounts(testMode: true), lists: [
        WaypointList(name: "A"),
        WaypointList(name: "B"),
    ])
    static var previews: some View {
        NavigationStack {
            WaypointListPickerView { _ in }
                .environmentObject(waypoints)
        }
    }
}
