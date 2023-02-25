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
        HStack {
            Image(systemName: "list.bullet")
            VStack {
                Text(list.name)
                    .font(.headline)
            }
        }
    }
}

struct WaypointListSnippetView_Previews: PreviewProvider {
    static var previews: some View {
        WaypointListSnippetView(list: WaypointList(name: "Test"))
    }
}