//
//  DateFormatter+Extensions.swift
//  Woods
//
//  Created by Fredrik on 02.03.23.
//

import Foundation

extension DateFormatter {
    static func standard() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        return formatter
    }
}
