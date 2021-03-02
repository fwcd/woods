//
//  WaypointLogType.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

enum WaypointLogType: String, Codable, Hashable {
    case found
    case didNotFind
    case note
    case willAttend
    case attended
    case webcamPhotoTaken
    case updateCoordinates
    case published
    case retracted
    case archived
    case unarchived
    case disabled
    case enabled
    case reviewerNote
    case needsMaintenance
    case needsArchived
    case ownerMaintenance
    
    var displayName: String {
        switch self {
        case .found: return "Found"
        case .didNotFind: return "Did not find"
        case .note: return "Note"
        case .willAttend: return "Will attend"
        case .attended: return "Attended"
        case .webcamPhotoTaken: return "Webcam photo taken"
        case .updateCoordinates: return "Update coordinates"
        case .published: return "Published"
        case .retracted: return "Retracted"
        case .archived: return "Archived"
        case .unarchived: return "Unarchived"
        case .disabled: return "Disabled"
        case .enabled: return "Enabled"
        case .reviewerNote: return "Reviewer note"
        case .needsMaintenance: return "Needs maintenance"
        case .needsArchived: return "Needs archived"
        case .ownerMaintenance: return "Owner maintenance"
        }
    }
    
    var emoji: String {
        switch self {
        case .found: return "😀"
        case .didNotFind: return "🥶"
        case .note: return "📝"
        case .willAttend: return "💭"
        case .attended: return "💬"
        case .webcamPhotoTaken: return "📸"
        case .updateCoordinates: return "↗️"
        case .published: return "🟢"
        case .retracted: return "🔴"
        case .archived: return "🟥"
        case .unarchived: return "🟩"
        case .disabled: return "🛑"
        case .enabled: return "✅"
        case .reviewerNote: return "📘"
        case .needsMaintenance: return "❗️"
        case .needsArchived: return "‼️"
        case .ownerMaintenance: return "♻️"
        }
    }
}
