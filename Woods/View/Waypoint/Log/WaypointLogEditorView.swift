//
//  WaypointLogEditorView.swift
//  Woods
//
//  Created by Fredrik on 02.03.23.
//

import SwiftUI

struct WaypointLogEditorView: View {
    @Binding var waypointLog: WaypointLog
    let accountTypes: Set<AccountType>
    
    @EnvironmentObject private var accounts: Accounts
    @State private var accountId: UUID? = nil
    
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
            accountTypes: Set(AccountType.allCases)
        )
    }
}
