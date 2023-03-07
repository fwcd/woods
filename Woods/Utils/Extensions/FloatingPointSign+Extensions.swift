//
//  SignUtils.swift
//  Woods
//
//  Created by Fredrik on 20.04.22.
//

import Foundation

extension FloatingPointSign {
    var asDouble: Double {
        switch self {
        case .plus: return 1
        case .minus: return -1
        }
    }
}
