import Foundation

enum FoodCategory: String, CaseIterable, Codable, Sendable {
    case breakfast, protein, carbohydrate, vegetable, fruit, snack, other
}

/// A food from the database. Nutrition values are per serving
/// (`servingSize` x `servingUnit`) and are approximate estimates.
struct FoodItem: Identifiable, Hashable, Codable, Sendable {
    let id: UUID
    var name: String
    var category: FoodCategory
    var servingSize: Double
    var servingUnit: ServingUnit
    var nutritionPerServing: Nutrition

    init(id: UUID = UUID(), name: String, category: FoodCategory = .other,
         servingSize: Double, servingUnit: ServingUnit, nutritionPerServing: Nutrition) {
        self.id = id
        self.name = name
        self.category = category
        self.servingSize = servingSize
        self.servingUnit = servingUnit
        self.nutritionPerServing = nutritionPerServing
    }

    init(id: UUID = UUID(), name: String, category: FoodCategory = .other,
         servingSize: Double, servingUnit: ServingUnit,
         calories: Double, protein: Double, carbohydrates: Double, fat: Double, fiber: Double = 0) {
        self.init(id: id, name: name, category: category, servingSize: servingSize, servingUnit: servingUnit,
                  nutritionPerServing: Nutrition(calories: calories, protein: protein,
                                                 carbohydrates: carbohydrates, fat: fat, fiber: fiber))
    }
}
