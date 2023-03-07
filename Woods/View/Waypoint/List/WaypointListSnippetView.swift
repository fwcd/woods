//
//  WaypointListSnippetView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

struct WaypointListSnippetView: View {
    let list: WaypointList
    
    var body: some View {
        Label {
            Text(list.name)
        } icon: {
            Image(systemName: "list.bullet")
        }
    }
}

struct WaypointListSnippetView_Previews: PreviewProvider {
    static var previews: some View {
        WaypointListSnippetView(list: WaypointList(name: "Test"))
    }
}
