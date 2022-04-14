//
//  AccountLogin.swift
//  Woods
//
//  Created by Fredrik on 14.04.22.
//

class AccountLogin: Identifiable {
    let account: Account
    var connector: Connector?
    var state: State
    
    var id: Account.ID { account.id }
    
    enum State {
        case connecting
        case connected
        case failed
    }
    
    init(
        account: Account,
        connector: Connector? = nil,
        state: State = .connecting
    ) {
        self.account = account
        self.connector = connector
        self.state = state
    }
}
