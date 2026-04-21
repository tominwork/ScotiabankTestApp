import Foundation

@MainActor
@Observable
final class TransactionViewModel {
    private let repository: any TransactionRepository

    var transactions: [Transaction] = []
    var selectedTransaction: Transaction?
    var isLoading = false
    var errorMessage: String?

    init(repository: any TransactionRepository) {
        self.repository = repository
    }

    func loadTransactions() async {
        guard !isLoading else { return }

        isLoading = true
        defer { isLoading = false }

        do {
            transactions = try await repository.fetchTransactions()
            errorMessage = nil
        } catch let error as DataError {
            errorMessage = error.errorDescription
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func didSelect(_ transaction: Transaction) {
        selectedTransaction = transaction
    }

    func dismissDetails() {
        selectedTransaction = nil
    }
}
