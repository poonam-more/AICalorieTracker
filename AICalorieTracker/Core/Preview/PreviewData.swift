import Foundation

/// Sample foods and meals for previews, tests and the Phase 1 mock repository.
/// Milestone 9 restricts this to debug builds.
enum PreviewData {
    static let oats = FoodItem(name: "Oats", category: .breakfast, servingSize: 40, servingUnit: .gram,
                               calories: 150, protein: 5, carbohydrates: 27, fat: 3, fiber: 4)
    static let banana = FoodItem(name: "Banana", category: .fruit, servingSize: 1, servingUnit: .piece,
                                 calories: 105, protein: 1.3, carbohydrates: 27, fat: 0.4, fiber: 3)
    static let chickenCurry = FoodItem(name: "Chicken curry", category: .protein, servingSize: 1, servingUnit: .bowl,
                                       calories: 320, protein: 28, carbohydrates: 12, fat: 18, fiber: 2)
    static let rice = FoodItem(name: "Cooked rice", category: .carbohydrate, servingSize: 100, servingUnit: .gram,
                               calories: 130, protein: 2.7, carbohydrates: 28, fat: 0.3, fiber: 0.4)
    static let chapati = FoodItem(name: "Chapati", category: .carbohydrate, servingSize: 1, servingUnit: .chapati,
                                  calories: 105, protein: 3.5, carbohydrates: 18, fat: 2, fiber: 2.5)
    static let yogurt = FoodItem(name: "Greek yogurt", category: .protein, servingSize: 100, servingUnit: .gram,
                                 calories: 97, protein: 9, carbohydrates: 4, fat: 5)

    static func meals(calculator: any NutritionCalculatorProtocol = NutritionCalculator()) -> [Meal] {
        [
            Meal(type: .breakfast, items: [
                calculator.mealItem(for: oats, quantity: 40),
                calculator.mealItem(for: banana, quantity: 1)
            ]),
            Meal(type: .lunch, items: [
                calculator.mealItem(for: chickenCurry, quantity: 1),
                calculator.mealItem(for: rice, quantity: 180),
                calculator.mealItem(for: chapati, quantity: 2)
            ]),
            Meal(type: .snack, items: [
                calculator.mealItem(for: yogurt, quantity: 150)
            ])
        ]
    }
}
