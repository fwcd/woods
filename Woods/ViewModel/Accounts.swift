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
    @Published private(set) var accounts: [Account] = []
    
    init(accounts: [Account] = [], loadFromKeychain: Bool = false) {
        for account in accounts {
            tryLogIn(using: account)
        }
        
        do {
            if loadFromKeychain {
                for account in try loadCredentials() {
                    tryLogIn(using: account)
                }
            }
        } catch {
            log.info("Could not load initial credentials from keychain: \(String(describing: error))")
        }
    }
    
    private func tryLogIn(using account: Account) {
        do {
            try logIn(using: account)
        } catch {
            log.warning("Could not log in with account \(account): \(String(describing: error))")
        }
    }
    
    func logInAndStore(_ account: Account) throws {
        try logIn(using: account)
        // TODO: Store credentials
    }
    
    func logOutAndStore(_ account: Account) throws {
        try logOut(using: account)
        // TODO: Remove credentials from store
    }
    
    private func logIn(using account: Account) throws {
        // TODO
    }
    
    private func logOut(using account: Account) throws {
        // TODO
    }
    
    /// Loads the credentials from the user's keychain.
    func loadCredentials() throws -> [Account] {
        // TODO
        []
    }
    
    /// Stores the credentials in the user's keychain.
    func storeCredentials() throws -> [Account] {
        // TODO
        []
    }
}
