//
//  AccountType.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik.
//

enum AccountType: String, CustomStringConvertible, CaseIterable, Hashable {
    case geocachingCom = "geocaching.com"
    case mock
    
    var description: String { rawValue }
    
    func makeConnector(using credentials: Credentials) async throws -> any Connector {
        switch self {
        case .geocachingCom:
            return try await GeocachingComConnector(using: credentials)
        case .mock:
            return MockConnector(using: credentials)
        }
    }
}
