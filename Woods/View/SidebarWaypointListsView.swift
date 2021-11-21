//
//  SidebarWaypointListsView.swift
//  Woods
//
//  Created by Fredrik on 18.11.21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import SwiftUI

struct SidebarWaypointListsView: View {
    @EnvironmentObject private var waypoints: Waypoints
    
    var body: some View {
        // TODO: Buttons for adding/deleting lists (or perhaps via context menu?)
        ForEach(waypoints.listRootWrapper.childs ?? []) { topLevelWrapper in
            OutlineGroup(topLevelWrapper, children: \.childs) { wrapper in
                NavigationLink(destination: WaypointListView(listId: wrapper.id)) {
                    if let list = wrapper.list {
                        WaypointListSnippetView(list: list)
                    } else {
                        Text("Unknown List")
                    }
                }
            }
        }
    }
}
