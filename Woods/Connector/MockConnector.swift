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
    
    func geocaches(for query: GeocachesInRadiusQuery) -> AnyPublisher<[Geocache], Error> {
        Just([
            Geocache(id: "MOCK1", name: "Test Cache", location: Coordinates(latitude: 52.50733, longitude: 13.42806)),
            Geocache(id: "MOCK2", name: "Lake View", location: Coordinates(latitude: 51.30563, longitude: 7.94576)),
            Geocache(id: "MOCK3", name: "Mountain Views", location: Coordinates(latitude: 46.89705, longitude: 7.97048)),
            Geocache(id: "MOCK4", name: "Ferry to Oslo", location: Coordinates(latitude: 54.32851, longitude: 10.15303))
        ]).weakenError().eraseToAnyPublisher()
    }
}
