//
//  ContentView.swift
//  Woods
//
//  Created by Fredrik on 6/21/20.
//  Copyright © 2020 Fredrik. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RefreshableGeocacheMapView()
                .tabItem {
                    VStack {
                        Image(systemName: "map.fill")
                        Text("Geocache Map")
                    }
                }
            Text("TODO")
                .tabItem {
                    VStack {
                        Image(systemName: "list.bullet")
                        Text("Lists")
                    }
                }
            Text("TODO")
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                }
            AccountsView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.circle.fill")
                        Text("Accounts")
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject static var accounts = Accounts(testMode: true)
    @StateObject static var geocaches = Geocaches(accounts: accounts)
    static var previews: some View {
        ContentView()
            .environmentObject(accounts)
            .environmentObject(geocaches)
    }
}
