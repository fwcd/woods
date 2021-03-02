//
//  WaypointListPickerView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import SwiftUI

struct WaypointListPickerView: View {
    let onPick: (UUID) -> Void
    
    @EnvironmentObject private var waypoints: Waypoints
    
    var body: some View {
        List(waypoints.listTree.preOrderTraversed()) { list in
            Button(action: { onPick(list.id) }) {
                WaypointListSnippetView(list: list)
            }
        }
    }
}

struct WaypointListPickerView_Previews: PreviewProvider {
    @StateObject static var waypoints = Waypoints(accounts: Accounts(testMode: true))
    static var previews: some View {
        WaypointListPickerView { _ in }
            .environmentObject(waypoints)
    }
}
