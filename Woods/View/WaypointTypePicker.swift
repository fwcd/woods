//
//  WaypointTypePicker.swift
//  Woods
//
//  Created by Fredrik on 24.05.22.
//

import SwiftUI

struct WaypointTypePicker: View {
    @Binding var type: WaypointType
    
    var body: some View {
        Picker(selection: $type, label: Text("Waypoint Type")) {
            ForEach(WaypointType.allCases, id: \.self) { type in
                WaypointTypeView(type: type)
                    .foregroundColor(.red)
            }
        }
        .pickerStyle(MenuPickerStyle())
    }
}

struct WaypointTypePicker_Previews: PreviewProvider {
    @State private static var type: WaypointType = .waypoint
    static var previews: some View {
        WaypointTypePicker(type: $type)
    }
}
