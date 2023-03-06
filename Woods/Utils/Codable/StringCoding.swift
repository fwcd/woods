//
//  StringCodable.swift
//  Woods
//
//  Created on 06.03.23
//

struct StringCoding<Wrapped>: CustomCodableWrapper where Wrapped: LosslessStringConvertible {
    let wrappedValue: Wrapped
    
    init(wrappedValue: Wrapped) {
        self.wrappedValue = wrappedValue
    }
    
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
