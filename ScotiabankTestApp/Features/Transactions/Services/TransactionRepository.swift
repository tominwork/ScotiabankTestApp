import Foundation

protocol TransactionRepository: Sendable {
    func fetchTransactions() async throws -> [Transaction]
}

struct LocalTransactionRepository: TransactionRepository {
    private let resourceLoader: any ResourceLoading
    private let jsonFileName: String

    init(
        resourceLoader: any ResourceLoading,
        jsonFileName: String = "transaction-list"
    ) {
        self.resourceLoader = resourceLoader
        self.jsonFileName = jsonFileName
    }

    func fetchTransactions() async throws -> [Transaction] {
        let response = try resourceLoader.decode(
            TransactionResponse.self,
            resourceName: jsonFileName
        )

        return response.transactions.sorted { $0.postedDate > $1.postedDate }
    }
}

/// Remote Repository skeleton
struct RemoteTransactionRepository: TransactionRepository {
    private let apiClient: any APIClientProtocol
    private let baseURL: URL

    init(
        apiClient: any APIClientProtocol,
        baseURL: URL
    ) {
        self.apiClient = apiClient
        self.baseURL = baseURL
    }

    func fetchTransactions() async throws -> [Transaction] {
        []
    }
}
