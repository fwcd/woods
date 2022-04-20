//
//  StarsView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

struct StarsView: View {
    let rating: Int
    let maxRating: Int
    var step: Int = 1
    var starSize: CGFloat = 18
    
    var starCount: Int { maxRating / step }
    
    var body: some View {
        let stars = HStack(spacing: 0) {
            ForEach(0..<starCount, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .font(.system(size: starSize))
            }
        }
        
        stars
            .foregroundColor(.secondary.opacity(0.5))
            .overlay {
                stars
                    .clipShape(ClipWidth(fraction: CGFloat(rating) / CGFloat(maxRating)))
            }
    }
}

struct ClipWidth: Shape {
    let fraction: CGFloat
    
    func path(in rect: CGRect) -> Path {
        Rectangle()
            .path(in: CGRect(origin: rect.origin, size: CGSize(width: rect.width * fraction, height: rect.height)))
    }
}

struct StarsView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StarsView(rating: 2, maxRating: 5)
            StarsView(rating: 5, maxRating: 10, step: 2)
        }
    }
}
