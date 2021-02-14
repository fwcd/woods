//
//  JSONUtils.swift
//  Woods
//
//  Created by Fredrik on 2/14/21.
//  Copyright © 2021 Fredrik. All rights reserved.
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
