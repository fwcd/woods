//
//  GeocacheSnippetView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import SwiftUI

struct GeocacheSnippetView: View {
    let geocache: Geocache
    
    var body: some View {
        HStack {
            Image(systemName: "archivebox.fill")
                .foregroundColor(geocache.type.color)
                .font(.title)
            VStack(alignment: .leading) {
                Text(geocache.id)
                    .font(.headline)
                Text(geocache.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

struct GeocacheSnippetView_Previews: PreviewProvider {
    static var previews: some View {
        GeocacheSnippetView(geocache: mockGeocaches().first!)
    }
}
