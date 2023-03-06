//
//  WaypointType+Icon.swift
//  Woods
//
//  Created by Fredrik on 24.05.22.
//

import SwiftUI

extension WaypointType {
    var iconName: String {
        switch self {
        case .waypoint:
            return "flag.fill"
        case .mysteryCache:
            return "questionmark"
        case .virtualCache:
            return "cube.transparent"
        case .webcamCache:
            return "web.camera"
        case .earthCache:
            return "globe.europe.africa.fill"
        case .letterbox:
            return "tray.full.fill"
        case .wherigo:
            return "play.circle"
        case .event,
             .hqCelebration,
             .groundspeakBlockParty:
            return "bubble.left.fill"
        case .megaEvent:
            return "exclamationmark.bubble.fill"
        case .gigaEvent:
            return "star.bubble.fill"
        case .citoEvent,
             .lostAndFoundEvent:
            return "arrow.3.trianglepath"
        case .projectApeCache:
            return "pawprint.fill"
        case .geocachingHq:
            return "house.fill"
        case .otherCache:
            return "questionmark"
        case .locationlessCache:
            return "flag.checkered"
        default:
            return "archivebox.fill"
        }
    }
}

struct WaypointTypeIcon_Previews: PreviewProvider {
    static var previews: some View {
        List(WaypointType.allCases, id: \.self) { type in
            Label {
                Text(type.name)
            } icon: {
                Image(systemName: type.iconName)
                    .font(.title)
                    .foregroundColor(type.color)
            }
        }
    }
}
