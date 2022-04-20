//
//  SidebarContentView.swift
//  Woods
//
//  Created by Fredrik on 6/21/20.
//  Copyright © 2020 Fredrik.
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
    @State private var newListSheetShown: Bool = false
    @EnvironmentObject private var waypoints: Waypoints
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Navigation")) {
                    NavigationLink(destination: RichMapView(), tag: .map, selection: $selectedTab) {
                        Image(systemName: "map.fill")
                        Text("Map")
                    }
                    NavigationLink(destination: SearchView(), tag: .search, selection: $selectedTab) {
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
                    Button {
                        newListSheetShown = true
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add List")
                        }
                    }
                    .sheet(isPresented: $newListSheetShown) {
                        CancelNavigationView(title: "New Waypoint List") {
                            newListSheetShown = false
                        } inner: {
                            NewWaypointListView { child in
                                waypoints.listTree.insert(child: child)
                                newListSheetShown = false
                            }
                            .padding(20)
                        }
                    }
                }
            }
            .listStyle(.sidebar)
        }
    }
}
