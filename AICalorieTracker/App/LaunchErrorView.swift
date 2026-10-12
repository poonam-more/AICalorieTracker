import SwiftUI

/// Shown if the local database can't be opened. No technical details for the user.
struct LaunchErrorView: View {
    var body: some View {
        VStack(spacing: AppSpacing.m) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 44))
                .foregroundStyle(AppColors.carbs)
            Text("We couldn't open your data").font(AppTypography.title)
            Text("Please close and reopen the app. If this keeps happening, contact support.")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(AppSpacing.l)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background.ignoresSafeArea())
        .accessibilityElement(children: .combine)
    }
}
