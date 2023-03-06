//
//  GeocachingComApiResults.swift
//  Woods
//
//  Created by Fredrik on 3/3/21.
//  Copyright © 2021 Fredrik.
//

import Foundation

enum GeocachingComApi {
    // TODO: Use details URL to query more details?
    
    struct Results: Codable {
        let results: [Geocache]
        let total: Int
    }
    
    struct GeocacheType: RawRepresentable, Codable, Hashable {
        let rawValue: Int

        static let traditionalCache = Self(rawValue: 2)
        static let multiCache = Self(rawValue: 3)
        static let virtualCache = Self(rawValue: 4)
        static let letterbox = Self(rawValue: 5)
        static let event = Self(rawValue: 6)
        static let mysteryCache = Self(rawValue: 8)
        static let projectApeCache = Self(rawValue: 9)
        static let webcamCache = Self(rawValue: 11)
        static let locationlessCache = Self(rawValue: 12)
        static let citoEvent = Self(rawValue: 13)
        static let earthCache = Self(rawValue: 137)
        static let megaEvent = Self(rawValue: 453)
        static let gpsAdventuresExhibit = Self(rawValue: 1304)
        static let wherigo = Self(rawValue: 1858)
        static let lostAndFoundEvent = Self(rawValue: 3653)
        static let geocachingHq = Self(rawValue: 3773)
        static let hqCelebration = Self(rawValue: 3774)
        static let groundspeakBlockParty = Self(rawValue: 4738)
        static let gigaEvent = Self(rawValue: 7005)
    }

    struct ContainerType: RawRepresentable, Codable, Hashable {
        let rawValue: Int

        static let notChosen = Self(rawValue: 1)
        static let micro = Self(rawValue: 2)
        static let regular = Self(rawValue: 3)
        static let large = Self(rawValue: 4)
        static let virtual = Self(rawValue: 5)
        static let other = Self(rawValue: 6)
        static let small = Self(rawValue: 8)
    }

    struct GeocacheStatus: RawRepresentable, Codable, Hashable {
        let rawValue: Int

        static let enabled = Self(rawValue: 0)
        static let disabled = Self(rawValue: 1)
        static let archived = Self(rawValue: 2)
        static let unpublished = Self(rawValue: 3)
    }

    struct LogType: RawRepresentable, Codable, Hashable {
        let rawValue: Int

        static let found = Self(rawValue: 2)
        static let didNotFind = Self(rawValue: 3)
        static let note = Self(rawValue: 4)
        static let needsArchived = Self(rawValue: 7)
        static let archived = Self(rawValue: 5)
        static let willAttend = Self(rawValue: 9)
        static let attended = Self(rawValue: 10)
        static let webcamPhotoTaken = Self(rawValue: 11)
        static let unarchived = Self(rawValue: 12)
        static let reviewerNote = Self(rawValue: 18)
        static let disabled = Self(rawValue: 22)
        static let enabled = Self(rawValue: 23)
        static let published = Self(rawValue: 24)
        static let retracted = Self(rawValue: 25)
        static let needsMaintenance = Self(rawValue: 45)
        static let ownerMaintenance = Self(rawValue: 46)
        static let updateCoordinates = Self(rawValue: 47)
    }
    
    struct PostedCoordinates: Codable {
        var latitude: Double = 0
        var longitude: Double = 0
    }
    
    struct Geocache: Codable {
        let id: Int?
        let name: String
        let code: String
        let premiumOnly: Bool?
        let favoritePoints: Int?
        let geocacheType: GeocacheType?
        let containerType: ContainerType?
        let difficulty: Double?
        let terrain: Double?
        let userFound: Bool?
        let userDidNotFind: Bool?
        let cacheStatus: GeocacheStatus?
        let postedCoordinates: PostedCoordinates?
        let detailsUrl: String?
        let hasGeotour: Bool?
        let hasLogDraft: Bool?
        let placedDate: IsoDateTimeWithoutZCodable?
        let owner: User?
        let lastFoundDate: IsoDateTimeWithoutZCodable?
        
        // Details:
        
        let description: String?
        let hint: String?
        let totalActivities: Int?
        let recentActivities: [Activity]?
        let attributes: [Attribute]?
        
