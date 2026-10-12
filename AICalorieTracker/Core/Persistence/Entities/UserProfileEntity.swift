import Foundation
import SwiftData

@Model
final class UserProfileEntity {
    @Attribute(.unique) var id: UUID
    var name: String
    var age: Int
    var sexRaw: String
    var heightCm: Double
    var weightKg: Double
    var activityLevelRaw: String
    var goalRaw: String
    var dietaryPreferenceRaw: String
    var dietaryRestrictions: [String]
    var createdAt: Date
    var updatedAt: Date

    init(id: UUID, name: String, age: Int, sexRaw: String, heightCm: Double, weightKg: Double,
         activityLevelRaw: String, goalRaw: String, dietaryPreferenceRaw: String,
         dietaryRestrictions: [String], createdAt: Date, updatedAt: Date) {
        self.id = id
        self.name = name
        self.age = age
        self.sexRaw = sexRaw
        self.heightCm = heightCm
        self.weightKg = weightKg
        self.activityLevelRaw = activityLevelRaw
        self.goalRaw = goalRaw
        self.dietaryPreferenceRaw = dietaryPreferenceRaw
        self.dietaryRestrictions = dietaryRestrictions
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    convenience init(_ profile: UserProfile) {
        self.init(id: profile.id, name: profile.name, age: profile.age, sexRaw: profile.sex.rawValue,
                  heightCm: profile.heightCm, weightKg: profile.weightKg,
                  activityLevelRaw: profile.activityLevel.rawValue, goalRaw: profile.goal.rawValue,
                  dietaryPreferenceRaw: profile.dietaryPreference.rawValue,
                  dietaryRestrictions: profile.dietaryRestrictions,
                  createdAt: profile.createdAt, updatedAt: profile.updatedAt)
    }

    func update(from profile: UserProfile) {
        name = profile.name
        age = profile.age
        sexRaw = profile.sex.rawValue
        heightCm = profile.heightCm
        weightKg = profile.weightKg
        activityLevelRaw = profile.activityLevel.rawValue
        goalRaw = profile.goal.rawValue
        dietaryPreferenceRaw = profile.dietaryPreference.rawValue
        dietaryRestrictions = profile.dietaryRestrictions
        updatedAt = profile.updatedAt
    }

    func toDomain() throws -> UserProfile {
        try UserProfile(id: id, name: name, age: age, sex: Sex.decode(sexRaw, field: "sex"),
                        heightCm: heightCm, weightKg: weightKg,
                        activityLevel: ActivityLevel.decode(activityLevelRaw, field: "activityLevel"),
                        goal: FitnessGoal.decode(goalRaw, field: "goal"),
                        dietaryPreference: DietaryPreference.decode(dietaryPreferenceRaw, field: "dietaryPreference"),
                        dietaryRestrictions: dietaryRestrictions, createdAt: createdAt, updatedAt: updatedAt)
    }
}
