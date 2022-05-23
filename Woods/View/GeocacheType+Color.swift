//
//  GeocacheType+Color.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

extension WaypointType {
    var color: Color {
        switch self {
        case .traditionalCache:
            return .green
        case .multiCache:
            return .orange
        case .mysteryCache:
            return .blue
        case .virtualCache:
            return .white
        case .webcamCache:
            return .gray
        case .earthCache:
            return .yellow
        case .letterbox:
            return .blue
        case .wherigo:
            return .blue
        case .event:
            return .red
        case .megaEvent:
            return .red
        default:
            return .black
        }
    }
}
