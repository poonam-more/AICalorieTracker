import Foundation

protocol MealRepositoryProtocol: Sendable {
    func meals(for date: Date) async throws -> [Meal]
}

/// Temporary until Milestone 3 adds the SwiftData-backed repository.
struct MockMealRepository: MealRepositoryProtocol {
    func meals(for date: Date) async throws -> [Meal] { PreviewData.meals() }
}