        struct User: Codable {
            let code: String?
            let username: String
            let avatar: String?
        }
        
        struct Activity: Codable {
            let activityTypeId: LogType?
            let text: String?
            let owner: User?
            let code: String?
            let dateCreatedUtc: IsoDateTimeWithoutZCodable?
            let dateLastUpdatedUtc: IsoDateTimeWithoutZCodable?
            let logDate: String?
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
    
    struct LogPost: Codable {
        var geocache: Geocache?
        @StringCodable var logType: LogType
        var ownerIsViewing: Bool?
        var logDate: IsoDateCodable?
        var logText: String?
        var dateTimeCreatedUtc: IsoDateTimeWithoutZCodable? = nil
        var dateTimeLastUpdatedUtc: IsoDateTimeWithoutZCodable? = nil
        var guid: String? = nil
        
        struct Geocache: Codable {
            var id: Int?
            var referenceCode: String?
            var postedCoordinates: PostedCoordinates? = .init()
            var callerSpecific: CallerSpecific? = .init()
            
            struct CallerSpecific: Codable {
                var favorited: Bool = false
            }
        }
    }
}

extension WaypointType {
    init?(_ apiType: GeocachingComApi.GeocacheType) {
        switch apiType {
        case .traditionalCache: self = .traditionalCache
        case .multiCache: self = .multiCache
        case .virtualCache: self = .virtualCache
        case .letterbox: self = .letterbox
        case .event: self = .event
        case .mysteryCache: self = .mysteryCache
        case .projectApeCache: self = .projectApeCache
        case .webcamCache: self = .webcamCache
        case .locationlessCache: self = .locationlessCache
        case .citoEvent: self = .citoEvent
        case .earthCache: self = .earthCache
        case .megaEvent: self = .megaEvent
        case .gpsAdventuresExhibit: self = .gpsAdventuresExhibit
        case .wherigo: self = .wherigo
        case .lostAndFoundEvent: self = .lostAndFoundEvent
        case .geocachingHq: self = .geocachingHq
        case .hqCelebration: self = .hqCelebration
        case .groundspeakBlockParty: self = .groundspeakBlockParty
        case .gigaEvent: self = .gigaEvent
        default: return nil
        }
    }
}

extension GeocacheSize {
    init?(_ apiSize: GeocachingComApi.ContainerType) {
        switch apiSize {
        case .notChosen: self = .notChosen
        case .micro: self = .micro
        case .regular: self = .regular
        case .large: self = .large
        case .virtual: self = .virtual
        case .other: self = .other
        case .small: self = .small
        default: return nil
        }
    }
}

extension WaypointStatus {
    init?(_ apiStatus: GeocachingComApi.GeocacheStatus) {
        switch apiStatus {
        case .enabled: self = .enabled
        case .disabled: self = .disabled
        case .archived: self = .archived
        case .unpublished: self = .unpublished
        default: return nil
        }
    }
}

extension WaypointLogType {
    init?(_ apiLogType: GeocachingComApi.LogType) {
        switch apiLogType {
        case .found: self = .found
        case .didNotFind: self = .didNotFind
        case .note: self = .note
        case .needsArchived: self = .needsArchived
        case .archived: self = .archived
        case .willAttend: self = .willAttend
        case .attended: self = .attended
        case .webcamPhotoTaken: self = .webcamPhotoTaken
        case .unarchived: self = .unarchived
        case .reviewerNote: self = .reviewerNote
        case .disabled: self = .disabled
        case .enabled: self = .enabled
        case .published: self = .published
        case .retracted: self = .retracted
        case .needsMaintenance: self = .needsMaintenance
        case .ownerMaintenance: self = .ownerMaintenance
        case .updateCoordinates: self = .updateCoordinates
        default: return nil
        }
    }
}

extension Waypoint {
    init?(_ apiCache: GeocachingComApi.Geocache) {
        guard let location = apiCache.postedCoordinates.map(Coordinates.init) else { return nil }
        self.init(
            id: apiCache.code,
            name: apiCache.name,
            location: location,
            difficulty: apiCache.difficulty.map { Int($0 * 2) },
            terrain: apiCache.terrain.map { Int($0 * 2) },
            type: apiCache.geocacheType.flatMap(WaypointType.init) ?? .otherCache,
            geocacheSize: apiCache.containerType.flatMap(GeocacheSize.init),
            status: apiCache.cacheStatus.flatMap(WaypointStatus.init),
            attributes: Dictionary(
                uniqueKeysWithValues: apiCache.attributes?
                    .compactMap { attribute in
                        attribute.asWaypointAttribute.map { ($0, attribute.isApplicable) }
                    } ?? []
            ),
            owner: apiCache.owner?.username,
            placedAt: apiCache.placedDate?.wrappedValue,
            lastFoundAt: apiCache.lastFoundDate?.wrappedValue,
            favorites: apiCache.favoritePoints ?? 0,
            found: apiCache.userFound ?? false,
            didNotFind: apiCache.userDidNotFind ?? false,
            premiumOnly: apiCache.premiumOnly ?? false,
            description: apiCache.description,
            hint: apiCache.hint,
            webUrl: URL(string: "https://coord.info/\(apiCache.code)"),
            logs: apiCache.recentActivities?.compactMap(WaypointLog.init) ?? [],
            fetchableViaAccountTypes: [.geocachingCom]
        )
    }
}

extension WaypointLog {
    init?(_ apiLog: GeocachingComApi.Geocache.Activity) {
        guard let type = apiLog.activityTypeId.flatMap(WaypointLogType.init) else { return nil }
        self.init(
            type: type,
            createdAt: apiLog.dateCreatedUtc?.wrappedValue,
            lastEditedAt: apiLog.dateLastUpdatedUtc?.wrappedValue,
            username: apiLog.owner?.username ?? "",
            content: apiLog.text ?? ""
        )
    }
    
