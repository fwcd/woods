//
//  WoodsApp.swift
//  WatchWoods WatchKit Extension
//
//  Created by Fredrik on 18.11.21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

@main
struct WoodsApp: App {
    @StateObject private var locationManager = LocationManager()
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                // TODO: Display a navigator in sync with the iOS app?
                WaypointLocatingNavigatorView(target: Coordinates())
            }
            .environmentObject(locationManager)
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
