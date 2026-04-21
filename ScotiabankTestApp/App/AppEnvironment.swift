/// AppEnvironment with Remote url skeleton

import Foundation

enum AppEnvironment: Sendable, Equatable {
    case local
    case development
    case production
    
    var baseURL: URL? {
        switch self {
        case .local:
            return nil
        case .development:
            return URL(string: "https://dev.env.com/api")
        case .production:
            return URL(string: "https://env.com/api")
        }
    }
}

struct AppConfiguration: Sendable {
    let environment: AppEnvironment
    
    static let `default` = AppConfiguration(
        environment: .local
    )
}
