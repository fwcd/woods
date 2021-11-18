//
//  WoodsApp.swift
//  Woods
//
//  Created by Fredrik on 6/21/20.
//  Copyright © 2020 Fredrik. All rights reserved.
//

import SwiftUI

private class AppState {
    let accounts: Accounts
    let waypoints: Waypoints
    let locationManager: LocationManager
    
    init() {
        let accounts = Accounts()
        let waypoints = Waypoints(accounts: accounts)
        let locationManager = LocationManager()
        
        self.accounts = accounts
        self.waypoints = waypoints
        self.locationManager = locationManager
        
        UITableView.appearance().backgroundColor = .clear // applies to Form backgrounds too
        UIScrollView.appearance().keyboardDismissMode = .interactive
    }
}

private let state = AppState()

@main
struct WoodsApp: App {
    var body: some Scene {
        WindowGroup {
            if [.pad, .mac].contains(UIDevice.current.userInterfaceIdiom) {
                SidebarContentView()
                    .environmentObject(state.accounts)
                    .environmentObject(state.waypoints)
                    .environmentObject(state.locationManager)
            } else {
                ContentView()
                    .environmentObject(state.accounts)
                    .environmentObject(state.waypoints)
                    .environmentObject(state.locationManager)
            }
        }
    }
}
