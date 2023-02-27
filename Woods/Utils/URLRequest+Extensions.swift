import Foundation
import Combine
import SwiftSoup
import OSLog

private let log = Logger(subsystem: "Woods", category: "URLRequest+Extensions")

extension URLRequest {
    init(
        standardWithUrl url: URL,
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

        self.init(url: url)
        httpMethod = method

        if isPost {
            if !query.isEmpty {
                setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
            }
            setValue("\(body.count)", forHTTPHeaderField: "Content-Length")
            httpBody = body
        }

        setValue("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.72 Safari/537.36", forHTTPHeaderField: "User-Agent")
        
        for (key, value) in headers {
            setValue(value, forHTTPHeaderField: key)
        }
    }
}
