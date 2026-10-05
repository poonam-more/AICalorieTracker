import SwiftUI

enum AppPhase { case splash, welcome, onboarding, main }

struct RootView: View {
    let environment: AppEnvironment
    @State private var phase: AppPhase = .splash

    var body: some View {
        Group {
            switch phase {
            case .splash: SplashView { phase = .welcome }
            case .welcome: WelcomeView { phase = .onboarding }
            case .onboarding: OnboardingView { phase = .main }
            case .main: MainTabView(environment: environment)
            }
        }
        .animation(.easeInOut(duration: 0.35), value: phase)
    }
}
