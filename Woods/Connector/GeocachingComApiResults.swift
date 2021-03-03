//
//  GeocachingComApiResults.swift
//  Woods
//
//  Created by Fredrik on 3/3/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import Foundation

struct GeocachingComApiResults: Codable {
    let results: [Geocache]
    let total: Int
    
    // TODO: Use details URL to query more details?
    
    struct Geocache: Codable {
        let id: Int
        let name: String
        let code: String
        let premiumOnly: Bool?
        let favoritePoints: Int?
        let geocacheType: Int?
        let containerType: Int?
        let difficulty: Double?
        let terrain: Double?
        let userFound: Bool?
        let userDidNotFind: Bool?
        let cacheStatus: Int?
        let postedCoordinates: PostedCoordinates
        let detailsUrl: String?
        let hasGeotour: Bool?
        let hasLogDraft: Bool?
        let placedDate: String?
        let owner: User?
        let lastFoundDate: String?
        
        var parsedGeocacheSize: GeocacheSize? {
            switch containerType {
            case 1?: return .notChosen
            case 2?: return .micro
            case 3?: return .regular
            case 4?: return .large
            case 5?: return .virtual
            case 6?: return .other
            case 8?: return .small
            default: return nil
            }
        }
        var parsedGeocacheType: GeocacheType? {
            switch geocacheType {
            case 2?: return .traditional
            case 3?: return .multi
            case 4?: return .virtual
            case 5?: return .letterbox
            case 6?: return .event
            case 8?: return .mystery
            case 9?: return .projectApe
            case 11?: return .webcam
            case 12?: return .locationless
            case 13?: return .citoEvent
            case 137?: return .earth
            case 453?: return .megaEvent
            case 1304?: return .gpsAdventuresExhibit
            case 1858?: return .wherigo
            case 3653?: return .lostAndFoundEvent
            case 3773?: return .geocachingHq
            case 3774?: return .hqCelebration
            case 4738?: return .groundspeakBlockParty
            case 7005?: return .gigaEvent
            default: return nil
            }
        }
        var parsedGeocacheStatus: GeocacheStatus? {
            switch cacheStatus {
            case 0?: return .enabled
            case 1?: return .disabled
            case 2?: return .archived
            case 3?: return .unpublished
            default: return nil
            }
        }
        var asWaypoint: Waypoint {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            return Waypoint(
                id: code,
                name: name,
                location: postedCoordinates.asCoordinates,
                difficulty: difficulty.map { Int($0 * 2) },
                terrain: terrain.map { Int($0 * 2) },
                geocacheType: parsedGeocacheType,
                geocacheSize: parsedGeocacheSize,
                geocacheStatus: parsedGeocacheStatus,
                owner: owner?.username,
                placedAt: placedDate.flatMap(formatter.date(from:)),
                lastFoundAt: lastFoundDate.flatMap(formatter.date(from:)),
                favorites: favoritePoints ?? 0,
                found: userFound ?? false,
                didNotFind: userDidNotFind ?? false,
                premiumOnly: premiumOnly ?? false
            )
        }
        
        struct PostedCoordinates: Codable {
            let latitude: Double
            let longitude: Double
            
            var asCoordinates: Coordinates {
                Coordinates(latitude: latitude, longitude: longitude)
            }
        }
        
        struct User: Codable {
            let code: String
            let username: String
        }
    }
}
