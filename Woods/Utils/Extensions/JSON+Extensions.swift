//
//  JSONUtils.swift
//  Woods
//
//  Created by Fredrik on 2/14/21.
//  Copyright © 2021 Fredrik.
//

import Foundation

extension JSONEncoder {
    static func standard() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        return encoder
    }
}

extension JSONDecoder {
    static func standard() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }
}

extension Encodable {
    var dictSerialized: Any {
        (try? JSONEncoder.standard().encode(self))
            .flatMap { try? JSONSerialization.jsonObject(with: $0, options: .allowFragments) } as Any
    }
}

extension Decodable {
    init?(dictSerialized: Any) {
        guard let value = (try? JSONSerialization.data(withJSONObject: dictSerialized, options: []))
            .flatMap({ try? JSONDecoder.standard().decode(Self.self, from: $0) }) else { return nil }
        self = value
    }
}
