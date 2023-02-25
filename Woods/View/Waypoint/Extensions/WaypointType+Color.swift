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
        case .traditionalCache, .citoEvent:
            return .green
        case .multiCache:
            return .orange
        case .mysteryCache:
            return .blue
        case .virtualCache:
            return .init(white: 0.9)
        case .webcamCache, .locationlessCache:
            return .gray
        case .earthCache:
            return .yellow
        case .letterbox:
            return .init(red: 0.2, green: 0.9, blue: 1)
        case .wherigo:
            return .init(red: 0, green: 0, blue: 0.7)
        case .event, .megaEvent, .gigaEvent,
             .lostAndFoundEvent, .hqCelebration, .groundspeakBlockParty:
            return .init(red: 0.7, green: 0, blue: 0)
        default:
            return .primary
        }
    }
}

struct WaypointTypeColor_Previews: PreviewProvider {
    static var previews: some View {
        List(WaypointType.allCases, id: \.self) { type in
            Label {
                Text(type.name)
            } icon: {
                RoundedRectangle(cornerRadius: 5)
                    .fill(type.color)
                    .frame(width: 30, height: 30)
            }
        }
    }
}
