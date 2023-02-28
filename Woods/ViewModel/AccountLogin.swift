//
//  AccountLogin.swift
//  Woods
//
//  Created by Fredrik on 14.04.22.
//

struct AccountLogin: Identifiable {
    let account: Account
    var state: State
    
    var id: Account.ID { account.id }
    
    var connector: Connector? {
        switch state {
        case .connected(let connector):
            return connector
        default:
            return nil
        }
    }
    
    enum State {
        case connecting
        case connected(any Connector)
        case failed
        case loggedOut
        
        var isAttemptedLogin: Bool {
            switch self {
            case .loggedOut:
                return false
            default:
                return true
            }
        }
    }
    
    init(account: Account, state: State = .loggedOut) {
        self.account = account
        self.state = state
    }
}
