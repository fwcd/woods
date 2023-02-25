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
            
            Section(header: Text("Navigation")) {
                List(SidebarTab.allCases, id: \.self, selection: $selectedTab) { tab in
                    NavigationLink(value: tab) {
                        switch tab {
                        case .map:
                            Image(systemName: "map.fill")
                            Text("Map")
                        case .lists:
                            Image(systemName: "list.bullet")
                            Text("Lists")
                        case .search:
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        case .accounts:
                            Image(systemName: "person.circle.fill")
                            Text("Accounts")
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
