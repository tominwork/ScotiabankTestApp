import XCTest
@testable import ScotiabankTestApp

struct MockTransactionRepository: TransactionRepository {
    let fetch: @Sendable () async throws -> [Transaction]

    func fetchTransactions() async throws -> [Transaction] {
        try await fetch()
    }
}

struct MockResourceLoader: ResourceLoading {
    let data: Data?

    func data(named resourceName: String, withExtension resourceExtension: String) throws -> Data {
        guard let data else {
            throw DataError.resourceNotFound(resourceName)
        }
        return data
    }
}

extension Transaction {
    static func transactionItem(
        key: String = "abc123",
        merchantName: String = "Apple Store"
    ) -> Transaction {
        Transaction(
            key: key,
            transactionType: "DEBIT",
            merchantName: merchantName,
            description: "iPhone",
            amount: Amount(value: 250.50, currency: "CAD"),
            postedDate: "2021-05-31",
            fromAccount: "Momentum Regular Visa",
            fromCardNumber: "4537350001688012"
        )
    }
}
