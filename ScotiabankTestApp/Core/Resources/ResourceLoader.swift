/// JSON Loader and decoder
import Foundation

protocol ResourceLoading: Sendable {
    func data(named resourceName: String, withExtension resourceExtension: String) throws -> Data
}

struct ResourceLoader: ResourceLoading {
    let bundle: Bundle
    
    init (bundle: Bundle = .main) {
        self.bundle = bundle
    }

    func data(named resourceName: String, withExtension resourceExtension: String) throws -> Data {
        guard let url = bundle.url(forResource: resourceName, withExtension: resourceExtension)
        else { throw DataError.resourceNotFound(resourceName) }

        do {
            return try Data(contentsOf: url)
        }
        catch {
            throw DataError.dataLoadingFailed
        }
    }
}

extension ResourceLoading {
    func decode<T: Decodable>(
        _ type: T.Type,
        resourceName: String,
        withExtension resourceExtension: String = "json",
        decoder: JSONDecoder = JSONDecoder()
    ) throws -> T {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let data = try data(named: resourceName, withExtension: resourceExtension)

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw DataError.decodingFailed(error)
        }
    }
}
