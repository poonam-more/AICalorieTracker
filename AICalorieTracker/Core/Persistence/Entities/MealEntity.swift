import Foundation
import SwiftData

@Model
final class MealEntity {
    @Attribute(.unique) var id: UUID
    var typeRaw: String
    var date: Date
    var createdAt: Date
    var updatedAt: Date
    @Relationship(deleteRule: .cascade, inverse: \MealItemEntity.meal)
    var items: [MealItemEntity] = []

    init(id: UUID, typeRaw: String, date: Date, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.typeRaw = typeRaw
        self.date = date
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    convenience init(_ meal: Meal) {
        self.init(id: meal.id, typeRaw: meal.type.rawValue, date: meal.date,
                  createdAt: meal.createdAt, updatedAt: meal.updatedAt)
        items = meal.items.enumerated().map { MealItemEntity($1, sortIndex: $0) }
    }

    /// Makes this record match `meal`. Items missing from `meal` are deleted
    /// (cascade only covers deleting the whole meal, not removed children).
    func update(from meal: Meal) {
        typeRaw = meal.type.rawValue
        date = meal.date
        updatedAt = meal.updatedAt

        let incomingIDs = Set(meal.items.map(\.id))
        for stale in items where !incomingIDs.contains(stale.id) {
            modelContext?.delete(stale)
        }
        items.removeAll { !incomingIDs.contains($0.id) }

        let existing = Dictionary(items.map { ($0.id, $0) }, uniquingKeysWith: { first, _ in first })
        for (index, item) in meal.items.enumerated() {
            if let entity = existing[item.id] {
                entity.update(from: item, sortIndex: index)
            } else {
                items.append(MealItemEntity(item, sortIndex: index))
            }
        }
    }

    func toDomain() throws -> Meal {
        try Meal(id: id, type: MealType.decode(typeRaw, field: "mealType"), date: date,
                 items: items.sorted { $0.sortIndex < $1.sortIndex }.map { try $0.toDomain() },
                 createdAt: createdAt, updatedAt: updatedAt)
    }
}
