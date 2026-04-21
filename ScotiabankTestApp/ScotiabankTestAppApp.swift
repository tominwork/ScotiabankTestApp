import SwiftUI

@main
struct ScotiabankTestAppApp: App {
    private let container = AppContainer()
    
    var body: some Scene {
        WindowGroup {
            TransactionListView(
                viewModel: TransactionViewModel(
                    repository: container.transactionRepository
                )
            )
        }
    }
}
