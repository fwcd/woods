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
    
    var body: some View {
        NavigationView {
            List(accounts.accounts) { account in
                VStack(alignment: .leading) {
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
                LoginView { account in
                    // TODO: Actually log in
                    accounts.accounts.append(account)
                    loginSheetShown = false
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AccountsView_Previews: PreviewProvider {
    @StateObject static var accounts = Accounts(accounts: [
        Account(
            id: UUID(uuidString: "b0819a69-ceef-4323-b752-ff09a70230fd")!,
            type: .geocachingCom,
            credentials: Credentials(
                username: "test",
                password: "test"
            )
        ),
        Account(
            id: UUID(uuidString: "ff25ad11-37ad-4d13-a204-e83d4d75476a")!,
            type: .geocachingCom,
            credentials: Credentials(
                username: "demo",
                password: "demo"
            )
        )
    ])
    static var previews: some View {
        AccountsView()
            .environmentObject(accounts)
    }
}
