//
//  IsoDateTimeWithoutZCoding.swift
//  Woods
//
//  Created on 06.03.23
//

import Foundation

struct IsoDateTimeWithoutZCoding: CustomCodableWrapper {
    let wrappedValue: Date
    
    init(wrappedValue: Date) {
        self.wrappedValue = wrappedValue
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        guard let wrappedValue = DateFormatter.isoDateTimeWithoutZ().date(from: rawValue)
                ?? DateFormatter.isoDateTimeWithoutZ(fractional: true).date(from: rawValue) else {
            throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Could not parse date from \(rawValue)"))
        }
        self.wrappedValue = wrappedValue
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let formatter = DateFormatter.isoDateTimeWithoutZ()
        try container.encode(formatter.string(from: wrappedValue))
    }
}
