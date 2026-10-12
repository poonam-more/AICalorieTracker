import Foundation

struct NutritionGoal: Hashable, Codable, Sendable {
    var calorieTarget: Int
    var proteinTarget: Double
    var carbohydrateTarget: Double
    var fatTarget: Double

    /// Placeholder until onboarding calculates a real goal (Milestone 8).
    static let standard = NutritionGoal(calorieTarget: 2000, proteinTarget: 120, carbohydrateTarget: 220, fatTarget: 65)
}
