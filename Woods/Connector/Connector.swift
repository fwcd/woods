//
//  Connector.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

protocol Connector {
    func logIn(using credentials: Credentials) throws
    
    func logOut() throws
    
    func geocaches(for query: GeocacheQuery) throws -> [Geocache]
}
