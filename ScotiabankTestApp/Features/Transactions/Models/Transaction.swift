import Foundation

struct TransactionResponse: Codable, Sendable {
    let transactions: [Transaction]
}

struct Transaction: Codable, Sendable, Identifiable, Hashable {
    let key: String
    let transactionType: String
    let merchantName: String
    let description: String?
    let amount: Amount
    let postedDate: String
    let fromAccount: String
    let fromCardNumber: String
    
    var id: String { key }
}

struct Amount: Codable, Sendable, Hashable {
    let value: Decimal
    let currency: String
}

extension Transaction {
    var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = amount.currency
        formatter.locale = Locale.current
        return formatter.string(from: amount.value as NSDecimalNumber) ?? "\(amount.currency) \(amount)"
    }
    
    var type: TransactionType {
        transactionType.lowercased() == "credit" ? .credit : .debit
    }
}

enum TransactionType {
    case credit
    case debit
}
