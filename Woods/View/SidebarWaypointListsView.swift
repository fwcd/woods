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
        ForEach(waypoints.listTree.preOrderTraversedChildren()) { list in
            Text(list.name)
        }
    }
}
