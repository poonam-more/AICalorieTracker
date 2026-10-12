import Foundation

/// Thrown when a stored record can't be turned back into a domain value
/// (for example a raw string written by a newer app version).
/// Repositories translate this into a user-facing storage error.
enum PersistenceMappingError: Error, Equatable {
    case unknownValue(field: String, value: String)
}

extension RawRepresentable where RawValue == String {
    static func decode(_ raw: String, field: String) throws -> Self {
        guard let value = Self(rawValue: raw) else {
            throw PersistenceMappingError.unknownValue(field: field, value: raw)
        }
        return value
    }
}
