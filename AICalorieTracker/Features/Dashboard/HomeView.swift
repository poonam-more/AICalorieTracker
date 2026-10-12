import SwiftUI

struct HomeView: View {
    @State private var viewModel: HomeViewModel
    @State private var showLogFood = false

    init(viewModel: HomeViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        let day = viewModel.nutrition
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.l) {
                VStack(alignment: .leading, spacing: AppSpacing.xs) {
                    Text(viewModel.greeting).font(AppTypography.largeTitle)
                    Text(Date.now, format: .dateTime.weekday(.wide).month().day())
                        .font(AppTypography.body).foregroundStyle(AppColors.textSecondary)
                }

                HStack(spacing: AppSpacing.l) {
                    CalorieRing(consumed: day.calories, target: day.goal.calorieTarget)
                        .frame(width: 130, height: 130)
                    VStack(alignment: .leading, spacing: AppSpacing.xs) {
                        Text("\(day.calories) / \(day.goal.calorieTarget) kcal").font(AppTypography.headline)
                        Text("Eaten today").font(AppTypography.caption).foregroundStyle(AppColors.textSecondary)
                    }
                    Spacer(minLength: 0)
                }
                .cardStyle()

                HStack(spacing: AppSpacing.s) {
                    MacroProgressView(name: "Protein", grams: day.protein, goal: day.goal.proteinTarget, color: AppColors.protein)
                    MacroProgressView(name: "Carbs", grams: day.carbs, goal: day.goal.carbohydrateTarget, color: AppColors.carbs)
                    MacroProgressView(name: "Fat", grams: day.fat, goal: day.goal.fatTarget, color: AppColors.fat)
                }

                SectionHeader(title: "Today's meals")
                ForEach(day.meals) { MealCard(meal: $0) }

                SecondaryButton(title: "Ask AI", systemImage: "sparkles") { }
            }
            .padding(AppSpacing.m)
        }
        .background(AppColors.background.ignoresSafeArea())
        .safeAreaInset(edge: .bottom) {
            PrimaryButton(title: "Log food", systemImage: "plus") { showLogFood = true }
                .padding(.horizontal, AppSpacing.m)
                .padding(.vertical, AppSpacing.s)
                .background(.ultraThinMaterial)
        }
        .task { await viewModel.load() }
        .sheet(isPresented: $showLogFood) { LogFoodView() }
    }
}
