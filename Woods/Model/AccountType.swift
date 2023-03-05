//
//  AccountType.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik.
//

enum AccountType: String, CustomStringConvertible, CaseIterable, Hashable, Codable {
    case geocachingCom = "geocaching.com"
    case mock
    
    var description: String { rawValue }
}
