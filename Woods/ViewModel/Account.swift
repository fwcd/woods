//
//  Account.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import Foundation

struct Account: Identifiable, CustomStringConvertible {
    var id: UUID = UUID()
    var type: AccountType
    var credentials: Credentials
    
    var connector: Connector? = nil
    
    var description: String { "\(type) Account: \(credentials.username)" }
}
