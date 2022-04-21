//
//  JSONUtils.swift
//  Woods
//
//  Created by Fredrik on 2/14/21.
//  Copyright © 2021 Fredrik.
//

import Foundation

public func makeJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .secondsSince1970
    return encoder
}

public func makeJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    return decoder
}

extension Encodable {
    var dictSerialized: Any {
        (try? makeJSONEncoder().encode(self))
            .flatMap { try? JSONSerialization.jsonObject(with: $0, options: .allowFragments) } as Any
    }
}

extension Decodable {
    init?(dictSerialized: Any) {
        guard let value = (try? JSONSerialization.data(withJSONObject: dictSerialized, options: []))
            .flatMap({ try? makeJSONDecoder().decode(Self.self, from: $0) }) else { return nil }
        self = value
    }
}
