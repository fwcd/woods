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
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
