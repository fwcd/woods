//
//  WaypointDescriptionSection.swift
//  Woods
//
//  Created by Fredrik on 02.03.23.
//

import SwiftUI

struct WaypointDescriptionSection: View {
    let description: String
    
    var body: some View {
        SimpleSection {
            LightHTMLView(html: description)
        } header: {
            Label("Description", systemImage: "newspaper.fill")
        }
    }
}

struct WaypointDescriptionSection_Previews: PreviewProvider {
    static var previews: some View {
        WaypointDescriptionSection(description: "The quick brown fox jumps over the lazy dog")
    }
}
