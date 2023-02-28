//
//  SidebarContentView.swift
//  Woods
//
//  Created by Fredrik on 6/21/20.
//  Copyright © 2020 Fredrik.
//

import SwiftUI

struct SidebarContentView: View {
    private enum SidebarTab: Hashable, CaseIterable {
        case map
        case lists
        case search
        case accounts
    }
    
    @State private var selectedTab: SidebarTab? = .map
    @State private var newListSheetShown: Bool = false
    @EnvironmentObject private var waypoints: Waypoints
    
    var body: some View {
        NavigationSplitView {
            // TODO: Show lists inline again (with SidebarWaypointListsView)
            
            List(selection: $selectedTab) {
                Section(header: Text("Navigation")) {
                    ForEach(SidebarTab.allCases, id: \.self) { tab in
                        switch tab {
                        case .map:
                            Label("Map", systemImage: "map.fill")
                        case .lists:
                            Label("Lists", systemImage: "list.bullet")
                        case .search:
                            Label("Search", systemImage: "magnifyingglass")
                        case .accounts:
                            Label("Accounts", systemImage: "person.circle.fill")
                        }
                    }
                }
            }
        } detail: {
            switch selectedTab {
            case .map?:
                RichMapView()
            case .lists?:
                WaypointListsView()
            case .search?:
                SearchView()
            case .accounts?:
                AccountsView()
            default:
                EmptyView()
            }
        }
    }
}
