//
//  IsoDateTimeWithoutZCodable.swift
//  Woods
//
//  Created on 06.03.23
//

import Foundation

@propertyWrapper
struct IsoDateTimeWithoutZCodable {
    let wrappedValue: Date
}

extension IsoDateTimeWithoutZCodable: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        let formatter = DateFormatter.isoDateTimeWithoutZ()
        guard let wrappedValue = formatter.date(from: rawValue) else {
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
