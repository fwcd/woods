//
//  WaypointLogEditorView.swift
//  Woods
//
//  Created by Fredrik on 02.03.23.
//

import SwiftUI

struct WaypointLogEditorView: View {
    @Binding var waypointLog: WaypointLog
    @Binding var accountId: UUID
    let accountTypes: Set<AccountType>
    
    @EnvironmentObject private var accounts: Accounts
    
    var body: some View {
        Form {
            Section("Info") {
                // TODO: Add icon
                EnumPicker(selection: $waypointLog.type, label: Text("Log Type"))
                DatePicker(selection: Binding(
                    get: { waypointLog.timestamp ?? Date() },
                    set: { waypointLog.timestamp = $0 }
                )) {
                    Text("Date")
                }
                let logins = accounts.sortedAccountLogins.filter { accountTypes.contains($0.account.type) }
                Picker(selection: $accountId) {
                    ForEach(logins) { login in
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
        #if !os(macOS)
        .frame(minWidth: 300, minHeight: 500)
        #endif
    }
}

struct EditWaypointLogView_Previews: PreviewProvider {
    static var previews: some View {
        WaypointLogEditorView(
            waypointLog: .constant(WaypointLog(type: .found, username: "Alice", content: "Very nice cache, thanks!")),
            accountId: .constant(UUID()),
            accountTypes: Set(AccountType.allCases)
        )
    }
}
