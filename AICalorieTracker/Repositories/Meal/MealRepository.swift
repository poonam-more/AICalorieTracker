import Foundation

protocol MealRepositoryProtocol: Sendable {
    func meals(for date: Date) async throws -> [Meal]
}

struct MockMealRepository: MealRepositoryProtocol {
    func meals(for date: Date) async throws -> [Meal] {
        [
            Meal(type: .breakfast, items: [
                FoodItem(name: "Oatmeal", quantity: 40, unit: "g", calories: 150, protein: 5, carbs: 27, fat: 3),
                FoodItem(name: "Banana", quantity: 1, unit: "medium", calories: 105, protein: 1, carbs: 27, fat: 0)
            ]),
            Meal(type: .lunch, items: [
                FoodItem(name: "Chicken curry", quantity: 1, unit: "bowl", calories: 320, protein: 28, carbs: 12, fat: 18, confidence: .medium),
                FoodItem(name: "Basmati rice", quantity: 180, unit: "g", calories: 235, protein: 5, carbs: 50, fat: 1),
                FoodItem(name: "Chapati", quantity: 2, unit: "pieces", calories: 210, protein: 7, carbs: 36, fat: 4)
            ]),
            Meal(type: .snack, items: [
                FoodItem(name: "Greek yogurt", quantity: 150, unit: "g", calories: 130, protein: 15, carbs: 6, fat: 5)
            ])
        ]
    }
}
