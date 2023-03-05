//
//  AccountType+Connector.swift
//  Woods
//
//  Created by Fredrik on 05.03.23.
//

extension AccountType {
    func makeConnector(using credentials: Credentials) async throws -> any Connector {
        switch self {
        case .geocachingCom:
            return try await GeocachingComConnector(using: credentials)
        case .mock:
            return MockConnector(using: credentials)
        }
    }
}
