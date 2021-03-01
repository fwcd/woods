//
//  Connector.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import Combine

protocol Connector: AnyObject {
    func logIn(using credentials: Credentials) -> AnyPublisher<Void, Error>
    
    func logOut() -> AnyPublisher<Void, Error>
    
    func geocaches(for query: GeocacheQuery) -> AnyPublisher<[Geocache], Error>
}
