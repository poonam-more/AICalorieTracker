import Foundation

/// Energy and macronutrients. Calories are kcal; everything else is grams.
struct Nutrition: Hashable, Codable, Sendable {
    var calories: Double
    var protein: Double
    var carbohydrates: Double
    var fat: Double
    var fiber: Double = 0

    static let zero = Nutrition(calories: 0, protein: 0, carbohydrates: 0, fat: 0)

    static func + (lhs: Nutrition, rhs: Nutrition) -> Nutrition {
        Nutrition(calories: lhs.calories + rhs.calories,
                  protein: lhs.protein + rhs.protein,
                  carbohydrates: lhs.carbohydrates + rhs.carbohydrates,
                  fat: lhs.fat + rhs.fat,
                  fiber: lhs.fiber + rhs.fiber)
    }

    static func * (lhs: Nutrition, rhs: Double) -> Nutrition {
        Nutrition(calories: lhs.calories * rhs,
                  protein: lhs.protein * rhs,
                  carbohydrates: lhs.carbohydrates * rhs,
                  fat: lhs.fat * rhs,
                  fiber: lhs.fiber * rhs)
    }

    static func * (lhs: Double, rhs: Nutrition) -> Nutrition { rhs * lhs }

    static func += (lhs: inout Nutrition, rhs: Nutrition) { lhs = lhs + rhs }
}

extension Sequence where Element == Nutrition {
    /// The one place nutrition values are added up (meals, days, weeks).
    func summed() -> Nutrition { reduce(Nutrition.zero, +) }
}
