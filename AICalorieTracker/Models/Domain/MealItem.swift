import Foundation

/// One food in a meal. Immutable on purpose: to edit, build a new item through
/// `NutritionCalculatorProtocol.mealItem(for:quantity:id:)` so the stored
/// nutrition can never be stale. `quantity` is in the food's own `servingUnit`.
struct MealItem: Identifiable, Hashable, Codable, Sendable {
    let id: UUID
    let foodItem: FoodItem
    let quantity: Double
    let calculatedNutrition: Nutrition

    init(id: UUID = UUID(), foodItem: FoodItem, quantity: Double, calculatedNutrition: Nutrition) {
        self.id = id
        self.foodItem = foodItem
        self.quantity = quantity
        self.calculatedNutrition = calculatedNutrition
    }
}
