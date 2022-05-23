//
//  WaypointType.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik.
//

enum WaypointType: String, Codable, Hashable, CaseIterable {
    case waypoint
    case traditionalCache
    case multiCache
    case mysteryCache
    case virtualCache
    case webcamCache
    case earthCache
    case letterbox
    case wherigo
    case event
    case megaEvent
    case gigaEvent
    case lostAndFoundEvent
    case citoEvent
    case projectApeCache
    case otherCache
    case geocachingHq
    case gpsAdventuresExhibit
    case groundspeakBlockParty
    case hqCelebration
    case locationlessCache
    
    var name: String {
        switch self {
        case .waypoint: return "Waypoint"
        case .traditionalCache: return "Traditional Cache"
        case .multiCache: return "Multi Cache"
        case .mysteryCache: return "Mystery Cache"
        case .virtualCache: return "Virtual Cache"
        case .webcamCache: return "Webcam Cache"
        case .earthCache: return "Earth Cache"
        case .letterbox: return "Letterbox"
        case .wherigo: return "Wherigo"
        case .event: return "Event"
        case .megaEvent: return "Mega Event"
        case .gigaEvent: return "Giga Event"
        case .lostAndFoundEvent: return "Lost+Found Event"
        case .citoEvent: return "CITO Event"
        case .projectApeCache: return "Project APE Cache"
        case .otherCache: return "Other Cache"
        case .geocachingHq: return "Geocaching HQ"
        case .gpsAdventuresExhibit: return "GPS Adventures Exhibit"
        case .groundspeakBlockParty: return "Groundspeak Block Party"
        case .hqCelebration: return "HQ Celebration"
        case .locationlessCache: return "Locationless Cache"
        }
    }
}
