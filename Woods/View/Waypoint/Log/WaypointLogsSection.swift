//
//  WaypointLogsSection.swift
//  Woods
//
//  Created by Fredrik on 02.03.23.
//

import SwiftUI
import OSLog

private let log = Logger(subsystem: "Woods", category: "WaypointLogsSection")

struct WaypointLogsSection: View {
    let waypoint: Waypoint
    
    @EnvironmentObject private var accounts: Accounts
    @State private var newLogSheetShown = false
    @State private var newLogAccountId: UUID = .init() // Updated in onAppear
    @State private var newLog = WaypointLog()
    
    var body: some View {
        SimpleSection {
            WaypointLogsView(waypoint: waypoint)
                .frame(maxWidth: .infinity)
        } header: {
            HStack {
                Label("Logs", systemImage: "book.closed.fill")
                Spacer()
                if !waypoint.fetchableViaAccountTypes.isEmpty {
                    Button {
                        newLog = WaypointLog()
                        newLogSheetShown = true
                    } label: {
                        Label("New Log", systemImage: "square.and.pencil")
                    }
                    .popover(isPresented: $newLogSheetShown) {
                        PopoverNavigation(title: "New Log") {
                            newLogSheetShown = false
                        } inner: {
                            WaypointLogEditorView(
                                waypointLog: $newLog,
                                accountId: $newLogAccountId,
                                accountTypes: waypoint.fetchableViaAccountTypes
                            )
                            .toolbar {
                                Button("Post", action: postNewLog)
                            }

                        }
                    }
                }
            }
        }
        .onAppear {
            if let login = accounts.accountLogin(forAny: waypoint.fetchableViaAccountTypes) {
                let account = login.account
                newLogAccountId = account.id
            } else {
                log.error("Could not find any account for logging!")
            }
        }
    }
    
    private func postNewLog() {
        Task {
            // TODO: Log in automatically if needed
            if let login = accounts.accountLogins[newLogAccountId],
               let connector = login.connector {
                do {
                    _ = try await connector.post(waypointLog: newLog, for: waypoint)
                } catch {
                    log.error("Could not post log: \(error)")
                }
            } else {
                log.error("No connector for posting log")
            }
            newLogSheetShown = false
        }
    }
}

struct WaypointLogsSection_Previews: PreviewProvider {
    static var previews: some View {
        WaypointLogsSection(waypoint: mockGeocaches()[0])
    }
}
