import Foundation

/// Composition root: the single place where concrete services are chosen.
/// Phase 5 adds `.live` (SwiftData); Phase 7 adds AI services.
struct AppEnvironment {
    let mealRepository: any MealRepositoryProtocol

    static let mock = AppEnvironment(mealRepository: MockMealRepository())
}
