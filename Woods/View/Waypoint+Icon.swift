//
//  Waypoint+Icon.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import SwiftUI

extension Waypoint {
    var iconName: String {
        if geocacheType != nil {
            return "archivebox.fill"
        } else {
            return "flag.fill"
        }
    }
}
