//
//  WaypointLogView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

struct WaypointLogView: View {
    let waypointLog: WaypointLog
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(waypointLog.type.emoji)
                    .font(.title2)
                VStack(alignment: .leading) {
                    Text(waypointLog.username)
                        .font(.headline)
                        .textSelection(.enabled)
                    let dateSuffix = (waypointLog.timestamp ?? waypointLog.createdAt).map {
                        " on \(DateFormatter.standard().string(from: $0))"
                    } ?? ""
                    Text("\(waypointLog.type.displayName)\(dateSuffix)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            LightHTMLView(html: waypointLog.content)
        }
    }
}

struct WaypointLogView_Previews: PreviewProvider {
    static var previews: some View {
        WaypointLogView(waypointLog: WaypointLog(type: .found, username: "Alice", content: "Very nice cache, thanks!"))
    }
}
