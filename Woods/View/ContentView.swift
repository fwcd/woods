//
//  ContentView.swift
//  Woods
//
//  Created by Fredrik on 05.03.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let isCompact = ![.pad, .mac].contains(UserInterfaceIdiom.current)
        if isCompact {
            TabbedContentView()
        } else {
            SplitContentView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject static var accounts = Accounts(testMode: true)
    @StateObject static var waypoints = Waypoints(accounts: accounts)
    @StateObject static var locationManager = LocationManager()
    static var previews: some View {
        ContentView()
            .environmentObject(accounts)
            .environmentObject(waypoints)
            .environmentObject(locationManager)
            .previewInterfaceOrientation(.portrait)
    }
}

