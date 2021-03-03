//
//  SlideOverCard.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//

import SwiftUI
import UIKit

// Source: https://www.mozzafiller.com/posts/swiftui-slide-over-card-like-maps-stocks

struct SlideOverCard<Content>: View where Content: View {
    let content: () -> Content
    
    @GestureState private var dragState: DragState = .inactive
    @State var position: CardPosition = .bottom
    
    var body: some View {
        GeometryReader { geometry in
            let drag = DragGesture()
                .updating($dragState) { drag, state, transaction in
                    state = .dragging(translation: drag.translation)
                }
                .onEnded { drag in
                    onDragEnded(drag, in: geometry)
                }

            ZStack {
                VisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
                VStack {
                    Handle()
                    self.content()
                        .frame(maxWidth: .infinity)
                }
            }
            .cornerRadius(15)
            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
            .offset(y: offset(for: position, in: geometry) + dragState.translation.height)
            .animation(dragState.isDragging ? nil : .interpolatingSpring(stiffness: 300, damping: 35, initialVelocity: 40))
            .gesture(drag)
        }
    }

    private func onDragEnded(_ drag: DragGesture.Value, in geometry: GeometryProxy) {
        let verticalDirection = drag.predictedEndLocation.y - drag.location.y
        let cardTopEdgeLocation = offset(for: position, in: geometry) + drag.translation.height
        let positionAbove: CardPosition
        let positionBelow: CardPosition
        let closestPosition: CardPosition

        if cardTopEdgeLocation <= offset(for: .middle, in: geometry) {
            positionAbove = .top
            positionBelow = .middle
        } else {
            positionAbove = .middle
            positionBelow = .bottom
        }

        if (cardTopEdgeLocation - offset(for: positionAbove, in: geometry)) < (offset(for: positionBelow, in: geometry) - cardTopEdgeLocation) {
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
    
    private func offset(for position: CardPosition, in geometry: GeometryProxy) -> CGFloat {
        let height = geometry.size.height
        switch position {
        case .top:
            return height * 0.1
        case .middle:
            return height * 0.5
        case .bottom:
            return height * 0.87
        }
    }

    enum CardPosition {
        case top
        case middle
        case bottom
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
