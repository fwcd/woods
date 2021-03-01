//
//  GeocachingComConnector.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import Foundation

// Adapted from pycaching

private let baseUrl = "http://www.geocaching.com"
private let loginPageUrl = URL(string: "\(baseUrl)/account/signin")!
private let searchUrl = URL(string: "\(baseUrl)/play/search")!
private let searchMoreUrl = URL(string: "\(baseUrl)/play/search/more-results")!
private let myLogsUrl = URL(string: "\(baseUrl)/my/logs.aspx")!
private let apiSearchUrl = URL(string: "\(baseUrl)/api/proxy/web/search")!

class GeocachingComConnector: Connector {
    func logIn(using credentials: Credentials) throws {
        fatalError("TODO")
    }
    
    func logOut() throws {
        fatalError("TODO")
    }
    
    func geocaches(for query: GeocacheQuery) throws -> [Geocache] {
        fatalError("TODO")
    }
}
