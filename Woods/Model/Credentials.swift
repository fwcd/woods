//
//  Credentials.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

struct Credentials: Hashable, CustomStringConvertible {
    var username: String = ""
    var password: String = ""
    
    var description: String { "Credentials for user '\(username)'" }
}
