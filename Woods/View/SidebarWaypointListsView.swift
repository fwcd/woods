//
//  SidebarWaypointListsView.swift
//  Woods
//
//  Created by Fredrik on 18.11.21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

struct SidebarWaypointListsView<Tag>: View where Tag: Hashable {
    let tagList: (UUID) -> Tag
    
    @EnvironmentObject private var waypoints: Waypoints
    
    var body: some View {
        // TODO: Buttons for adding/deleting lists (or perhaps via context menu?)
        // TODO: Use an OutlineGroup again (or similar) to show the entire tree in the sidebar. Unfortunately, this seems to interact poorly with tag-based list selection and NavigationSplitView so we omit it for now.
        ForEach(waypoints.listRootWrapper.childs ?? []) { wrapper in
            if let list = wrapper.list {
                WaypointListSnippetView(list: list)
                    .tag(tagList(wrapper.id))
                    .contextMenu {
                        WaypointListContextMenu(listId: wrapper.id)
                    }
            } else {
                Text("Unknown List")
            }
        }
    }
}
