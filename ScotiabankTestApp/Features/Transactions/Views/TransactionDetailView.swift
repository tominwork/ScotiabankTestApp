import SwiftUI

struct TransactionDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isTooltipExpanded = false

    let selectedTransaction: Transaction
    let onClose: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.large) {
                    VStack(spacing: AppSpacing.small) {
                        Image(systemName: "checkmark.circle")
                            .font(.system(size: 60).weight(.thin))
                            .foregroundStyle(
                                selectedTransaction.type == .credit
                                ? AppColors.credit
                                : AppColors.debit
                            )
                        
                        Text(selectedTransaction.type == .credit ?
                             "Credit transaction" : "Debit transaction")
                        .font(.title3.pointSize(28))
                        .foregroundStyle(AppColors.textPrimary)
                        .padding(.top, 20)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer()
                    
                    detailsSection
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ToolTipView(
                        icon: "buddy-tip-icon",
                        summaryText: "Transactions are processed Monday to Friday (excluding holidays).",
                        expandedText: "Transactions made before 8:30 pm ET Monday to Friday (excluding holidays) will show up in your account the same day.",
                        isExpanded: isTooltipExpanded,
                        expandActionTitle: "Show more",
                        collapseActionTitle: "Show less",
                        action: { isTooltipExpanded.toggle() }
                    )
                }
                .padding(AppSpacing.large)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            
            closeButton
        }
        .background(AppColors.screenBackground)
        .navigationTitle("Transaction Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder
    private var detailsSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium) {
            Text("From")
                .font(.subheadline)
                .foregroundStyle(AppColors.textSecondary)
            
            Text("\(Text(selectedTransaction.fromAccount).font(.headline).foregroundStyle(AppColors.textPrimary)) \(Text("(\(selectedTransaction.fromCardNumber.suffix(4)))").font(.subheadline).fontWeight(.semibold).foregroundStyle(AppColors.textSecondary))")
                .font(.subheadline)
            
            Divider()
            
            Text("Amount")
                .font(.subheadline)
                .foregroundStyle(AppColors.textSecondary)
            
            Text(selectedTransaction.formattedAmount)
                .font(.headline)
                .foregroundStyle(AppColors.textPrimary)
        }
        .padding()
    }
    
    private var closeButton: some View {
        Button {
            onClose()
            dismiss()
        } label: {
            Text("Close")
                .font(.callout.bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(AppColors.theme)
                .cornerRadius(8)
        }
        .padding(AppSpacing.large)
    }
}

#Preview("TransactionDetailView") {
    TransactionDetailView(
        selectedTransaction: Transaction(
            key: "kDk81_4xGkWW_vOVP_ExwK7GVUlzQ5YtYcuZARHuAQg=",
            transactionType: "credit",
            merchantName: "Mb - Cash Advance To - 1785",
            description: "Bill payment",
            amount: Amount(value: 20.25, currency: "CAD"),
            postedDate: "2024-03-11",
            fromAccount: "Momentum Regular Visa",
            fromCardNumber: "4537350001688012"),
        onClose: { })
}
