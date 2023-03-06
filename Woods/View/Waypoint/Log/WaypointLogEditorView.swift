//
//  WaypointLogEditorView.swift
//  Woods
//
//  Created by Fredrik on 02.03.23.
//

import SwiftUI

struct WaypointLogEditorView: View {
    @Binding var waypointLog: WaypointLog
    @Binding var accountId: UUID?
    let accountTypes: Set<AccountType>
    
    @EnvironmentObject private var accounts: Accounts
    
    var body: some View {
        Form {
            Section("Info") {
                // TODO: Add icon
                EnumPicker(selection: $waypointLog.type, label: Text("Log Type"))
                DatePicker(selection: $waypointLog.timestamp) {
                    Text("Date")
                }
                Picker(selection: $accountId) {
                    ForEach(accounts.sortedAccountLogins.filter { accountTypes.contains($0.account.type) }) { login in
                        Text(login.account.credentials.username.nilIfEmpty ?? login.account.type.description)
                            .tag(login.account.id)
                    }
                } label: {
                    Text("Account")
                }
            }
            
            Section("Content") {
                // TODO: HTML
                TextEditor(text: $waypointLog.content)
                    #if os(macOS)
                    .frame(height: 40)
                    #endif
            }
            
            Section("Preview") {
                WaypointLogView(waypointLog: waypointLog)
            }
        }
        .onAppear {
            accountId = accounts.accountLogin(forAny: accountTypes)?.account.id
        }
        .onChange(of: accountId) { accountId in
            if let accountId, let login = accounts.accountLogins[accountId] {
                waypointLog.username = login.account.credentials.username
            }
        }
        #if !os(macOS)
        .frame(minWidth: 300, minHeight: 500)
        #endif
    }
}

struct EditWaypointLogView_Previews: PreviewProvider {
    static var previews: some View {
        WaypointLogEditorView(
            waypointLog: .constant(WaypointLog(type: .found, username: "Alice", content: "Very nice cache, thanks!")),
            accountId: .constant(nil),
            accountTypes: Set(AccountType.allCases)
        )
    }
}
