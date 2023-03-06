//
//  StringCoded.swift
//  Woods
//
//  Created on 06.03.23
//

@propertyWrapper
struct StringCoded<Wrapped> {
    let wrappedValue: Wrapped
}

extension StringCoded: Codable where Wrapped: LosslessStringConvertible {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        guard let wrappedValue = Wrapped(rawValue) else {
            throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Could not parse Wrapped from \(rawValue)"))
        }
        self.wrappedValue = wrappedValue
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue.description)
    }
}
