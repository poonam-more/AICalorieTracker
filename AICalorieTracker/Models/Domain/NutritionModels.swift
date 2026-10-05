import Foundation

enum MealType: String, CaseIterable, Identifiable, Sendable {
    case breakfast, lunch, dinner, snack
    var id: String { rawValue }
    var title: String { rawValue.capitalized }
    var symbol: String {
        switch self {
        case .breakfast: "sunrise.fill"
        case .lunch: "sun.max.fill"
        case .dinner: "moon.stars.fill"
        case .snack: "leaf.fill"
        }
    }
}

enum Confidence: String, Sendable {
    case high, medium, low
    var title: String { rawValue.capitalized }
}

struct FoodItem: Identifiable, Hashable, Sendable {
    let id = UUID()
    var name: String
    var quantity: Double
    var unit: String
    var calories: Int
    var protein: Double
    var carbs: Double
    var fat: Double
    var confidence: Confidence = .high
}

struct Meal: Identifiable, Sendable {
    let id = UUID()
    var type: MealType
    var items: [FoodItem]
    var loggedAt: Date = .now
    var calories: Int { items.reduce(0) { $0 + $1.calories } }
    var name: String { items.map(\.name).joined(separator: ", ") }
}

struct NutritionGoal: Sendable {
    var calories: Int
    var protein: Double
    var carbs: Double
    var fat: Double
    static let standard = NutritionGoal(calories: 2000, protein: 120, carbs: 220, fat: 65)
}

struct DailyNutrition: Sendable {
    var goal: NutritionGoal
    var meals: [Meal]
    var calories: Int { meals.reduce(0) { $0 + $1.calories } }
    var protein: Double { meals.flatMap(\.items).reduce(0) { $0 + $1.protein } }
    var carbs: Double { meals.flatMap(\.items).reduce(0) { $0 + $1.carbs } }
    var fat: Double { meals.flatMap(\.items).reduce(0) { $0 + $1.fat } }
}
