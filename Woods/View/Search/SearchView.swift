//
//  SearchView.swift
//  Woods
//
//  Created by Fredrik on 20.04.22.
//

import SwiftUI
import OSLog

private let log = Logger(subsystem: "Woods", category: "SearchView")

struct SearchView: View {
    @State private var waypoint: Waypoint? = nil
    @State private var searchQuery: String = ""
    
    @EnvironmentObject private var accounts: Accounts
    
    var body: some View {
        // TODO: Integrate proper search (not just id lookup)
        NavigationStack {
            ScrollView {
                if let waypoint {
                    WaypointDetailView(waypoint: waypoint)
                }
            }
            .navigationTitle("Search")
            .searchable(text: $searchQuery, prompt: "Enter waypoint ID...")
            .onSubmit(of: .search) {
                Task {
                    // TODO: Use all accounts for search results?
                    if let connector = accounts.accountLogins.values.compactMap(\.connector).first {
                        do {
                            waypoint = try await connector.waypoint(id: searchQuery)
                        } catch {
                            log.warning("Could not fetch waypoint: \(error)")
                        }
                    }
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
