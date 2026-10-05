import SwiftUI

struct SplashView: View {
    let onFinish: () -> Void
    @State private var appeared = false

    var body: some View {
        ZStack {
            AppColors.accent.ignoresSafeArea()
            VStack(spacing: AppSpacing.m) {
                Image(systemName: "fork.knife.circle.fill").font(.system(size: 72))
                Text("AI Calorie Tracker").font(AppTypography.title)
            }
            .foregroundStyle(.white)
            .scaleEffect(appeared ? 1 : 0.85)
            .opacity(appeared ? 1 : 0)
        }
        .task {
            withAnimation(.spring) { appeared = true }
            try? await Task.sleep(for: .seconds(1.2))
            onFinish()
        }
    }
}
