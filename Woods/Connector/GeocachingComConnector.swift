//
//  GeocachingComConnector.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik.
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

private func apiPreviewUrl(gcCode: String) -> URL {
    URL(string: "\(baseUrl)/api/proxy/web/search/geocachepreview/\(gcCode)")!
}

private let log = Logger(subsystem: "Woods", category: "GeocachingComConnector")

class GeocachingComConnector: Connector {
    func logIn(using credentials: Credentials) async throws {
        let tokenFieldName = "__RequestVerificationToken"
        
        // Fetch the login page
        let request = try HTTPRequest(url: loginPageUrl)
        let document = try await request.fetchHTMLAsync()
        
        log.info("Parsing login page")
        guard let tokenField = try document.select("input[name=\(tokenFieldName)]").first() else {
            throw ConnectorError.logInFailed("Could not parse login page")
        }
        let tokenValue = try tokenField.attr("value")
        
        // Send the login request
        let loginRequest = try HTTPRequest(url: loginPageUrl, method: "POST", query: [
            "UsernameOrEmail": credentials.username,
            "Password": credentials.password,
            tokenFieldName: tokenValue
        ])
        
        log.info("Submitting login request")
        try await loginRequest.runAsync()
    }
    
    func logOut() async {
        // TODO
    }
    
    func waypoint(id: String) async throws -> Waypoint {
        log.info("Querying details for \(id)")
        guard id.starts(with: "GC") else { throw ConnectorError.invalidWaypoint("Not a Geocaching.com geocache") }
        let request = try HTTPRequest(url: apiPreviewUrl(gcCode: id))
        let result = try await request.fetchJSONAsync(as: GeocachingComApiResults.Geocache.self)
        guard let waypoint = result.asWaypoint else { throw ConnectorError.waypointNotFound(id) }
        return waypoint
    }
    
    func waypoints(for rawQuery: WaypointsInRadiusQuery) -> [Waypoint] {
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
    ) async throws -> [Waypoint] {
        log.info("Sending search query (\(skip) of \(total ?? maxCaches))...")
        guard skip < total ?? maxCaches else { return accumulated }
        guard region.diameter <= Length(16, .kilometers) else { throw ConnectorError.regionTooWide }
            
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
            
        let request = try HTTPRequest(url: apiSearchUrl, query: query)
        let results = try await request.fetchJSONAsync(as: GeocachingComApiResults.self)
        try await Task.sleep(nanoseconds: 500_000_000)
        
        // Search the next 'page'
        return try await search(
            region: region,
            takePerQuery: takePerQuery,
            skip: skip + takePerQuery,
            total: results.total,
            sortOrder: sortOrder,
            origin: origin,
            accumulated: accumulated + results.results
                .compactMap {
                    var waypoint = $0.asWaypoint
                    waypoint?.isStub = true
                    return waypoint
                }
        )
    }
    
    func waypoints(for query: WaypointsInRegionQuery) async throws -> [Waypoint] {
        log.info("Querying waypoints in region around \(query.region.center)")
        return try await search(region: query.region)
    }
}
