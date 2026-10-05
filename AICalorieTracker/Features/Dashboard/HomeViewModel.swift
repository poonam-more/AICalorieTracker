import Foundation
import Observation

@MainActor @Observable
final class HomeViewModel {
    private(set) var nutrition = DailyNutrition(goal: .standard, meals: [])
    private let repository: any MealRepositoryProtocol

    init(repository: any MealRepositoryProtocol) {
        self.repository = repository
    }

    var greeting: String {
        switch Calendar.current.component(.hour, from: .now) {
        case 5..<12: "Good morning 👋"
        case 12..<18: "Good afternoon 👋"
        default: "Good evening 👋"
        }
    }

    func load() async {
        // Phase 4: surface failures as AppError instead of ignoring them.
        if let meals = try? await repository.meals(for: .now) {
            nutrition = DailyNutrition(goal: nutrition.goal, meals: meals)
        }
    }
}
