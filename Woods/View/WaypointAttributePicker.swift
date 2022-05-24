//
//  WaypointAttributePicker.swift
//  Woods
//
//  Created by Fredrik on 24.05.22.
//

import SwiftUI

struct WaypointAttributePicker: View {
    @Binding var selection: WaypointAttribute
    @Binding var isEnabled: Bool
    
    var body: some View {
        Menu {
            ForEach(WaypointAttribute.allCases, id: \.self) { attribute in
                Button {
                    if selection == attribute {
                        isEnabled = !isEnabled
                    } else {
                        selection = attribute
                    }
                } label: {
                    Text(attribute.name)
                    WaypointAttributeView(attribute: attribute)
                }
            }
        } label: {
            WaypointAttributeView(attribute: selection, isEnabled: isEnabled)
        }
    }
}

struct WaypointAttributePicker_Previews: PreviewProvider {
    @State private static var attribute: WaypointAttribute = .bicycles
    @State private static var isEnabled: Bool = true
    static var previews: some View {
        WaypointAttributePicker(selection: $attribute, isEnabled: $isEnabled)
    }
}
