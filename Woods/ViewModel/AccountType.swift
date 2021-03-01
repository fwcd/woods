//
//  AccountType.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

enum AccountType: String, CustomStringConvertible, CaseIterable, Hashable {
    case geocachingCom = "geocaching.com"
    
    var description: String { rawValue }
    
    func makeConnector() -> Connector {
        switch self {
        case .geocachingCom:
            return GeocachingComConnector()
        }
    }
}
