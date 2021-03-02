//
//  GeocacheDetailView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import SwiftUI

struct GeocacheDetailView: View {
    let geocache: Geocache
    
    var body: some View {
        VStack {
            Text(geocache.name)
                .font(.title)
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
            
        }
    }
}

struct GeocacheDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GeocacheDetailView(geocache: mockGeocaches().first!)
    }
}
