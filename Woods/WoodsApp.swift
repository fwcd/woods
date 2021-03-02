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
    let geocaches: Geocaches
    
    init() {
        let accounts = Accounts()
        let geocaches = Geocaches(accounts: accounts)
        
        self.accounts = accounts
        self.geocaches = geocaches
        
        UIScrollView.appearance().keyboardDismissMode = .interactive
    }
}

private let state = AppState()

@main
struct WoodsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(state.accounts)
                .environmentObject(state.geocaches)
        }
    }
}
