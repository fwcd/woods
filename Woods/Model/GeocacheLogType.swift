//
//  GeocacheLogType.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

enum GeocacheLogType: String, Codable, Hashable {
    case found
    case didNotFind
    case note
    case willAttend
    case attended
    case webcamPhotoTaken
    case updateCoordinates
    case published
    case archived
    case disabled
    case enabled
    case reviewerNote
    case needsMaintenance
    case ownerMaintenance
}
