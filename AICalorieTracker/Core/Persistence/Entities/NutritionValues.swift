import Foundation

/// Storage shape for nutrition. Separate from the domain `Nutrition` so the
/// domain type can evolve without silently changing what is on disk.
struct NutritionValues: Codable, Hashable, Sendable {
    var calories: Double
    var protein: Double
    var carbohydrates: Double
    var fat: Double
    var fiber: Double

    init(_ nutrition: Nutrition) {
        calories = nutrition.calories
        protein = nutrition.protein
        carbohydrates = nutrition.carbohydrates
        fat = nutrition.fat
        fiber = nutrition.fiber
    }

    var domain: Nutrition {
        Nutrition(calories: calories, protein: protein, carbohydrates: carbohydrates, fat: fat, fiber: fiber)
    }
}
