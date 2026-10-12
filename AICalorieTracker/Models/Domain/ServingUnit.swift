import Foundation

enum ServingUnit: String, CaseIterable, Identifiable, Codable, Sendable {
    case gram, ml, piece, cup, bowl, chapati, slice, tablespoon, teaspoon

    var id: String { rawValue }

    var shortName: String {
        switch self {
        case .gram: "g"
        case .ml: "ml"
        case .tablespoon: "tbsp"
        case .teaspoon: "tsp"
        default: rawValue
        }
    }
}
