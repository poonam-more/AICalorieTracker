import Foundation

/// Stored in metric units; convert for display in the UI.
struct UserProfile: Identifiable, Hashable, Codable, Sendable {
    let id: UUID
    var name: String
    var age: Int
    var sex: Sex
    var heightCm: Double
    var weightKg: Double
    var activityLevel: ActivityLevel
    var goal: FitnessGoal
    var dietaryPreference: DietaryPreference
    var dietaryRestrictions: [String]
    let createdAt: Date
    var updatedAt: Date

    init(id: UUID = UUID(), name: String, age: Int, sex: Sex, heightCm: Double, weightKg: Double,
         activityLevel: ActivityLevel, goal: FitnessGoal, dietaryPreference: DietaryPreference,
         dietaryRestrictions: [String] = [], createdAt: Date = .now, updatedAt: Date = .now) {
        self.id = id
        self.name = name
        self.age = age
        self.sex = sex
        self.heightCm = heightCm
        self.weightKg = weightKg
        self.activityLevel = activityLevel
        self.goal = goal
        self.dietaryPreference = dietaryPreference
        self.dietaryRestrictions = dietaryRestrictions
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
