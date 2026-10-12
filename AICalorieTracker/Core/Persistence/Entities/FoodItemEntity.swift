import Foundation
import SwiftData

/// A food saved in the database. Holds user-created foods; the built-in list
/// ships in code (Milestone 4). Meals never point at this entity: they keep
/// their own snapshot, so editing a food can't rewrite history.
@Model
final class FoodItemEntity {
    @Attribute(.unique) var id: UUID
    var name: String
    var categoryRaw: String
    var servingSize: Double
    var servingUnitRaw: String
    var nutritionPerServing: NutritionValues
    var isUserCreated: Bool
    var createdAt: Date
    var updatedAt: Date

    init(id: UUID, name: String, categoryRaw: String, servingSize: Double, servingUnitRaw: String,
         nutritionPerServing: NutritionValues, isUserCreated: Bool, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.name = name
        self.categoryRaw = categoryRaw
        self.servingSize = servingSize
        self.servingUnitRaw = servingUnitRaw
        self.nutritionPerServing = nutritionPerServing
        self.isUserCreated = isUserCreated
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    convenience init(_ food: FoodItem, isUserCreated: Bool = true, now: Date = .now) {
        self.init(id: food.id, name: food.name, categoryRaw: food.category.rawValue,
                  servingSize: food.servingSize, servingUnitRaw: food.servingUnit.rawValue,
                  nutritionPerServing: NutritionValues(food.nutritionPerServing),
                  isUserCreated: isUserCreated, createdAt: now, updatedAt: now)
    }

    func update(from food: FoodItem, now: Date = .now) {
        name = food.name
        categoryRaw = food.category.rawValue
        servingSize = food.servingSize
        servingUnitRaw = food.servingUnit.rawValue
        nutritionPerServing = NutritionValues(food.nutritionPerServing)
        updatedAt = now
    }

    func toDomain() throws -> FoodItem {
        try FoodItem(id: id, name: name,
                     category: FoodCategory.decode(categoryRaw, field: "foodCategory"),
                     servingSize: servingSize,
                     servingUnit: ServingUnit.decode(servingUnitRaw, field: "servingUnit"),
                     nutritionPerServing: nutritionPerServing.domain)
    }
}
