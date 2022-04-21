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
    @StateObject private var remoteHostManager = RemoteHostManager()
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationManager)
                .environmentObject(remoteHostManager)
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
