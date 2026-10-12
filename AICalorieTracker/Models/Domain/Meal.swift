import Foundation

struct Meal: Identifiable, Hashable, Sendable {
    let id: UUID
    var type: MealType
    var date: Date
    var items: [MealItem]
    let createdAt: Date
    var updatedAt: Date

    init(id: UUID = UUID(), type: MealType, date: Date = .now, items: [MealItem] = [],
         createdAt: Date = .now, updatedAt: Date = .now) {
        self.id = id
        self.type = type
        self.date = date
        self.items = items
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    var nutrition: Nutrition { items.map(\.calculatedNutrition).summed() }
    var calories: Int { Int(nutrition.calories.rounded()) }
    var name: String { items.map(\.foodItem.name).joined(separator: ", ") }
}
