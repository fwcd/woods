//
//  MockConnector.swift
//  Woods
//
//  Created by Fredrik on 3/1/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import Foundation
import Combine

/// A simple connector that outputs some fake caches for testing.
class MockConnector: Connector {
    func logIn(using credentials: Credentials) -> AnyPublisher<Void, Error> {
        Just(()).weakenError().eraseToAnyPublisher()
    }
    
    func logOut() -> AnyPublisher<Void, Error> {
        Just(()).weakenError().eraseToAnyPublisher()
    }
    
    func geocaches(for query: GeocacheQuery) -> AnyPublisher<[Geocache], Error> {
        Just([]).weakenError().eraseToAnyPublisher()
    }
}
