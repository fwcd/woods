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
                        // TODO
                    },
                    .default(Text("New List")) {
                        // TODO
                    },
                    .cancel {
                        newItemSheetShown = false
                    }
                ]
            )
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
