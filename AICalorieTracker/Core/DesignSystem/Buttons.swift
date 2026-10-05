import SwiftUI

struct PrimaryButton: View {
    let title: String
    var systemImage: String?
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Label {
                Text(title)
            } icon: {
                if let systemImage { Image(systemName: systemImage) }
            }
            .font(AppTypography.headline)
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppSpacing.m)
            .foregroundStyle(.white)
            .background(AppColors.accent, in: RoundedRectangle(cornerRadius: AppRadius.l, style: .continuous))
        }
    }
}

struct SecondaryButton: View {
    let title: String
    var systemImage: String?
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Label {
                Text(title)
            } icon: {
                if let systemImage { Image(systemName: systemImage) }
            }
            .font(AppTypography.headline)
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppSpacing.m)
            .foregroundStyle(AppColors.accent)
            .background(AppColors.accent.opacity(0.12), in: RoundedRectangle(cornerRadius: AppRadius.l, style: .continuous))
        }
    }
}
