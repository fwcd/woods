//
//  GeocacheLogView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import SwiftUI

struct GeocacheLogView: View {
    let geocacheLog: GeocacheLog
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(geocacheLog.username)
                .font(.headline)
            Text("\(geocacheLog.type.emoji) \(geocacheLog.type.displayName) on \(format(date: geocacheLog.timestamp))")
                .font(.subheadline)
            Text(geocacheLog.content)
        }
    }
    
    func format(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        return formatter.string(from: date)
    }
}

struct GeocacheLogView_Previews: PreviewProvider {
    static var previews: some View {
        GeocacheLogView(geocacheLog: GeocacheLog(type: .found, username: "Alice", content: "Very nice cache, thanks!"))
    }
}
