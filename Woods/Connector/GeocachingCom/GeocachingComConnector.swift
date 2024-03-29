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
private let serverParamsUrl = URL(string: "\(baseUrl)/play/serverparameters/params")!

private func apiPreviewUrl(gcCode: String) -> URL {
    URL(string: "\(baseUrl)/api/proxy/web/search/geocachepreview/\(gcCode)")!
}

private func apiLogUrl(gcCode: String) -> URL {
    URL(string: "\(baseUrl)/api/proxy/web/v1/Geocache/\(gcCode)/GeocacheLog")!
}

private let log = Logger(subsystem: "Woods", category: "GeocachingComConnector")
private let searchParamsPattern = try! Regex(from: "\\{.+\\}")

final class GeocachingComConnector: Connector {
    private let username: String
    private let session = URLSession(configuration: .ephemeral)
    
    init(using credentials: Credentials) async throws {
        username = credentials.username
        
        let tokenFieldName = "__RequestVerificationToken"
        
        // Fetch the login page
        let request = try URLRequest.standard(url: loginPageUrl)
        let document = try await session.fetchHTML(for: request)
        
        log.info("Parsing login page")
        guard let tokenField = try document.select("input[name=\(tokenFieldName)]").first() else {
            throw ConnectorError.logInFailed("Could not parse login page")
        }
        let tokenValue = try tokenField.attr("value")
        
        // Send the login request
        let loginRequest = try URLRequest.standard(url: loginPageUrl, method: "POST", query: [
            "UsernameOrEmail": credentials.username,
            "Password": credentials.password,
            tokenFieldName: tokenValue
        ])
        
        log.info("Submitting login request")
        try await session.runAndCheck(loginRequest)
    }
    
    deinit {
        session.invalidateAndCancel()
    }
    
    func accountInfo() async throws -> AccountInfo {
        log.info("Querying account info")
        
        let request = try URLRequest.standard(url: serverParamsUrl)
        let raw = try await session.fetchUTF8(for: request)
        guard let jsonData = searchParamsPattern.firstGroups(in: raw)?[0].data(using: .utf8) else {
            throw ConnectorError.accountInfoFailed("Could not parse/encode search params: '\(raw)'")
        }
        let value = try JSONDecoder.standard().decode(GeocachingComApi.ServerParameters.self, from: jsonData)
        
        return AccountInfo(
            roles: value.userInfo.roles ?? [],
            avatarUrl: value.userInfo.avatarUrl
        )
    }
    
    func waypoint(id: String) async throws -> Waypoint {
        try verifyIsGcCode(id: id)
        log.info("Querying details for \(id)")
        let request = try URLRequest.standard(url: apiPreviewUrl(gcCode: id))
        let result = try await session.fetchJSON(as: GeocachingComApi.Geocache.self, for: request)
        guard let waypoint = Waypoint(result, username: username) else { throw ConnectorError.waypointNotFound(id) }
        return waypoint
    }
    
    func waypoints(for rawQuery: WaypointsInRadiusQuery) -> [Waypoint] {
        fatalError("TODO")
    }
    
    func post(waypointLog: WaypointLog, for waypoint: Waypoint) async throws -> WaypointLog {
        try verifyIsGcCode(id: waypoint.id)
        let post = GeocachingComApi.NewLog(waypointLog, for: waypoint.id)
        let body = try JSONEncoder.standard().encode(post)
        let request = try URLRequest.standard(
            url: apiLogUrl(gcCode: waypoint.id),
            method: "POST",
            headers: [
                "Content-Type": "application/json",
            ],
            body: body
        )
        let result = try await session.fetchJSON(as: GeocachingComApi.PostedLog.self, for: request)
        guard var createdLog = WaypointLog(result) else { throw ConnectorError.waypointLogCouldNotBeParsed("Got result: \(result)") }
        createdLog.type = waypointLog.type
        return createdLog
    }
    
    private func verifyIsGcCode(id: String) throws {
        guard id.starts(with: "GC") else { throw ConnectorError.invalidWaypoint("Not a Geocaching.com geocache") }
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
            
        let request = try URLRequest.standard(url: apiSearchUrl, query: query)
        let results = try await session.fetchJSON(as: GeocachingComApi.Results.self, for: request)
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
                    var waypoint = Waypoint($0, username: username)
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
