//
//  SlideOverCard.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//

import SwiftUI

// Source: https://www.mozzafiller.com/posts/swiftui-slide-over-card-like-maps-stocks

struct SlideOverCard<Content: View>: View {
    let content: () -> Content
    
    @GestureState private var dragState = DragState.inactive
    @State var position = CardPosition.top
    
    var body: some View {
        GeometryReader { geometry in
            let drag = DragGesture()
                .updating($dragState) { drag, state, transaction in
                    state = .dragging(translation: drag.translation)
                }
                .onEnded { drag in
                    onDragEnded(drag: drag, geometry: geometry)
                }

            VStack {
                Handle()
                self.content()
                    .frame(maxWidth: .infinity)
            }
            .background(Color(UIColor.systemBackground))
            .cornerRadius(10.0)
            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
            .offset(y: (geometry.size.height - position.rawValue) + dragState.translation.height)
            .animation(dragState.isDragging ? nil : .interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
            .gesture(drag)
        }
    }

    private func onDragEnded(drag: DragGesture.Value, geometry: GeometryProxy) {
        let verticalDirection = drag.predictedEndLocation.y - drag.location.y
        let cardTopEdgeLocation = (geometry.size.height - position.rawValue) + drag.translation.height
        let positionAbove: CardPosition
        let positionBelow: CardPosition
        let closestPosition: CardPosition

        if cardTopEdgeLocation <= CardPosition.middle.rawValue {
            positionAbove = .top
            positionBelow = .middle
        } else {
            positionAbove = .middle
            positionBelow = .bottom
        }

        if (cardTopEdgeLocation - positionAbove.rawValue) < (positionBelow.rawValue - cardTopEdgeLocation) {
            closestPosition = positionAbove
        } else {
            closestPosition = positionBelow
        }

        if verticalDirection > 0 {
            position = positionBelow
        } else if verticalDirection < 0 {
            position = positionAbove
        } else {
            position = closestPosition
        }
    }

    enum CardPosition: CGFloat {
        case top = 700
        case middle = 500
        case bottom = 100
    }

    enum DragState {
        case inactive
        case dragging(translation: CGSize)

        var translation: CGSize {
            switch self {
            case .inactive:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }

        var isDragging: Bool {
            switch self {
            case .inactive:
                return false
            case .dragging:
                return true
            }
        }
    }
}
