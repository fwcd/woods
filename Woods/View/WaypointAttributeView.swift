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
    var size: CGFloat = 45
    
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
        let symbolName = symbolName ?? "questionmark"
        let cornerRadius = size / 4
        let lineWidth = size / 12
        let diagOffset = cornerRadius / 2 - lineWidth / 2
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(.black)
                .frame(width: size, height: size)
            Image(systemName: symbolName)
                .font(.system(size: size / 2))
                .foregroundColor(.white)
            if negated {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(.red, lineWidth: lineWidth)
                    .frame(width: size, height: size)
                Path { path in
                    path.move(to: CGPoint(x: diagOffset, y: diagOffset))
                    path.addLine(to: CGPoint(x: size - diagOffset, y: size - diagOffset))
                    path.closeSubpath()
                }
                .stroke(.red, lineWidth: lineWidth)
                .frame(width: size, height: size)
            }
        }
    }
}

struct WaypointAttributeView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach([false, true], id: \.self) { negated in
            List(WaypointAttribute.allCases, id: \.self) { attribute in
                HStack {
                    WaypointAttributeView(attribute: attribute, negated: negated)
                    Text(attribute.name)
                }
            }
        }
    }
}
