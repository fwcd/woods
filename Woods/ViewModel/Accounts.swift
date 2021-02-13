//
//  Accounts.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import Combine
import OSLog

private let log = Logger(subsystem: "Woods", category: "ViewModel")

class Accounts: ObservableObject {
    @Published var accounts: [Account] = []
    
    init(loadingFromKeychain: Bool = true) {
        do {
            if loadingFromKeychain {
                try loadCredentials()
            }
        } catch {
            log.info("Could not load initial credentials from keychain: \(String(describing: error))")
        }
    }
    
    /// Loads the credentials from the user's keychain.
    func loadCredentials() throws {
        // TODO
    }
    
    /// Stores the credentials in the user's keychain.
    func storeCredentials() throws {
        // TODO
    }
}
