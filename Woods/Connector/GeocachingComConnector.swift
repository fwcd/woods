//
//  GeocachingComConnector.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import Foundation
import Combine
import SwiftSoup
import OSLog

// Adapted from pycaching

private let baseUrl = "https://www.geocaching.com"
private let loginPageUrl = URL(string: "\(baseUrl)/account/signin")!
private let searchUrl = URL(string: "\(baseUrl)/play/search")!
private let searchMoreUrl = URL(string: "\(baseUrl)/play/search/more-results")!
private let myLogsUrl = URL(string: "\(baseUrl)/my/logs.aspx")!
private let apiSearchUrl = URL(string: "\(baseUrl)/api/proxy/web/search/v2")!

private let log = Logger(subsystem: "Woods", category: "GeocachingComConnector")

class GeocachingComConnector: Connector {
    func logIn(using credentials: Credentials) -> AnyPublisher<Void, Error> {
        let tokenFieldName = "__RequestVerificationToken"
        
        return Result.Publisher(Result { try HTTPRequest(url: loginPageUrl) })
            .flatMap { $0.fetchHTMLAsync() }
            .tryMap { document -> HTTPRequest in
                log.info("Parsing login page")
                guard let tokenField = try document.select("input[name=\(tokenFieldName)]").first() else {
                    throw ConnectorError.logInFailed("Could not parse login page")
                }
                let tokenValue = try tokenField.attr("value")
                return try HTTPRequest(url: loginPageUrl, method: "POST", query: [
                    "UsernameOrEmail": credentials.username,
                    "Password": credentials.password,
                    tokenFieldName: tokenValue
                ])
            }
            .flatMap { request -> Publishers.TryMap<URLSession.DataTaskPublisher, Data> in
                log.info("Submitting login request")
                return request.runAsync()
            }
            .map { _ in }
            .eraseToAnyPublisher()
    }
    
    func logOut() -> AnyPublisher<Void, Error> {
        fatalError("TODO")
    }
    
    func waypoints(for rawQuery: WaypointsInRadiusQuery) -> AnyPublisher<[Waypoint], Error> {
        fatalError("TODO")
    }
    
    /// Searches the given region.
    private func search(
        region: Region,
        takePerQuery: Int = 200,
        skip: Int = 0,
        total: Int? = 0,
        sortOrder: GeocachingComSortOrder = .datelastvisited,
        origin: Coordinates? = nil
    ) -> AnyPublisher<[Waypoint], Error> {
        if let total = total {
            guard skip < total else { return Just([]).weakenError().eraseToAnyPublisher() }
        }
        return Result.Publisher(Result {
            let region = query.region
            guard region.diameter <= Length(16, .kilometers) else {
                throw ConnectorError.regionTooWide
            }
            return try HTTPRequest(url: apiSearchUrl, query: [
                "box": [
                    region.topLeft.latitude.totalDegrees,
                    region.topLeft.longitude.totalDegrees,
                    region.bottomRight.latitude.totalDegrees,
                    region.bottomRight.longitude.totalDegrees,
                ].map(String.init).joined(separator: ","),
                "take": takePerQuery,
                "asc": true,
                "skip": skip,
                "sort": sortOrder.rawValue
            ] + (sortOrder == .distance ? ["origin": "\(origin?.latitude ?? 0),\(origin?.longitude ?? 0)"] : [:]))
        })
        .flatMap { $0.fetchJSONAsync(as: GeocachingComApiResults.self) }
        .eraseToAnyPublisher()
    }
    
    func waypoints(for query: WaypointsInRegionQuery) -> AnyPublisher<[Waypoint], Error> {
        fatalError("TODO")
    }
}
