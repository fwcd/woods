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
    
    var body: some View {
        let stars = HStack(spacing: 0) {
            ForEach(0..<(maxRating / step), id: \.self) { _ in
                Image(systemName: "star.fill")
            }
        }
        
        stars
            .overlay(
                GeometryReader { geometry in
                    let width = (CGFloat(rating) * geometry.size.width) / CGFloat(maxRating)
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(width: width)
                            .foregroundColor(.primary)
                    }
                }
                .mask(stars)
            )
            .foregroundColor(.secondary)
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
