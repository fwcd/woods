//
//  WaypointListTree.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik.
//

import Foundation

struct WaypointListTree: Codable, Hashable {
    private(set) var lists: [UUID: WaypointList]
    private(set) var rootId: UUID
    
    var root: WaypointList { lists[rootId]! }
    
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
            return [list] + preOrderTraversedChildren(from: listId)
        } else {
            return []
        }
    }
    
    func preOrderTraversed() -> [WaypointList] {
        preOrderTraversed(from: rootId)
    }
    
    func preOrderTraversedChildren(from listId: UUID) -> [WaypointList] {
        lists[listId].map { $0.childs.flatMap(preOrderTraversed(from:)) } ?? []
    }
    
    func preOrderTraversedChildren() -> [WaypointList] {
        preOrderTraversedChildren(from: rootId)
    }
    
    /// Inserts a new child list under the given list id.
    mutating func insert(under listId: UUID, child: WaypointList) {
        lists[child.id] = child
        lists[listId]!.childs.append(child.id)
    }
    
    /// Inserts a new list under the root.
    mutating func insert(child: WaypointList) {
        insert(under: rootId, child: child)
    }
    
    /// Safely removes a list and all of its references.
    mutating func remove(_ listId: UUID) {
        guard listId != rootId else {
            fatalError("Cannot remove root WaypointList")
        }
        
        for childId in lists[listId]?.childs ?? [] {
            remove(childId)
        }
        
        lists[listId] = nil
        
        for otherId in lists.keys {
            lists[otherId]?.childs.removeAll { $0 == listId }
        }
    }
}
