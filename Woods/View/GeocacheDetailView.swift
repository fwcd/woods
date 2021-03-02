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
        VStack(alignment: .leading) {
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
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            Form {
                Section(header: Text("Info")) {
                    HStack {
                        Image(systemName: "chart.bar.fill")
                        StarsView(
                            rating: geocache.difficulty ?? 0,
                            maxRating: Geocache.ratings.upperBound,
                            step: 2
                        )
                        Divider()
                        Image(systemName: "leaf.fill")
                        StarsView(
                            rating: geocache.terrain ?? 0,
                            maxRating: Geocache.ratings.upperBound,
                            step: 2
                        )
                    }
                }
                Section(header: Text("Description")) {
                    Text(geocache.description ?? "no description provided")
                }
                Section(header: Text("Hint")) {
                    Text(geocache.hint ?? "no hint provided")
                }
            }
        }
    }
}

struct GeocacheDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GeocacheDetailView(geocache: mockGeocaches().first!)
    }
}
