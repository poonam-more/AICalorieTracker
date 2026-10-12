import Foundation

protocol NutritionCalculatorProtocol: Sendable {
    /// Nutrition for `quantity` of `food`, with `quantity` in the food's own serving unit.
    func calculate(food: FoodItem, quantity: Double) -> Nutrition
}

extension NutritionCalculatorProtocol {
    /// The only way to build a MealItem, so stored nutrition always matches food and quantity.
    func mealItem(for food: FoodItem, quantity: Double, id: UUID = UUID()) -> MealItem {
        MealItem(id: id, foodItem: food, quantity: quantity,
                 calculatedNutrition: calculate(food: food, quantity: quantity))
    }
}

/// Deterministic: nutrition per serving x (quantity / servingSize). No AI, no I/O.
/// Invalid input (non-finite or non-positive) yields `.zero`; screens validate
/// quantity before this point and show an error.
struct NutritionCalculator: NutritionCalculatorProtocol {
    func calculate(food: FoodItem, quantity: Double) -> Nutrition {
        guard quantity.isFinite, quantity > 0,
              food.servingSize.isFinite, food.servingSize > 0 else { return .zero }
        return food.nutritionPerServing * (quantity / food.servingSize)
    }
}