    init?(_ apiLogPost: GeocachingComApi.LogPost) {
        guard let type = WaypointLogType(apiLogPost.logType),
              let id = apiLogPost.guid.flatMap(UUID.init(uuidString:)) else { return nil }
        self.init(
            id: id,
            type: type,
            createdAt: apiLogPost.dateTimeCreatedUtc?.wrappedValue,
            lastEditedAt: apiLogPost.dateTimeLastUpdatedUtc?.wrappedValue,
            username: "",
            content: apiLogPost.logText ?? ""
        )
    }
}

extension Coordinates {
    init(_ coordinates: GeocachingComApi.PostedCoordinates) {
        self.init(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
}

extension GeocachingComApi.LogType {
    init(_ logType: WaypointLogType) {
        switch logType {
        case .found: self = .found
        case .didNotFind: self = .didNotFind
        case .note: self = .note
        case .needsArchived: self = .needsArchived
        case .archived: self = .archived
        case .willAttend: self = .willAttend
        case .attended: self = .attended
        case .webcamPhotoTaken: self = .webcamPhotoTaken
        case .unarchived: self = .unarchived
        case .reviewerNote: self = .reviewerNote
        case .disabled: self = .disabled
        case .enabled: self = .enabled
        case .published: self = .published
        case .retracted: self = .retracted
        case .needsMaintenance: self = .needsMaintenance
        case .ownerMaintenance: self = .ownerMaintenance
        case .updateCoordinates: self = .updateCoordinates
        }
    }
}

extension GeocachingComApi.LogType: LosslessStringConvertible {
    var description: String {
        String(rawValue)
    }
    
    init?(_ description: String) {
        guard let rawValue = Int(description) else { return nil }
        self.rawValue = rawValue
    }
}

extension GeocachingComApi.LogPost {
    init(_ log: WaypointLog, for waypoint: Waypoint) {
        self.init(
            geocache: .init(waypoint),
            logType: GeocachingComApi.LogType(log.type),
            ownerIsViewing: log.username == waypoint.owner,
            logDate: .init(wrappedValue: log.timestamp),
            logText: log.content
        )
    }
}

extension GeocachingComApi.LogPost.Geocache {
    init(_ waypoint: Waypoint) {
        self.init(id: gcCacheId(gcCode: waypoint.id), referenceCode: waypoint.id)
    }
}
