//
//  AccountsView.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI
import OSLog

private let log = Logger(subsystem: "Woods", category: "AccountsView")

struct AccountsView: View {
    @EnvironmentObject private var accounts: Accounts
    @State private var loginSheetShown = false
    @State private var logoutConfirmationShown = false
    
    var body: some View {
        NavigationView {
            List {
                let logins = accounts.accountLogins
                    .values
                    .sorted { $0.account.credentials.username < $1.account.credentials.username }
                ForEach(logins) { login in
                    AccountLoginSnippetView(login: login)
                }
                .onDelete { indexSet in
                    Task {
                        await withTaskGroup(of: Void.self) { group in
                            for i in indexSet where i < logins.count && i >= 0 {
                                group.addTask {
                                    await accounts.logOutAndStore(logins[i].account)
                                }
                            }
                            await group.waitForAll()
                        }
                    }
                }
            }
            .navigationTitle("Accounts")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        logoutConfirmationShown = true
                    } label: {
                        Text("Log Out All")
                    }
                    .confirmationDialog("This will log you out of all accounts. Are you sure?", isPresented: $logoutConfirmationShown) {
                        Button {
                            Task {
                                await accounts.logOutAll()
                            }
                        } label: {
                            Text("Log Out All Accounts")
                        }
                        Button("Cancel", role: .cancel) {}
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { loginSheetShown = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $loginSheetShown) {
                CancelNavigationView(title: "Login") {
                    loginSheetShown = false
                } inner: {
                    LoginView { account in
                        Task {
                            await accounts.logInAndStore(account)
                            loginSheetShown = false
                        }
                    }
                }
            }
        }
        #if !os(macOS)
        .navigationViewStyle(StackNavigationViewStyle())
        #endif
    }
}

struct AccountsView_Previews: PreviewProvider {
    @StateObject static var accounts = Accounts(accounts: [
        Account(
            id: UUID(uuidString: "b0819a69-ceef-4323-b752-ff09a70230fd")!,
            type: .mock,
            credentials: Credentials(
                username: "test",
                password: "test"
            )
        ),
        Account(
            id: UUID(uuidString: "ff25ad11-37ad-4d13-a204-e83d4d75476a")!,
            type: .mock,
            credentials: Credentials(
                username: "demo",
                password: "demo"
            )
        )
    ], testMode: true)
    static var previews: some View {
        AccountsView()
            .environmentObject(accounts)
    }
}
