//
//  AccountsView.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import SwiftUI

struct AccountsView: View {
    @EnvironmentObject private var accounts: Accounts
    @State private var loginSheetShown = false
    @State private var loginCredentials = Credentials()
    
    var body: some View {
        NavigationView {
            List(accounts.accounts) { account in
                VStack {
                    Text(account.type.description)
                        .font(.headline)
                    Text(account.credentials.username)
                        .font(.subheadline)
                }
            }
            .navigationTitle("Accounts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { loginSheetShown = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $loginSheetShown) {
                LoginView(credentials: $loginCredentials)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ProfileView_Previews: PreviewProvider {
    @StateObject static var accounts = Accounts(loadingFromKeychain: false)
    
    static var previews: some View {
        AccountsView()
            .environmentObject(accounts)
    }
}
