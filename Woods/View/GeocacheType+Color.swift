//
//  GeocacheType+Color.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

extension GeocacheType {
    var color: Color {
        switch self {
        case .traditional:
            return .green
        case .multi:
            return .orange
        case .mystery:
            return .blue
        case .virtual:
            return .white
        case .webcam:
            return .gray
        case .earth:
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
