/// APIClient skeleton for making Network calls, if needed
/// 
import Foundation

protocol APIClientProtocol: Sendable {
    func request<T: Decodable & Sendable>(_ endpoint: APIEndpoint, responseType: T.Type) async throws -> T
}

struct APIClient: APIClientProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.decoder = decoder
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func request<T: Decodable & Sendable>(_ endpoint: APIEndpoint, responseType: T.Type) async throws -> T {
        guard let request = endpoint.urlRequest else {
            throw DataError.invalidRequest
        }

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw DataError.invalidResponse
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw DataError.decodingFailed(error)
        }
    }
}
