//
//  GeocachingComApiResults.swift
//  Woods
//
//  Created by Fredrik on 3/3/21.
//  Copyright © 2021 Fredrik.
//

import Foundation

struct GeocachingComApiResults: Codable {
    let results: [Geocache]
    let total: Int
    
    // TODO: Use details URL to query more details?
    
    struct Geocache: Codable {
        let id: Int?
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
        let postedCoordinates: PostedCoordinates?
        let detailsUrl: String?
        let hasGeotour: Bool?
        let hasLogDraft: Bool?
        let placedDate: String?
        let owner: User?
        let lastFoundDate: String?
        
        // Details:
        
        let description: String?
        let hint: String?
        let totalActivities: Int?
        let recentActivities: [Activity]?
        let attributes: [Attribute]?
        
        var parsedSize: GeocacheSize? {
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
        var parsedType: WaypointType? {
            switch geocacheType {
            case 2?: return .traditionalCache
            case 3?: return .multiCache
            case 4?: return .virtualCache
            case 5?: return .letterbox
            case 6?: return .event
            case 8?: return .mysteryCache
            case 9?: return .projectApe
            case 11?: return .webcamCache
            case 12?: return .locationlessCache
            case 13?: return .citoEvent
            case 137?: return .earthCache
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
        var parsedStatus: WaypointStatus? {
            switch cacheStatus {
            case 0?: return .enabled
            case 1?: return .disabled
            case 2?: return .archived
            case 3?: return .unpublished
            default: return nil
            }
        }
        var asWaypoint: Waypoint? {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime]
            guard let location = postedCoordinates?.asCoordinates else { return nil }
            return Waypoint(
                id: code,
                name: name,
                location: location,
                difficulty: difficulty.map { Int($0 * 2) },
                terrain: terrain.map { Int($0 * 2) },
                type: parsedType ?? .otherCache,
                geocacheSize: parsedSize,
                status: parsedStatus,
                attributes: Dictionary(
                    uniqueKeysWithValues: attributes?
                        .compactMap { attribute in
                            attribute.asWaypointAttribute.map { ($0, attribute.isApplicable) }
                        } ?? []
                ),
                owner: owner?.username,
                placedAt: placedDate.flatMap(formatter.date(from:)),
                lastFoundAt: lastFoundDate.flatMap(formatter.date(from:)),
                favorites: favoritePoints ?? 0,
                found: userFound ?? false,
                didNotFind: userDidNotFind ?? false,
                premiumOnly: premiumOnly ?? false,
                description: description,
                hint: hint,
                webUrl: URL(string: "https://coord.info/\(code)"),
                logs: recentActivities?.compactMap(\.asWaypointLog) ?? []
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
            let code: String?
            let username: String
            let avatar: String?
        }
        
        struct Activity: Codable {
            let activityTypeId: Int?
            let text: String?
            let owner: User?
            let code: String?
            let dateCreatedUtc: String?
            let dateLastUpdatedUtc: String?
            let logDate: String?
            
            var parsedWaypointLogType: WaypointLogType? {
                switch activityTypeId {
                case 2?: return .found
                case 3?: return .didNotFind
                case 4?: return .note
                case 7?: return .needsArchived
                case 5?: return .archived
                case 9?: return .willAttend
                case 10?: return .attended
                case 11?: return .webcamPhotoTaken
                case 12?: return .unarchived
                case 18?: return .reviewerNote
                case 22?: return .disabled
                case 23?: return .enabled
                case 24?: return .published
                case 25?: return .retracted
                case 45?: return .needsMaintenance
                case 46?: return .ownerMaintenance
                case 47?: return .updateCoordinates
                default: return nil
                }
            }
            var asWaypointLog: WaypointLog? {
                let formatter = ISO8601DateFormatter()
                formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                guard let type = parsedWaypointLogType, let text = text else { return nil }
                return WaypointLog(
                    type: type,
                    createdAt: dateCreatedUtc.flatMap(formatter.date(from:)),
                    lastEditedAt: dateLastUpdatedUtc.flatMap(formatter.date(from:)),
                    username: owner?.username ?? "<unknown>",
                    content: text
                )
            }
        }
        
        struct Attribute: Codable {
            let id: Int
            let name: String
            let isApplicable: Bool
            
            var asWaypointAttribute: WaypointAttribute? {
                .init(geocachingComId: id)
            }
        }
    }
    
    struct ServerParameters: Codable {
        enum CodingKeys: String, CodingKey {
            case userInfo = "user:infoo"
        }
        
        let userInfo: UserInfo
        
        struct UserInfo: Codable {
            let username: String?
            let referenceCode: String?
            let userType: String?
            let isLoggedIn: Bool
            let roles: [String]?
            let publicGuid: String?
            let avatarUrl: URL?
        }
    }
}
