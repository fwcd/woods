import Foundation
import Combine
import SwiftSoup
import OSLog

private let log = Logger(subsystem: "Woods", category: "HTTPRequest")

extension URLSession {
    @discardableResult
    func runAndCheck(_ request: URLRequest) async throws -> Data {
        let (data, response) = try await data(for: request)
        guard let response = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        log.info("Got HTTP \(response.statusCode) for \(request.url?.absoluteString ?? "?")")
        guard response.statusCode >= 200 && response.statusCode < 400 else {
            if let utf8 = String(data: data, encoding: .utf8) {
                log.warning("Got response data: \(utf8)")
            }
            throw URLError(.badServerResponse)
        }
        return data
    }

    func fetchUTF8(for request: URLRequest) async throws -> String {
        let data = try await runAndCheck(request)
        guard let utf8 = String(data: data, encoding: .utf8) else { throw URLError(.cannotDecodeRawData) }
        return utf8
    }

    func fetchJSON<T>(as type: T.Type, for request: URLRequest) async throws -> T where T: Decodable {
        let data = try await runAndCheck(request)
        return try JSONDecoder.standard().decode(T.self, from: data)
    }

    func fetchHTML(for request: URLRequest) async throws -> Document {
        let raw = try await fetchUTF8(for: request)
        return try SwiftSoup.parse(raw)
    }
}
