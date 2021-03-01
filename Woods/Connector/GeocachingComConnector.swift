//
//  GeocachingComConnector.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import Foundation
import Combine
import OSLog

// Adapted from pycaching

private let baseUrl = "http://www.geocaching.com"
private let loginPageUrl = URL(string: "\(baseUrl)/account/signin")!
private let searchUrl = URL(string: "\(baseUrl)/play/search")!
private let searchMoreUrl = URL(string: "\(baseUrl)/play/search/more-results")!
private let myLogsUrl = URL(string: "\(baseUrl)/my/logs.aspx")!
private let apiSearchUrl = URL(string: "\(baseUrl)/api/proxy/web/search")!

private let log = Logger(subsystem: "Woods", category: "Connector")

class GeocachingComConnector: Connector {
    @Published private var state: ConnectorState = .disconnected
    
    var statePublisher: AnyPublisher<ConnectorState, Never> { $state.eraseToAnyPublisher() }
    
    func logIn(using credentials: Credentials) -> AnyPublisher<Void, Error> {
        state = .connecting
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
    
    func geocaches(for query: GeocacheQuery) -> AnyPublisher<[Geocache], Error> {
        fatalError("TODO")
    }
}
