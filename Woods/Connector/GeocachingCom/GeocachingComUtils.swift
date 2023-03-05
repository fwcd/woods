//
//  GeocachingComUtils.swift
//  Woods
//
//  Created on 06.03.23.
//

import Foundation

private let gcAlphabet = Dictionary(uniqueKeysWithValues: "0123456789ABCDEFGHJKMNPQRTVWXYZ".enumerated().map { ($0.element, $0.offset) })

private func gcDigit(_ c: Character) -> Int {
    gcAlphabet[c] ?? 0
}

func gcCacheId(gcCode: String) -> Int {
    let code = gcCode.uppercased()
    assert(code.starts(with: "GC"))
    let rawCode = code.dropFirst(2)
    let useBase16 = rawCode.count < 4 || (rawCode.count == 4 && gcDigit(rawCode.first!) < 16)
    let base = useBase16 ? 16 : 31
    let offset = useBase16 ? 0 : -411_120 // = pow(16, 4) - 16 * pow(31, 3)
    return offset + rawCode.reduce(0) { base * $0 + gcDigit($1) }
}

func gcIsoDateFormatter() -> ISO8601DateFormatter {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    return formatter
}
