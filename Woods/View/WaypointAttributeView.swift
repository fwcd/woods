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
        case .dangerousArea: return "drop.triangle"
        case .wirelessBeacon: return "wifi"
        case .ticks: return "ant.fill"
        case .abandonedStructure: return "building.columns"
        case .recommendedForKids: return "person.fill"
        case .recommendedAtNight: return "moon.fill"
        case .scenicView: return "binoculars.fill"
        case .parkAndGrab: return "parkingsign.circle.fill"
        case .significantHike: return "figure.walk"
        case .nightCache: return "moon.stars.fill"
        case .availableDuringWinter: return "snowflake"
        case .stealthRequired: return "theatermasks.fill"
        case .fieldPuzzle: return "puzzlepiece.extension.fill"
        case .needsMaintenance: return "wrench.fill"
        case .watchForLivestock: return "hare.fill"
        case .touristFriendly: return "suitcase.fill"
        case .seasonalAccess: return "thermometer.sun"
        default: return nil
        // TODO: More symbols
        }
    }
    
    private var backgroundColor: Color {
        switch attribute {
        case .needsMaintenance: return .init(red: 0.5, green: 0, blue: 0)
        default: return .black
        }
    }
    
    private var abbreviation: String {
        switch attribute {
        case .shortHike: return "< 1 km"
        case .mediumHike: return "1-10 km"
        case .longHike: return "> 10 km"
        case .takesLessThanAnHour: return "< 1h"
        case .availableAtAllTimes: return "24/7"
        default:
            return attribute.name
                .split(separator: " ")
                .compactMap { $0.first?.uppercased() }
                .joined()
        }
    }
    
    var body: some View {
        let cornerRadius = size / 4
        let lineWidth = size / 12
        let diagOffset = cornerRadius / 2 - lineWidth / 2
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(backgroundColor)
            Group {
                if let symbolName = symbolName {
                    Image(systemName: symbolName)
                } else {
                    Text(abbreviation)
                        .padding(4)
                }
            }
            .font(.system(size: size / 2))
            .foregroundColor(.white)
            .minimumScaleFactor(0.01)
            .multilineTextAlignment(.center)
            if negated {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(.red, lineWidth: lineWidth)
                Path { path in
                    path.move(to: CGPoint(x: diagOffset, y: diagOffset))
                    path.addLine(to: CGPoint(x: size - diagOffset, y: size - diagOffset))
                    path.closeSubpath()
                }
                .stroke(.red, lineWidth: lineWidth)
            }
        }
        .frame(width: size, height: size)
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
