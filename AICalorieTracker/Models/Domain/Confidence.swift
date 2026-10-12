import Foundation

/// Used by the AI flow in a later phase and by ConfidenceBadge.
enum Confidence: String, Sendable {
    case high, medium, low
    var title: String { rawValue.capitalized }
}
