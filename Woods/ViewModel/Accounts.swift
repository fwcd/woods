//
//  Accounts.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import Combine
import Security
import OSLog

private let log = Logger(subsystem: "Woods", category: "ViewModel")
private let keychainLabel = "fwcd.woods.accounts"
private let keychainClass: Any = kSecClassInternetPassword

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
        let query: [String: Any] = [
            kSecClass as String: keychainClass,
            kSecAttrLabel as String: keychainLabel,
            kSecMatchLimit as String: kSecMatchLimitAll,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        var rawItems: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &rawItems)
        guard status != errSecItemNotFound else { return [] }
        guard status == errSecSuccess else { throw KeychainError.couldNotLookUp(status) }
        guard let items = rawItems as? [[String: Any]] else { throw KeychainError.unexpectedItemsData }
        
        return try items.map { item in
            guard let server = item[kSecAttrServer as String] as? String,
                  let accountType = AccountType(rawValue: server),
                  let username = item[kSecAttrAccount as String] as? String,
                  let passwordData = item[kSecValueData as String] as? Data,
                  let password = String(data: passwordData, encoding: .utf8) else { throw KeychainError.unexpectedItemData }
            return Account(type: accountType, credentials: Credentials(username: username, password: password))
        }
    }
    
    /// Stores the given accounts in the user's keychain.
    func storeInKeychain(accounts: [Account]) throws {
        for account in accounts {
            let query: [String: Any] = [
                kSecClass as String: keychainClass,
                kSecAttrAccount as String: account.credentials.username,
                kSecAttrServer as String: account.type.rawValue,
                kSecValueData as String: account.credentials.password.data(using: .utf8)!,
                kSecAttrLabel as String: keychainLabel
            ]
            let status = SecItemAdd(query as CFDictionary, nil)
            guard status == errSecSuccess else { throw KeychainError.couldNotAdd(status) }
        }
    }
    
    /// Removes the given accounts in the user's keychain.
    func removeFromKeychain(accounts: [Account]) throws {
        for account in accounts {
            let query: [String: Any] = [
                kSecClass as String: keychainClass,
                kSecAttrLabel as String: keychainLabel,
                kSecAttrServer as String: account.type.rawValue,
                kSecAttrAccount as String: account.credentials.username
            ]
            let status = SecItemDelete(query as CFDictionary)
            guard status == errSecSuccess else { throw KeychainError.couldNotDelete(status) }
        }
    }
}
