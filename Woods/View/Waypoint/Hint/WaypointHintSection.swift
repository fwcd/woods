//
//  WaypointHintSection.swift
//  Woods
//
//  Created by Fredrik on 02.03.23.
//

import SwiftUI

struct WaypointHintSection: View {
    let hint: String
    
    var body: some View {
        SimpleSection {
            Text(hint)
                .textSelection(.enabled)
        } header: {
            Label("Hint", systemImage: "lightbulb.fill")
        }
    }
}

struct WaypointHintSection_Previews: PreviewProvider {
    static var previews: some View {
        WaypointHintSection(hint: "Under the tree")
    }
}
