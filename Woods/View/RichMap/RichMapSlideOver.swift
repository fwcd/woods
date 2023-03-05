//
//  RichMapSlideOver.swift
//  Woods
//
//  Created by Fredrik on 20.04.22.
//

import SwiftUI

struct RichMapSlideOver: View {
    @Binding var selectedWaypointId: String?
    @Binding var searchText: String
    
    @EnvironmentObject private var waypoints: Waypoints
    @State private var slideOverPosition: SlideOverCardPosition = .bottom
    
    var body: some View {
        let cardAnimation: Animation = .easeInOut(duration: 0.2)
        SlideOverCard(
            position: $slideOverPosition,
            supportedPositions: [.bottom, .top]
        ) { contentOpacity in
            VStack(alignment: .leading) {
                if let id = selectedWaypointId, let waypoint = waypoints[id] {
                    // TODO: Get an actual binding to the waypoint here to enable editing
                    // (this might require modifications to the way we store waypoints in the view model, since we'd not only want to bind into the currentWaypoints, but ideally into the list it originated from, if any)
                    WaypointSummaryView(waypoint: .constant(waypoint), isEditable: false, contentOpacity: contentOpacity)
                } else {
                    VStack(alignment: .leading, spacing: 5) {
                        SearchBar(placeholder: "Filter waypoints...", text: $searchText) {
                            if slideOverPosition == .bottom {
                                withAnimation(cardAnimation) {
                                    slideOverPosition = .middle
                                }
                            }
                        } onClear: {
                            if slideOverPosition == .middle {
                                withAnimation(cardAnimation) {
                                    slideOverPosition = .bottom
                                }
                            }
                        }
                        .padding([.bottom], 15)
                        ForEach(waypoints.filteredWaypoints(for: searchText)) { waypoint in
                            Button {
                                selectedWaypointId = waypoint.id
                            } label: {
                                WaypointSmallSnippetView(waypoint: waypoint)
                            }
                            .buttonStyle(.plain)
                        }
                        .opacity(contentOpacity)
                    }
                    .padding([.leading, .trailing], 15)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .onTapGesture {
                if selectedWaypointId != nil {
                    withAnimation(cardAnimation) {
                        switch slideOverPosition {
                        case .bottom: slideOverPosition = .middle
                        case .middle: slideOverPosition = .top
                        default: break
                        }
                    }
                }
            }
        }
    }
}

struct RichMapSlideOver_Previews: PreviewProvider {
    @State static var selectedWaypointId: String? = nil
    @State static var searchText: String = ""
    @StateObject static var waypoints = Waypoints(accounts: Accounts(testMode: true))
    static var previews: some View {
        RichMapSlideOver(
            selectedWaypointId: $selectedWaypointId,
            searchText: $searchText
        )
        .environmentObject(waypoints)
    }
}
