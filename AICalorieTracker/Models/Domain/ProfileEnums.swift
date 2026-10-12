import Foundation

enum Sex: String, CaseIterable, Identifiable, Codable, Sendable {
    case male, female, other
    var id: String { rawValue }
    var title: String { rawValue.capitalized }
}

enum ActivityLevel: String, CaseIterable, Identifiable, Codable, Sendable {
    case sedentary, lightlyActive, moderatelyActive, veryActive, extraActive
    var id: String { rawValue }
    var title: String {
        switch self {
        case .sedentary: "Sedentary"
        case .lightlyActive: "Lightly active"
        case .moderatelyActive: "Moderately active"
        case .veryActive: "Very active"
        case .extraActive: "Extra active"
        }
    }
}

enum FitnessGoal: String, CaseIterable, Identifiable, Codable, Sendable {
    case loseWeight, maintainWeight, gainWeight, improveNutrition, trackMacros
    var id: String { rawValue }
    var title: String {
        switch self {
        case .loseWeight: "Lose weight"
        case .maintainWeight: "Maintain weight"
        case .gainWeight: "Gain weight"
        case .improveNutrition: "Improve nutrition"
        case .trackMacros: "Track macros"
        }
    }
}

enum DietaryPreference: String, CaseIterable, Identifiable, Codable, Sendable {
    case vegetarian, vegan, eggetarian, nonVegetarian, other
    var id: String { rawValue }
    var title: String {
        switch self {
        case .vegetarian: "Vegetarian"
        case .vegan: "Vegan"
        case .eggetarian: "Eggetarian"
        case .nonVegetarian: "Non-vegetarian"
        case .other: "Other"
        }
    }
}
