//
//  MockGeocaches.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

func mockGeocaches() -> [Geocache] {
    [
        Geocache(
            id: "MOCK1",
            name: "Test Cache",
            location: Coordinates(latitude: 52.50733, longitude: 13.42806),
            difficulty: 2,
            terrain: 3,
            type: .traditional
        ),
        Geocache(
            id: "MOCK2",
            name: "Lake View",
            location: Coordinates(latitude: 51.30563, longitude: 7.94576),
            difficulty: 2,
            terrain: 4,
            type: .multi
        ),
        Geocache(
            id: "MOCK3",
            name: "Mountain Views",
            location: Coordinates(latitude: 46.89705, longitude: 7.97048),
            difficulty: 10,
            terrain: 10,
            type: .earth
        ),
        Geocache(
            id: "MOCK4",
            name: "Ferry to Oslo",
            location: Coordinates(latitude: 54.32851, longitude: 10.15303),
            difficulty: 5,
            terrain: 10,
            type: .mystery
        ),
    ]
}
