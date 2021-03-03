//
//  SizeView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import SwiftUI

struct SizeView: View {
    let rating: Int
    let maxRating: Int
    let width: CGFloat = 14
    let height: CGFloat = 14
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 4) {
            ForEach(0..<maxRating) { i in
                Rectangle()
                    .frame(width: width, height: ((CGFloat(i + 1) * height) / CGFloat(maxRating)))
                    .foregroundColor((i + 1) == rating ? .primary : .secondary)
            }
        }
    }
}

struct SizeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SizeView(rating: 2, maxRating: 4)
            SizeView(rating: 5, maxRating: 10)
        }
    }
}
