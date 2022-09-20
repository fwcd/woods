//
//  Waypoint+Transferable.swift
//  Woods
//
//  Created by Fredrik on 20.09.22.
//

import Foundation
import CoreTransferable

extension Waypoint: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        // TODO: Support CodableRepresentation and investigate which UTType we should use
        // TODO: Support GPX import (by using DataRepresentation(contentType:...) instead)
        DataRepresentation(exportedContentType: .gpx) { waypoint in
            let gpx = waypoint.asGPX
            guard let data = gpx.data(using: .utf8) else {
                throw GPXError.couldNotEncode(gpx)
            }
            return data
        }
    }
}
