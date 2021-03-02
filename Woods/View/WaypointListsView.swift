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
    @State private var newItemSheetShown: Bool = false
    @State private var newListSheetShown: Bool = false
    @State private var newWaypointSheetShown: Bool = false
    
    var body: some View {
        NavigationView {
            WaypointListView(list: waypoints.rootList)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { newItemSheetShown = true }) {
                            Image(systemName: "plus")
                        }
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
            NewWaypointListView { list in
                waypoints.rootList.childs.append(list)
                newListSheetShown = false
            }
            .padding(20)
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
