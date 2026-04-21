/// App Dependecy Injection Container

import Foundation

struct AppContainer {
    let configuration: AppConfiguration
    let transactionRepository: any TransactionRepository

    init(
        configuration: AppConfiguration = .default,
        transactionRepository: (any TransactionRepository)? = nil
    ) {
        self.configuration = configuration
        
        if let transactionRepository {
            self.transactionRepository = transactionRepository
            return
        }

        let resourceLoader = ResourceLoader()
        let apiClient = APIClient()

        self.transactionRepository = AppContainer.makeTransactionRepository(
            configuration: configuration,
            resourceLoader: resourceLoader,
            apiClient: apiClient
        )
    }

    private static func makeTransactionRepository(
        configuration: AppConfiguration,
        resourceLoader: any ResourceLoading,
        apiClient: any APIClientProtocol
    ) -> any TransactionRepository {
        switch configuration.environment {
        case .local:
            return LocalTransactionRepository(
                resourceLoader: resourceLoader
            )

        case .development, .production:
            guard let baseURL = configuration.environment.baseURL else {
                preconditionFailure("Remote environments must provide a baseURL.")
            }

            return RemoteTransactionRepository(
                apiClient: apiClient,
                baseURL: baseURL
            )
        }
    }
}
