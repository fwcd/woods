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
            tryLogIn(with: account)
        }
        
        do {
            if loadFromKeychain {
                for account in try loadCredentials() {
                    tryLogIn(with: account)
                }
            }
        } catch {
            log.info("Could not load initial credentials from keychain: \(String(describing: error))")
        }
    }
    
    private func tryLogIn(with account: Account) {
        do {
            try logIn(with: account)
        } catch {
            log.warning("Could not log in with account \(account): \(String(describing: error))")
        }
    }
    
    func logInAndStore(_ account: Account) throws {
        try logIn(with: account)
        // TODO: Store credentials
    }
    
    func logOutAndStore(_ account: Account) throws {
        try logOut(from: account)
        // TODO: Remove credentials from store
    }
    
    private func logIn(with account: Account) throws {
        // TODO
    }
    
    private func logOut(from account: Account) throws {
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
