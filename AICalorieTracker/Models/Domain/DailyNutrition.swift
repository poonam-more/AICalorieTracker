import Foundation

/// Phase 1 shape, now backed by `Nutrition`. Milestone 7 moves aggregation
/// into DailyNutritionService and this type becomes its output.
struct DailyNutrition: Sendable {
    var goal: NutritionGoal
    var meals: [Meal]

    var total: Nutrition { meals.map(\.nutrition).summed() }
    var calories: Int { Int(total.calories.rounded()) }
    var protein: Double { total.protein }
    var carbs: Double { total.carbohydrates }
    var fat: Double { total.fat }
    var fiber: Double { total.fiber }
}
