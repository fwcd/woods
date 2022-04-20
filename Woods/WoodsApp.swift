//
//  WoodsApp.swift
//  Woods
//
//  Created by Fredrik on 6/21/20.
//  Copyright © 2020 Fredrik.
//

import SwiftUI

@MainActor
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
        
        #if canImport(UIKit)
        UITableView.appearance().backgroundColor = .clear // applies to Form backgrounds too
        UIScrollView.appearance().keyboardDismissMode = .interactive
        UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
        #endif
    }
}

@MainActor
private let state = AppState()

@main
struct WoodsApp: App {
    var body: some Scene {
        WindowGroup {
            Group {
                if [.pad, .mac].contains(UserInterfaceIdiom.current) {
                    SidebarContentView()
                } else {
                    ContentView()
                }
            }
            .environmentObject(state.accounts)
            .environmentObject(state.waypoints)
            .environmentObject(state.locationManager)
        }
    }
}
