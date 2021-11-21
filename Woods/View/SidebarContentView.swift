//
//  SidebarContentView.swift
//  Woods
//
//  Created by Fredrik on 6/21/20.
//  Copyright © 2020 Fredrik. All rights reserved.
//

import SwiftUI

struct SidebarContentView: View {
    private enum SidebarTab: Hashable {
        case map
        case lists
        case search
        case accounts
    }
    
    @State private var selectedTab: SidebarTab? = .map
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Navigation")) {
                    NavigationLink(destination: RichMapView(), tag: .map, selection: $selectedTab) {
                        Image(systemName: "map.fill")
                        Text("Map")
                    }
                    NavigationLink(destination: Text("TODO"), tag: .search, selection: $selectedTab) {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                    NavigationLink(destination: AccountsView(), tag: .accounts, selection: $selectedTab) {
                        Image(systemName: "person.circle.fill")
                        Text("Accounts")
                    }
                }
                Spacer()
                Section(header: Text("Lists")) {
                    SidebarWaypointListsView()
                }
            }
        }
    }
}
