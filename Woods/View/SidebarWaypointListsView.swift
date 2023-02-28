//
//  SidebarWaypointListsView.swift
//  Woods
//
//  Created by Fredrik on 18.11.21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

struct SidebarWaypointListsView<Tag>: View where Tag: Hashable {
    let listTagger: (UUID) -> Tag
    
    @EnvironmentObject private var waypoints: Waypoints
    
    var body: some View {
        // TODO: Buttons for adding/deleting lists (or perhaps via context menu?)
        ForEach(waypoints.listRootWrapper.childs ?? []) { topLevelWrapper in
            OutlineGroup(topLevelWrapper, children: \.childs) { wrapper in
                if let list = wrapper.list {
                    WaypointListSnippetView(list: list)
                        .tag(listTagger(wrapper.id))
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
