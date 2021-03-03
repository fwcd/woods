//
//  WaypointLogView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
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
                    Text("\(waypointLog.type.displayName) on \(format(date: waypointLog.timestamp))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            LightHTMLView(html: waypointLog.content)
                .lineLimit(nil)
        }
    }
    
    func format(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        return formatter.string(from: date)
    }
}

struct WaypointLogView_Previews: PreviewProvider {
    static var previews: some View {
        WaypointLogView(waypointLog: WaypointLog(type: .found, username: "Alice", content: "Very nice cache, thanks!"))
    }
}
