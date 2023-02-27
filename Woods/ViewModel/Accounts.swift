//
//  Accounts.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik.
//

import Combine
import Security
import OSLog

private let log = Logger(subsystem: "Woods", category: "Accounts")
private let keychainLabel = "fwcd.woods.accounts"
private let keychainClass: Any = kSecClassInternetPassword

@MainActor
class Accounts: ObservableObject {
    @Published private(set) var accountLogins: [UUID: AccountLogin] = [:]
    
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
            accountLogins = Dictionary(uniqueKeysWithValues: accounts.map { ($0.id, AccountLogin(account: $0, state: .connected(MockConnector()))) })
        } else {
            let initialAccounts = initialAccounts
            Task {
                for account in initialAccounts {
                    await logIn(using: account)
                }
            }
        }
    }
    
    subscript(id: UUID) -> AccountLogin? {
        accountLogins[id]
    }
    
    func logInAndStore(_ account: Account) async {
        do {
            await logIn(using: account)
            try storeInKeychain(accounts: [account])
        } catch {
            log.error("Could not log into \(account): \(String(describing: error))")
        }
    }
    
    func logOutAndStore(_ account: Account) async {
        do {
            try await logOut(using: account)
            try removeFromKeychain(accounts: [account])
        } catch {
            log.error("Could not log out of \(account): \(String(describing: error))")
        }
    }
    
    func logOutAll() async {
        for login in accountLogins.values {
            let account = login.account
            do {
                try await logOut(using: account)
                try removeFromKeychain(accounts: [account])
            } catch {
                log.error("Could not log out of \(account): \(String(describing: error))")
            }
        }
        do {
            try clearKeychain()
        } catch {
            log.error("Could not clear keychain: \(String(describing: error))")
        }
        accountLogins = [:]
    }
    
    // TODO: Do we need to switch to the main actor when updating the login state?
    
    private func logIn(using account: Account) async {
        log.info("Logging in using \(account)")
        let login = AccountLogin(account: account, state: .connecting)
        
        accountLogins[account.id] = login
        do {
            let connector = try await account.type.makeConnector(using: account.credentials)
            accountLogins[account.id]?.state = .connected(connector)
        } catch {
            log.warning("Could not log in with account \(account): \(String(describing: error))")
            accountLogins[account.id]?.state = .failed
        }
    }
    
    private func logOut(using account: Account) async throws {
        log.info("Logging out from \(account)")
        accountLogins[account.id]?.state = .loggedOut
    }
    
    /// Loads all accounts from the user's keychain.
    private func loadFromKeychain() throws -> [Account] {
        log.info("Loading accounts from keychain")
        let query: [String: Any] = [
            kSecClass as String: keychainClass,
            kSecAttrLabel as String: keychainLabel,
            kSecMatchLimit as String: kSecMatchLimitAll,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        var rawItems: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &rawItems)
        guard status != errSecItemNotFound else {
            log.info("Found no accounts!")
            return []
        }
        guard status == errSecSuccess else { throw KeychainError.couldNotLookUp(status) }
        guard let items = rawItems as? [[String: Any]] else { throw KeychainError.unexpectedItemsData }
        
        let accounts = try items.map { item -> Account in
            guard let server = item[kSecAttrServer as String] as? String else { throw KeychainError.noServer }
            guard let accountType = AccountType(rawValue: server) else { throw KeychainError.invalidServer(server) }
            guard let short = (item[kSecAttrAccount as String] as? String)?.split(separator: ":", maxSplits: 1) else { throw KeychainError.noAccount }
            guard let rawId = short.first.map(String.init),
                  let username = short.last.map(String.init),
                  let id = UUID(uuidString: rawId) else { throw KeychainError.invalidAccount(short.joined(separator: ":")) }
            guard let passwordData = item[kSecValueData as String] as? Data,
                  let password = String(data: passwordData, encoding: .utf8) else { throw KeychainError.noPassword }
            return Account(id: id, type: accountType, credentials: Credentials(username: username, password: password))
        }
        
        log.info("Found \(accounts.count) account(s)")
        
        return accounts
    }
    
    /// Stores the given accounts in the user's keychain.
    private func storeInKeychain(accounts: [Account]) throws {
        log.info("Storing \(accounts.count) account(s) in keychain")
        for account in accounts where !account.credentials.username.isEmpty {
            let query: [String: Any] = [
                kSecClass as String: keychainClass,
                kSecAttrAccount as String: "\(account.id):\(account.credentials.username)",
                kSecAttrServer as String: account.type.rawValue,
                kSecValueData as String: account.credentials.password.data(using: .utf8)!,
                kSecAttrLabel as String: keychainLabel
            ]
            let status = SecItemAdd(query as CFDictionary, nil)
            guard status == errSecSuccess else { throw KeychainError.couldNotAdd(status) }
        }
    }
    
    /// Removes the given accounts in the user's keychain.
    private func removeFromKeychain(accounts: [Account]) throws {
        log.info("Removing \(accounts.count) account(s) from keychain")
        for account in accounts {
            let query: [String: Any] = [
                kSecClass as String: keychainClass,
                kSecAttrLabel as String: keychainLabel,
                kSecAttrServer as String: account.type.rawValue,
                kSecAttrAccount as String: "\(account.id):\(account.credentials.username)"
            ]
            let status = SecItemDelete(query as CFDictionary)
            guard status == errSecSuccess else { throw KeychainError.couldNotDelete(status) }
        }
    }
    
    /// Removes all (woods-related) accounts from the user's keychain.
    private func clearKeychain() throws {
        log.info("Clearing keychain")
        let query: [String: Any] = [
            kSecClass as String: keychainClass,
            kSecAttrLabel as String: keychainLabel
        ]
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess else { throw KeychainError.couldNotDelete(status) }
    }
}
