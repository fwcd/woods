//
//  WaypointTypeView.swift
//  Woods
//
//  Created by Fredrik on 24.05.22.
//

import SwiftUI

struct WaypointTypeView: View {
    let type: WaypointType
    
    var body: some View {
        Image(systemName: type.iconName)
            .foregroundColor(type.color)
            .font(.title)
    }
}

struct WaypointTypeView_Previews: PreviewProvider {
    static var previews: some View {
        List(WaypointType.allCases, id: \.self) { type in
            HStack {
                WaypointTypeView(type: type)
                Text(type.name)
            }
        }
    }
}
