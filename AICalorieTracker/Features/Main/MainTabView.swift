import SwiftUI

struct MainTabView: View {
    let environment: AppEnvironment

    var body: some View {
        TabView {
            HomeView(viewModel: HomeViewModel(repository: environment.mealRepository))
                .tabItem { Label("Home", systemImage: "house.fill") }
            PlaceholderView(title: "Diary", systemImage: "calendar")
                .tabItem { Label("Diary", systemImage: "book.fill") }
            PlaceholderView(title: "Insights", systemImage: "chart.line.uptrend.xyaxis")
                .tabItem { Label("Insights", systemImage: "chart.bar.fill") }
            PlaceholderView(title: "AI Coach", systemImage: "sparkles")
                .tabItem { Label("AI Coach", systemImage: "sparkles") }
            PlaceholderView(title: "Profile", systemImage: "person.crop.circle")
                .tabItem { Label("Profile", systemImage: "person.fill") }
        }
        .tint(AppColors.accent)
    }
}
