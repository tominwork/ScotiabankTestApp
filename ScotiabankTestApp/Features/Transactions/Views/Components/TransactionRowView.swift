import SwiftUI

struct TransactionRowView: View {
    let transaction: Transaction

    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: AppSpacing.medium) {
                VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                    Text(transaction.merchantName)
                        .font(.headline)
                        .foregroundStyle(AppColors.textPrimary)
                        .multilineTextAlignment(.leading)
                    
                    if let description = transaction.description, !description.isEmpty {
                        Text(description)
                            .font(.subheadline)
                            .foregroundStyle(AppColors.textSecondary)
                            .multilineTextAlignment(.leading)
                    }
                }
                
                Spacer(minLength: AppSpacing.medium)
                
                HStack(spacing: AppSpacing.small) {
                    Text(transaction.formattedAmount)
                        .font(.headline)
                        .foregroundStyle(
                            transaction.type == .credit
                            ? AppColors.credit
                            : AppColors.textPrimary
                        )

                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
