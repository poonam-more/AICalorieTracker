import SwiftUI

struct WelcomeView: View {
    let onContinue: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.l) {
            Spacer()
            Image(systemName: "camera.macro.circle.fill").font(.system(size: 64)).foregroundStyle(AppColors.accent)
            Text("Log meals with a photo.").font(AppTypography.largeTitle)
            Text("Snap your food, check the estimate, and keep track of your day without the typing.")
                .font(AppTypography.body).foregroundStyle(AppColors.textSecondary)
            Spacer()
            PrimaryButton(title: "Get started", action: onContinue)
            Text("Calorie and nutrient values are estimates, not medical advice.")
                .font(AppTypography.caption).foregroundStyle(AppColors.textSecondary)
                .frame(maxWidth: .infinity)
        }
        .padding(AppSpacing.l)
        .background(AppColors.background.ignoresSafeArea())
    }
}
