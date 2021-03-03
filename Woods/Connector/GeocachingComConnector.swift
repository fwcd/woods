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
        total: Int? = nil,
        maxCaches: Int = 600,
        sortOrder: GeocachingComSortOrder = .datelastvisited,
        origin: Coordinates? = nil,
        accumulated: [Waypoint] = []
    ) -> AnyPublisher<[Waypoint], Error> {
        log.info("Sending search query (\(skip) of \(total.map { String($0) } ?? "?"))...")
        if let total = total {
            guard skip < total else { return Just(accumulated).weakenError().eraseToAnyPublisher() }
        }
        guard skip < maxCaches else { return Just(accumulated).weakenError().eraseToAnyPublisher() }
        return Result.Publisher(Result { () -> HTTPRequest in
            guard region.diameter <= Length(16, .kilometers) else {
                throw ConnectorError.regionTooWide
            }
            
            var query: [String: String] = [
                "box": [
                    region.topLeft.latitude.totalDegrees,
                    region.topLeft.longitude.totalDegrees,
                    region.bottomRight.latitude.totalDegrees,
                    region.bottomRight.longitude.totalDegrees,
                ].map { String($0) }.joined(separator: ","),
                "take": String(takePerQuery),
                "asc": "true",
                "skip": String(skip),
                "sort": sortOrder.rawValue
            ]
            
            if sortOrder == .distance, let origin = origin {
                query["origin"] = "\(origin.latitude),\(origin.longitude)"
            }
            
            return try HTTPRequest(url: apiSearchUrl, query: query)
        })
        .flatMap { $0.fetchJSONAsync(as: GeocachingComApiResults.self) }
        .delay(for: .seconds(0.5), scheduler: RunLoop.main)
        .flatMap { [self] results in
            // Search the next 'page'
            search(
                region: region,
                takePerQuery: takePerQuery,
                skip: skip + takePerQuery,
                total: results.total,
                sortOrder: sortOrder,
                origin: origin,
                accumulated: accumulated + results.results.compactMap(\.asWaypoint)
            )
        }
        .eraseToAnyPublisher()
    }
    
    func waypoints(for query: WaypointsInRegionQuery) -> AnyPublisher<[Waypoint], Error> {
        log.info("Querying waypoints in region around \(query.region.center)")
        return search(region: query.region)
    }
}
