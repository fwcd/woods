//
//  ConnectorError.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

enum ConnectorError: Error {
    case logInFailed(String)
    case logOutFailed(String)
    case geocacheQueryFailed(String)
    case noConnector
}
