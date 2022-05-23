//
//  WaypointType.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik.
//

enum WaypointType: String, Codable, Hashable {
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
    case projectApe
    case otherCache
    case geocachingHq
    case gpsAdventuresExhibit
    case groundspeakBlockParty
    case hqCelebration
    case locationlessCache
}
