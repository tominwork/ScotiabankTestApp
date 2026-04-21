import SwiftUI

struct ToolTipView: View {
    let icon: String
    let summaryText: String
    let expandedText: String?
    let isExpanded: Bool
    let expandActionTitle: String
    let collapseActionTitle: String
    let action: () -> Void
    
    var body: some View {
        HStack(alignment: .top, spacing: AppSpacing.small) {
            Image(icon)
                .font(.headline)
                .foregroundStyle(AppColors.accent)
            
            VStack(alignment: .leading, spacing: AppSpacing.small) {
                if isExpanded {
                    Text(summaryText)
                        .font(.subheadline)
                        .foregroundStyle(AppColors.textPrimary)
                    
                    if let expandedText {
                        inlineActionText(
                            text: expandedText,
                            actionTitle: collapseActionTitle
                        )
                        .transition(.opacity.combined(with: .move(edge: .top)))
                        .padding(.top, AppSpacing.medium)
                    }
                } else {
                    inlineActionText(
                        text: summaryText,
                        actionTitle: expandActionTitle
                    )
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(AppSpacing.medium)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(AppColors.screenBackground)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(AppColors.divider, lineWidth: 1)
        )
        .animation(.easeInOut(duration: 0.3), value: isExpanded)
    }
    
    
    private func inlineActionText(text: String, actionTitle: String) -> some View {
        Text("\(Text(text).foregroundStyle(AppColors.textPrimary)) \(Text(actionTitle).font(.subheadline).fontWeight(.semibold) .foregroundStyle(AppColors.accent))")
            .font(.subheadline)
            .onTapGesture {
                action()
            }
    }
}

#Preview("Collapsed") {
    ToolTipView(
        icon: "buddy-tip-icon",
        summaryText: "Transactions are processed Monday to Friday (excluding holidays).",
        expandedText: "Transactions made before 8:30 pm ET Monday to Friday (excluding holidays) will show up in your account the same day.",
        isExpanded: false,
        expandActionTitle: "Show more",
        collapseActionTitle: "Show less",
        action: {}
    )
    .padding()
    .background(AppColors.screenBackground)
}

#Preview("Expanded") {
    ToolTipView(
        icon: "buddy-tip-icon",
        summaryText: "Transactions are processed Monday to Friday (excluding holidays).",
        expandedText: "Transactions made before 8:30 pm ET Monday to Friday (excluding holidays) will show up in your account the same day.",
        isExpanded: true,
        expandActionTitle: "Show More",
        collapseActionTitle: "Show Less",
        action: {}
    )
    .padding()
    .background(AppColors.screenBackground)
}
