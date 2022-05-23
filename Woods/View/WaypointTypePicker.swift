//
//  WaypointTypePicker.swift
//  Woods
//
//  Created by Fredrik on 24.05.22.
//

import SwiftUI

struct WaypointTypePicker: View {
    @Binding var selection: WaypointType
    
    var body: some View {
        Menu {
            ForEach(WaypointType.allCases, id: \.self) { type in
                Button {
                    selection = type
                } label: {
                    Text(type.name)
                    WaypointTypeView(type: type)
                }
            }
        } label: {
            WaypointTypeView(type: selection)
        }
    }
}

struct WaypointTypePicker_Previews: PreviewProvider {
    @State private static var type: WaypointType = .waypoint
    static var previews: some View {
        WaypointTypePicker(selection: $type)
    }
}
