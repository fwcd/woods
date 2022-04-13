//
//  Waypoint+Icon.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

extension Waypoint {
    var iconName: String {
        if found {
            return "face.smiling.fill"
        } else if geocacheType != nil {
            return "archivebox.fill"
        } else {
            return "flag.fill"
        }
    }
}
