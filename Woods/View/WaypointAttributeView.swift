//
//  WaypointAttributeView.swift
//  Woods
//
//  Created by Fredrik on 21.05.22.
//

import SwiftUI

struct WaypointAttributeView: View {
    let attribute: WaypointAttribute
    var negated: Bool = false
    
    private var symbolName: String? {
        switch attribute {
        case .dogs: return "pawprint.fill"
        case .bicycles: return "bicycle"
        case .campfires: return "flame.fill"
        case .wheelchairAvailable: return "figure.roll"
        case .parkingAvailable: return "parkingsign"
        case .publicTransportation: return "bus"
        case .telephoneNearby: return "phone.fill"
        case .fuelNearby: return "fuelpump"
        case .foodNearby: return "takeoutbag.and.cup.and.straw.fill"
        case .accessOrParkingFee: return "dollarsign.circle.fill"
        case .boat: return "ferry.fill"
        case .flashlightRequired: return "flashlight.on.fill"
        case .specialToolRequired: return "wrench.and.screwdriver.fill"
        case .wirelessBeacon: return "wifi"
        default: return nil
        // TODO: More symbols
        }
    }
    
    var body: some View {
        if let symbolName = symbolName {
            Image(systemName: symbolName)
            // TODO: Render negations
        } else {
            Image(systemName: "questionmark") // TODO: Remaining symbols (make it non-optional?)
        }
    }
}

struct WaypointAttributeView_Previews: PreviewProvider {
    static var previews: some View {
        List(WaypointAttribute.allCases, id: \.self) { attribute in
            HStack {
                WaypointAttributeView(attribute: attribute)
                Text(attribute.name)
            }
        }
    }
}
