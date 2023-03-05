//
//  SidebarContentView.swift
//  Woods
//
//  Created by Fredrik on 6/21/20.
//  Copyright © 2020 Fredrik.
//

import SwiftUI

struct SidebarContentView: View {
    private enum Detail: Hashable {
        case map
        case search
        case accounts
        case list(UUID)
    }
    
    @State private var selectedDetail: Detail? = .map
    @State private var newListSheetShown: Bool = false
    @EnvironmentObject private var waypoints: Waypoints
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedDetail) {
                Section(header: Text("Navigation")) {
                    Label("Map", systemImage: "map.fill")
                        .tag(Detail.map)
                    Label("Search", systemImage: "magnifyingglass")
                        .tag(Detail.search)
                    Label("Accounts", systemImage: "person.circle.fill")
                        .tag(Detail.accounts)
                }
                
                Section(header: Text("Lists")) {
                    SidebarWaypointListsView { listId in
                        Detail.list(listId)
                    }
            
                    WaypointListButtons(id: waypoints.listTree.rootId) {
                        Spacer()
                    }
                    .buttonStyle(.bordered)
                }
            }
            .navigationTitle("Woods")
        } detail: {
            switch selectedDetail {
            case .map?:
                RichMapView()
            case .search?:
                SearchView()
            case .accounts?:
                AccountsView()
            case .list(let id)?:
                WaypointListView(listId: id)
            default:
                EmptyView()
            }
        }
    }
}
