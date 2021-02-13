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
            GeocacheMapView()
                .tabItem {
                    VStack {
                        Image(systemName: "map.fill")
                        Text("Geocache Map")
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
    @StateObject static var accounts = Accounts()
    static var previews: some View {
        ContentView()
            .environmentObject(accounts)
    }
}
