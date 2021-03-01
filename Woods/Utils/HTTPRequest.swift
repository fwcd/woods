import Foundation
import Combine
import SwiftSoup

public struct HTTPRequest {
    private var request: URLRequest
    
    public init(
        url: URL,
        method: String = "GET",
        query: [String: String] = [:],
        headers: [String: String] = [:],
        body customBody: String? = nil
    ) throws {
        let isPost = method == "POST"

        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { throw URLError(.badURL) }
        components.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }

        let body: Data

        if isPost && !query.isEmpty {
            body = components.percentEncodedQuery?.data(using: .utf8) ?? .init()
            components.queryItems = []
        } else {
            body = customBody?.data(using: .utf8) ?? .init()
        }

        guard let url = components.url else { throw URLError(.badURL) }

        request = URLRequest(url: url)
        request.httpMethod = method

        if isPost {
            if !query.isEmpty {
                request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
            }
            request.setValue("\(body.count)", forHTTPHeaderField: "Content-Length")
            request.httpBody = body
        }

        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }

    public init(
        scheme: String = "https",
        host: String,
        port: Int? = nil,
        path: String,
        method: String = "GET",
        query: [String: String] = [:],
        headers: [String: String] = [:],
        body customBody: String? = nil
    ) throws {
        let isPost = method == "POST"

        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }

        if let p = port {
            components.port = p
        }

        let body: Data

        if isPost && !query.isEmpty {
            body = components.percentEncodedQuery?.data(using: .utf8) ?? .init()
            components.queryItems = []
        } else {
            body = customBody?.data(using: .utf8) ?? .init()
        }

        guard let url = components.url else { throw URLError(.badURL) }

        request = URLRequest(url: url)
        request.httpMethod = method

        if isPost {
            if !query.isEmpty {
                request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
            }
            request.setValue("\(body.count)", forHTTPHeaderField: "Content-Length")
            request.httpBody = body
        }

        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }

    public func runAsync() -> Publishers.TryMap<URLSession.DataTaskPublisher, Data> {
        URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { element -> Data in
                guard let response = element.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 400 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
    }

    public func fetchUTF8Async() -> Publishers.TryMap<Publishers.TryMap<URLSession.DataTaskPublisher, Data>, String> {
        runAsync().tryMap { data -> String in
            if let utf8 = String(data: data, encoding: .utf8) {
                return utf8
            } else {
                throw URLError(.cannotDecodeRawData)
            }
        }
    }

    public func fetchJSONAsync<T>(as type: T.Type) -> Publishers.Decode<Publishers.TryMap<URLSession.DataTaskPublisher, Data>, T, JSONDecoder> where T: Decodable {
        runAsync().decode(type: type, decoder: makeJSONDecoder())
    }

    public func fetchHTMLAsync() -> Publishers.TryMap<Publishers.TryMap<URLSession.DataTaskPublisher, Data>, Document> {
        fetchUTF8Async().tryMap { try SwiftSoup.parse($0) }
    }
}
