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
    @Published private(set) var accounts: [UUID: Account] = [:]
    
    private var connectors = [UUID: Connector]()
    private var loginTasks = [UUID: AnyCancellable]()
    private var logoutTasks = [UUID: AnyCancellable]()
    
    init(accounts: [Account] = [], testMode: Bool = false) {
        var initialAccounts = accounts
        
        do {
            if !testMode {
                initialAccounts += try loadFromKeychain()
            }
        } catch {
            log.info("Could not load initial credentials from keychain: \(String(describing: error))")
        }
        
        if testMode {
            self.accounts = Dictionary(uniqueKeysWithValues: accounts.map { ($0.id, $0) })
        } else {
            for account in accounts {
                logIn(using: account)
            }
        }
    }
    
    func logInAndStore(_ account: Account) {
        do {
            logIn(using: account)
            try storeInKeychain(accounts: [account])
        } catch {
            log.error("Could not log in: \(String(describing: error))")
        }
    }
    
    func logOutAndStore(_ account: Account) {
        do {
            try logOut(using: account)
            try removeFromKeychain(accounts: [account])
        } catch {
            log.error("Could not log out: \(String(describing: error))")
        }
    }
    
    private func logIn(using account: Account) {
        let connector = account.type.makeConnector()
        
        loginTasks[account.id] = connector
            .logIn(using: account.credentials)
            .sink { completion in
                if case let .failure(error) = completion {
                    log.warning("Could not log in with account \(account): \(String(describing: error))")
                }
            } receiveValue: { [self] in
                accounts[account.id] = account
            }
    }
    
    private func logOut(using account: Account) throws {
        guard let connector = connectors[account.id] else { throw ConnectorError.noConnector }
        
        logoutTasks[account.id] = connector
            .logOut()
            .sink { completion in
                if case let .failure(error) = completion {
                    log.warning("Could not log out from account \(account): \(String(describing: error))")
                }
            } receiveValue: { [self] in
                accounts[account.id] = nil
            }
    }
    
    /// Loads all accounts from the user's keychain.
    func loadFromKeychain() throws -> [Account] {
        // TODO
        []
    }
    
    /// Stores the given accounts in the user's keychain.
    func storeInKeychain(accounts: [Account]) throws {
        // TODO
    }
    
    /// Removes the given accounts in the user's keychain.
    func removeFromKeychain(accounts: [Account]) throws {
        // TODO
    }
}
