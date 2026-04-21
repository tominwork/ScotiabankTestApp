import SwiftUI

struct TransactionListView: View {
    @State var viewModel: TransactionViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading && viewModel.transactions.isEmpty {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let errorMessage = viewModel.errorMessage, viewModel.transactions.isEmpty {
                    ContentUnavailableView(
                        "Unable to load transactions",
                        systemImage: "exclamationmark.triangle",
                        description: Text(errorMessage)
                    )
                } else {
                    List(viewModel.transactions) { transaction in
                        NavigationLink(value: transaction) {
                            TransactionRowView(transaction: transaction)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Transactions")
            .background(AppColors.screenBackground)
            .navigationDestination(for: Transaction.self) { transaction in
                TransactionDetailView(
                    selectedTransaction: transaction,
                    onClose: {
                        viewModel.dismissDetails()
                    })
            }
        }
        .task {
            await viewModel.loadTransactions()
        }
    }
}
