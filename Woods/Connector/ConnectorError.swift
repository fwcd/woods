//
//  ConnectorError.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik.
//

enum ConnectorError: Error {
    case logInFailed(String)
    case logOutFailed(String)
    case invalidWaypoint(String)
    case waypointNotFound(String)
    case waypointQueryFailed(String)
    case accountInfoFailed(String)
    case waypointLogCouldNotBeParsed(String)
    case regionTooWide
    case noConnector
    case postingLogsNotSupported
}
