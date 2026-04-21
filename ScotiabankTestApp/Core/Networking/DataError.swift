/// Handles Data-fetching Errors - this is extendable as needed
/// 
import Foundation

enum DataError: LocalizedError {
    case resourceNotFound(String? = nil)
    case dataLoadingFailed
    case decodingFailed(Error)
    case invalidRequest
    case invalidResponse
    
    var errorDescription: String? {
        switch self {
        case .resourceNotFound(let description?):
            return "Resource not found: \(description)"
        case .resourceNotFound:
            return "Resource not found"
        case .dataLoadingFailed:
            return "Data loading failed"
        case .decodingFailed(let error):
            return "Decoding failed: \(error)"
            default :
            return nil
        }
    }
}
