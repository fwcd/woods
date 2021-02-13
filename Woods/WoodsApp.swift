//
//  WoodsApp.swift
//  Woods
//
//  Created by Fredrik on 6/21/20.
//  Copyright © 2020 Fredrik. All rights reserved.
//

import SwiftUI

@main
struct WoodsApp: App {
    @StateObject private var accounts = Accounts()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(accounts)
        }
    }
}
