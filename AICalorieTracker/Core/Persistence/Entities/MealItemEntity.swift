import Foundation
import SwiftData

/// One logged food. Stores a full snapshot of the food and the nutrition
/// calculated at save time, plus `sortIndex` because relationship arrays
/// have no guaranteed order.
@Model
final class MealItemEntity {
    @Attribute(.unique) var id: UUID
    var sortIndex: Int
    var foodID: UUID
    var foodName: String
    var foodCategoryRaw: String
    var servingSize: Double
    var servingUnitRaw: String
    var foodNutritionPerServing: NutritionValues
    var quantity: Double
    var calculatedNutrition: NutritionValues
    var meal: MealEntity?

    init(id: UUID, sortIndex: Int, foodID: UUID, foodName: String, foodCategoryRaw: String,
         servingSize: Double, servingUnitRaw: String, foodNutritionPerServing: NutritionValues,
         quantity: Double, calculatedNutrition: NutritionValues) {
        self.id = id
        self.sortIndex = sortIndex
        self.foodID = foodID
        self.foodName = foodName
        self.foodCategoryRaw = foodCategoryRaw
        self.servingSize = servingSize
        self.servingUnitRaw = servingUnitRaw
        self.foodNutritionPerServing = foodNutritionPerServing
        self.quantity = quantity
        self.calculatedNutrition = calculatedNutrition
    }

    convenience init(_ item: MealItem, sortIndex: Int) {
        let food = item.foodItem
        self.init(id: item.id, sortIndex: sortIndex, foodID: food.id, foodName: food.name,
                  foodCategoryRaw: food.category.rawValue, servingSize: food.servingSize,
                  servingUnitRaw: food.servingUnit.rawValue,
                  foodNutritionPerServing: NutritionValues(food.nutritionPerServing),
                  quantity: item.quantity, calculatedNutrition: NutritionValues(item.calculatedNutrition))
    }

    func update(from item: MealItem, sortIndex: Int) {
        let food = item.foodItem
        self.sortIndex = sortIndex
        foodID = food.id
        foodName = food.name
        foodCategoryRaw = food.category.rawValue
        servingSize = food.servingSize
        servingUnitRaw = food.servingUnit.rawValue
        foodNutritionPerServing = NutritionValues(food.nutritionPerServing)
        quantity = item.quantity
        calculatedNutrition = NutritionValues(item.calculatedNutrition)
    }

    func toDomain() throws -> MealItem {
        let food = try FoodItem(id: foodID, name: foodName,
                                category: FoodCategory.decode(foodCategoryRaw, field: "foodCategory"),
                                servingSize: servingSize,
                                servingUnit: ServingUnit.decode(servingUnitRaw, field: "servingUnit"),
                                nutritionPerServing: foodNutritionPerServing.domain)
        return MealItem(id: id, foodItem: food, quantity: quantity, calculatedNutrition: calculatedNutrition.domain)
    }
}
