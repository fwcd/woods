//
//  Region.swift
//  Woods
//
//  Created by Fredrik on 3/3/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

struct Region: Codable, Hashable {
    let topLeft: Coordinates
    let bottomRight: Coordinates
    
    func contains(_ location: Coordinates) -> Bool {
        // TODO: This naive version may fail where coordinates wrap around
        (topLeft.latitude...bottomRight.latitude).contains(location.latitude)
            && (topLeft.longitude...bottomRight.longitude).contains(location.longitude)
    }
}
