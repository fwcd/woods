//
//  AccountType.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

enum AccountType: String, CustomStringConvertible {
    case geocachingCom = "Geocaching.com"
    
    var description: String { rawValue }
    
    func makeConnector() -> Connector {
        switch self {
        case .geocachingCom:
            return GeocachingComConnector()
        }
    }
}
