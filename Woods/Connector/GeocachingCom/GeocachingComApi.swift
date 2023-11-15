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
    
    struct Coordinates: Codable {
        var latitude: Double = 0
        var longitude: Double = 0
    }
    
    struct Geocache: Codable {
        var id: Int?
        var name: String
        var code: String
        var premiumOnly: Bool?
        var favoritePoints: Int?
        var geocacheType: GeocacheType?
        var containerType: ContainerType?
        var difficulty: Double?
        var terrain: Double?
        var userFound: Bool?
        var userDidNotFind: Bool?
        var cacheStatus: GeocacheStatus?
        var postedCoordinates: Coordinates?
        var userCorrectedCoordinates: Coordinates?
        var detailsUrl: String?
        var hasGeotour: Bool?
        var hasLogDraft: Bool?
        var owner: User?
        @CustomCodable<IsoDateTimeWithoutZCoding?> var placedDate: Date?
        @CustomCodable<IsoDateTimeWithoutZCoding?> var lastFoundDate: Date?
        
        // Details:
        
        var description: String?
        var hint: String?
        var totalActivities: Int?
        var recentActivities: [Activity]?
        var attributes: [Attribute]?
        
        struct User: Codable {
            var code: String?
            var username: String
            var avatar: String?
        }
        
        struct Activity: Codable {
            var activityTypeId: LogType?
            var text: String?
            var owner: User?
            var code: String?
            @CustomCodable<IsoDateTimeWithoutZCoding?> var dateCreatedUtc: Date?
            @CustomCodable<IsoDateTimeWithoutZCoding?> var dateLastUpdatedUtc: Date?
            @CustomCodable<IsoDateTimeWithoutZCoding?> var logDate: Date?
        }
        
        struct Attribute: Codable {
            var id: Int
            var name: String
            var isApplicable: Bool
            
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
            var username: String?
            var referenceCode: String?
            var userType: String?
            var isLoggedIn: Bool
            var roles: [String]?
            var publicGuid: String?
            var avatarUrl: URL?
        }
    }
    
    struct NewLog: Codable {
        var geocache: Geocache?
        @CustomCodable<StringCoding> var logType: LogType
        @CustomCodable<IsoDateCoding?> var logDate: Date?
        var logText: String?
        
        struct Geocache: Codable {
            var id: Int?
            var referenceCode: String?
            var postedCoordinates: Coordinates? = nil
        }
    }
    
    struct PostedLog: Codable {
        @CustomCodable<IsoDateTimeWithoutZCoding?> var logDate: Date?
        @CustomCodable<IsoDateTimeWithoutZCoding?> var dateTimeCreatedUtc: Date? = nil
        @CustomCodable<IsoDateTimeWithoutZCoding?> var dateTimeLastUpdatedUtc: Date? = nil
        var logText: String?
        var logType: String? // Strangely the log type seems to be encoded as string here, e.g. 'Write note'
        var guid: String? = nil
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
    init?(_ apiCache: GeocachingComApi.Geocache, username: String? = nil) {
        // TODO: Add support for corrected coordinates in Waypoint model
        guard let location = (apiCache.userCorrectedCoordinates ?? apiCache.postedCoordinates).map(Coordinates.init) else { return nil }
        self.init(
            id: apiCache.code,
            name: apiCache.name,
            location: location,
            locationIsUserCorrected: apiCache.userCorrectedCoordinates != nil,
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
            placedAt: apiCache.placedDate,
            lastFoundAt: apiCache.lastFoundDate,
            favorites: apiCache.favoritePoints ?? 0,
            found: apiCache.userFound ?? false,
            didNotFind: apiCache.userDidNotFind ?? false,
            owned: username.map { apiCache.owner?.username == $0 } ?? false,
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
            date: apiLog.logDate,
            createdAt: apiLog.dateCreatedUtc,
            lastEditedAt: apiLog.dateLastUpdatedUtc,
            username: apiLog.owner?.username ?? "",
            content: apiLog.text ?? ""
        )
    }
    
    init?(_ apiLog: GeocachingComApi.PostedLog) {
        guard let id = apiLog.guid.flatMap(UUID.init(uuidString:)) else { return nil }
        self.init(
            id: id,
            date: apiLog.logDate,
            createdAt: apiLog.dateTimeCreatedUtc,
            lastEditedAt: apiLog.dateTimeLastUpdatedUtc,
            username: "",
            content: apiLog.logText ?? ""
        )
    }
}

extension Coordinates {
    init(_ coordinates: GeocachingComApi.Coordinates) {
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

extension GeocachingComApi.NewLog {
    init(_ log: WaypointLog, for waypointId: String) {
        self.init(
            geocache: .init(waypointId: waypointId),
            logType: GeocachingComApi.LogType(log.type),
            logDate: log.date,
            logText: log.content
        )
    }
}

extension GeocachingComApi.NewLog.Geocache {
    init(waypointId: String) {
        self.init(
            id: gcCacheId(gcCode: waypointId),
            referenceCode: waypointId
        )
    }
}
