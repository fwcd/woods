//
//  KeychainError.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import Foundation

enum KeychainError: Error {
    case unexpectedItemsData
    case noServer
    case noPassword
    case noAccount
    case invalidServer(String)
    case invalidAccount(String)
    case couldNotAdd(OSStatus)
    case couldNotDelete(OSStatus)
    case couldNotLookUp(OSStatus)
}
