//
//  WaypointListTree.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import Foundation

struct WaypointListTree: Codable, Hashable {
    var lists: [UUID: WaypointList]
    var rootId: UUID
    
    init() {
        rootId = UUID()
        lists = [rootId: WaypointList(id: rootId, name: "Lists")]
    }
    
    subscript(listId: UUID) -> WaypointList? {
        get { lists[listId] }
        set { lists[listId] = newValue }
    }
    
    func preOrderTraversed(from listId: UUID) -> [WaypointList] {
        if let list = lists[listId] {
            return [list] + list.childs.flatMap(preOrderTraversed(from:))
        } else {
            return []
        }
    }
    
    func preOrderTraversed() -> [WaypointList] {
        preOrderTraversed(from: rootId)
    }
}
