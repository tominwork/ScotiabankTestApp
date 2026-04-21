import XCTest
@testable import ScotiabankTestApp

final class ScotiabankTestAppTests: XCTestCase {
    
    @MainActor
    func test_TransactionViewModelLoadsTransactions() async {
        let repository = MockTransactionRepository {
            [Transaction.transactionItem(merchantName: "Test Merchant")]
        }
        let viewModel = TransactionViewModel(repository: repository)
        
        await viewModel.loadTransactions()
        
        XCTAssertEqual(viewModel.transactions.count, 1)
        XCTAssertEqual(viewModel.transactions.first?.merchantName, "Test Merchant")
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    @MainActor
    func test_TransactionViewModelHandlesError() async {
        let decodingError = NSError(
            domain: "ScotiabankTestAppTests",
            code: 1,
            userInfo: [NSLocalizedDescriptionKey: "Invalid transaction data"]
        )
        let expectedError = DataError.decodingFailed(decodingError)
        let repository = MockTransactionRepository {
            throw expectedError
        }
        let viewModel = TransactionViewModel(repository: repository)
        
        await viewModel.loadTransactions()
        
        XCTAssertTrue(viewModel.transactions.isEmpty)
        XCTAssertEqual(viewModel.errorMessage, expectedError.localizedDescription)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    @MainActor
    func test_localRepository_loadsTransactionsFromLocalJSON() async throws {
        let loader = MockResourceLoader(data: sampleJSON.data(using: .utf8))
        
        let repository = LocalTransactionRepository(
            resourceLoader: loader,
            jsonFileName: "transaction-list"
        )
        
        let transactions = try await repository.fetchTransactions()
        
        XCTAssertEqual(transactions.count, 1)
        XCTAssertEqual(transactions.first?.merchantName, "Mb - Cash Advance To - 1785")
    }
    
    private let sampleJSON = """
        {
            "transactions": [
                {
                    "key": "kDk81_4xGkWW_vOVP_ExwK7GVUlzQ5YtYcuZARHuAQg=",
                    "transaction_type": "DEBIT",
                    "merchant_name": "Mb - Cash Advance To - 1785",
                    "description": "Bill payment",
                    "amount": {
                        "value": 200.20,
                        "currency": "CAD"
                    },
                    "posted_date": "2021-05-31",
                    "from_account": "Momentum Regular Visa",
                    "from_card_number": "4537350001688012"
                }
            ]
        }
        """
}
