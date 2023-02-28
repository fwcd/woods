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
    let select: (UUID) -> Void
    
    @EnvironmentObject private var waypoints: Waypoints
    
    var body: some View {
        // TODO: Buttons for adding/deleting lists (or perhaps via context menu?)
        ForEach(waypoints.listRootWrapper.childs ?? []) { topLevelWrapper in
            OutlineGroup(topLevelWrapper, children: \.childs) { wrapper in
                if let list = wrapper.list {
                    WaypointListSnippetView(list: list)
                        .tag(tagList(wrapper.id))
                        .onTapGesture {
                            select(wrapper.id)
                        }
                        .contextMenu {
                            WaypointListContextMenu(listId: wrapper.id)
                        }
                } else {
                    Text("Unknown List")
                }
            }
        }
    }
}
