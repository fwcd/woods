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
        case .webcamCache:
            return "camera.aperture"
        case .earthCache:
            return "globe.europe.africa.fill"
        case .event,
             .megaEvent,
             .gigaEvent,
             .hqCelebration,
             .groundspeakBlockParty:
            return "bubble.right.fill"
        case .citoEvent,
             .lostAndFoundEvent:
            return "arrow.3.trianglepath"
        case .geocachingHq:
            return "house.fill"
        default:
            return "archivebox.fill"
        }
    }
}

struct WaypointTypeIcon_Previews: PreviewProvider {
    static var previews: some View {
        List(WaypointType.allCases, id: \.self) { type in
            HStack {
                Image(systemName: type.iconName)
                    .font(.title)
                Text(type.name)
            }
        }
    }
}
