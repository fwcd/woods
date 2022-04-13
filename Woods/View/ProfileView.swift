//
//  AccountsView.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

struct AccountsView: View {
    @EnvironmentObject private var profile: Accounts
    @State private var loginSheetShown = false
    @State private var loginCredentials = Credentials()
    
    var body: some View {
        VStack {
            if profile.loggedIn, let credentials = profile.credentials {
                Text("Logged in as \(credentials.username)")
            } else {
                Text("Not logged in")
            }
            
            Button(action: { loginSheetShown = true }) {
                Text("Log In")
            }
        }
        .sheet(isPresented: $loginSheetShown) {
            LoginView(credentials: $loginCredentials)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    @StateObject static var profile = Accounts(loadingFromKeychain: false)
    
    static var previews: some View {
        AccountsView()
            .environmentObject(profile)
    }
}
