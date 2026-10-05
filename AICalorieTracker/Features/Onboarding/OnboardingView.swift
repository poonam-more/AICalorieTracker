import SwiftUI

enum OnboardingGoal: String, CaseIterable, Identifiable {
    case lose = "Lose weight"
    case maintain = "Maintain weight"
    case gain = "Gain weight"
    case nutrition = "Improve nutrition"
    case macros = "Track macros"
    var id: String { rawValue }
}

/// Phase 1 shows only the goal step. Phase 2 adds the remaining screens and a ViewModel.
struct OnboardingView: View {
    let onFinish: () -> Void
    @State private var selection: OnboardingGoal?

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.m) {
            Text("What's your main goal?").font(AppTypography.largeTitle)
            ForEach(OnboardingGoal.allCases) { goal in
                Button { selection = goal } label: {
                    HStack {
                        Text(goal.rawValue).font(AppTypography.headline)
                        Spacer()
                        if selection == goal { Image(systemName: "checkmark.circle.fill").foregroundStyle(AppColors.accent) }
                    }
                    .foregroundStyle(AppColors.textPrimary)
                    .cardStyle()
                    .overlay(RoundedRectangle(cornerRadius: AppRadius.l, style: .continuous)
                        .stroke(selection == goal ? AppColors.accent : .clear, lineWidth: 2))
                }
                .buttonStyle(.plain)
            }
            Spacer()
            PrimaryButton(title: "Continue", action: onFinish).disabled(selection == nil).opacity(selection == nil ? 0.5 : 1)
        }
        .padding(AppSpacing.l)
        .background(AppColors.background.ignoresSafeArea())
        .animation(.snappy, value: selection)
    }
}
