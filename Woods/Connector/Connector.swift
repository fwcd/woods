//
//  Connector.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

protocol Connector {
    func signIn(using credentials: Credentials) throws
    
    func signOut() throws
    
    func geocaches(for query: GeocacheQuery) throws -> [Geocache]
}
