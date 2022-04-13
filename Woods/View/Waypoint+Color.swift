//
//  Waypoint+Color.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

extension Waypoint {
    var color: Color {
        geocacheType?.color ?? .primary
    }
}
