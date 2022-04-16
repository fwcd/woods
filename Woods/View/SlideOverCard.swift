//
//  SlideOverCard.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//

import SwiftUI

// Based on https://www.mozzafiller.com/posts/swiftui-slide-over-card-like-maps-stocks

struct SlideOverCard<Content>: View where Content: View {
    @Binding var position: SlideOverCardPosition
    @ViewBuilder let content: (CGFloat) -> Content
    
    @State private var translation: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            let start = offset(for: position, in: geometry)
            let top = offset(for: .top, in: geometry)
            let middle = offset(for: .middle, in: geometry)
            let bottom = offset(for: .bottom, in: geometry)
            
            let drag = DragGesture()
                .onChanged { drag in
                    var dy = drag.translation.height
                    let y = start + dy
                    
                    func overscroll(_ delta: CGFloat) -> CGFloat {
                        min(delta, 4 * log(delta * delta))
                    }
                    
                    // Bouncy overscroll at top
                    dy = y < top
                        ? top - start - overscroll(top - y)
                        : dy
                    
                    // Bouncy overscroll at bottom
                    dy = y > bottom
                        ? bottom - start + overscroll(y - bottom)
                        : dy
                    
                    translation = dy
                }
                .onEnded { drag in
                    let y = start + translation
                    
                    // Find the closest position to the predicted drag end location
                    let next = nextPosition(for: drag, in: geometry)
                    
                    // To get a smooth animation, we set the translation relative
                    // to the end position.
                    translation = y - offset(for: next, in: geometry)
                    position = next
                    
                    withAnimation(.easeInOut(duration: 0.2)) {
                        translation = 0
                    }
                }

            VStack {
                let dy = translation
                let y = start + dy
                let contentOpacity = max(0, min(1, (y - bottom) / (middle - bottom)))
                
                Handle()
                self.content(contentOpacity)
                    .frame(maxWidth: .infinity)
            }
            .background(.ultraThinMaterial)
            .cornerRadius(15)
            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
            .offset(y: offset(for: position, in: geometry) + translation)
            .gesture(drag)
        }
    }
    
    private func nextPosition(for drag: DragGesture.Value, in geometry: GeometryProxy) -> SlideOverCardPosition {
        closestPosition(to: drag.predictedEndLocation.y, in: geometry)
    }
    
    private func closestPosition(to y: CGFloat, in geometry: GeometryProxy) -> SlideOverCardPosition {
        SlideOverCardPosition.allCases.min(by: ascendingComparator { otherPos in
            abs(y - offset(for: otherPos, in: geometry))
        })!
    }
    
    private func offset(for position: SlideOverCardPosition, in geometry: GeometryProxy) -> CGFloat {
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
}

struct SlideOverCard_Previews: PreviewProvider {
    @State static var position: SlideOverCardPosition = .bottom
    static var previews: some View {
        ZStack {
            Text("Background")
            SlideOverCard(position: $position) { _ in
                Text("Card")
                Spacer()
            }
        }
    }
}
