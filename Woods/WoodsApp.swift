//
//  WoodsApp.swift
//  Woods
//
//  Created by Fredrik on 6/21/20.
//  Copyright © 2020 Fredrik. All rights reserved.
//

import SwiftUI

private let accounts = Accounts()
private let geocaches = Geocaches()

@main
struct WoodsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(accounts)
                .environmentObject(geocaches)
        }
    }
}
