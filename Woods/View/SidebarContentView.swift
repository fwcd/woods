//
//  SidebarContentView.swift
//  Woods
//
//  Created by Fredrik on 6/21/20.
//  Copyright © 2020 Fredrik. All rights reserved.
//

import SwiftUI

struct SidebarContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: RichMapView()) {
                    Image(systemName: "map.fill")
                    Text("Map")
                }
                NavigationLink(destination: WaypointListsView()) {
                    Image(systemName: "list.bullet")
                    Text("Lists")
                }
                NavigationLink(destination: Text("TODO")) {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                NavigationLink(destination: AccountsView()) {
                    Image(systemName: "person.circle.fill")
                    Text("Accounts")
                }
            }
            Text("Test")
        }
    }
}
