//
//  UTType+GPX.swift
//  Woods
//
//  Created by Fredrik on 20.09.22.
//

import UniformTypeIdentifiers

extension UTType {
    static var gpx: UTType {
        UTType(importedAs: "com.topografix.gpx")
    }
}
