//
//  PersistenceError.swift
//  Woods
//
//  Created by Fredrik on 2/14/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

enum PersistenceError: Error {
    case couldNotReadSecurityScoped
    case couldNotReadData
    case invalidDistributedChatURL(String)
}
