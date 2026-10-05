import SwiftUI

enum AppColors {
    static let accent = Color(light: 0x2FB67C, dark: 0x3FD08F)
    static let background = Color(light: 0xF6F7F5, dark: 0x0F1110)
    static let card = Color(light: 0xFFFFFF, dark: 0x1A1D1B)
    static let textPrimary = Color(light: 0x151A17, dark: 0xF2F5F3)
    static let textSecondary = Color(light: 0x6B746F, dark: 0x9AA39E)
    static let protein = Color(light: 0xE5685A, dark: 0xF0786A)
    static let carbs = Color(light: 0xF0A93B, dark: 0xF5B94F)
    static let fat = Color(light: 0x4A90E2, dark: 0x5FA3F0)
}

enum AppSpacing {
    static let xs: CGFloat = 4
    static let s: CGFloat = 8
    static let m: CGFloat = 16
    static let l: CGFloat = 24
    static let xl: CGFloat = 32
}

enum AppRadius {
    static let m: CGFloat = 12
    static let l: CGFloat = 20
}

enum AppTypography {
    static let largeTitle = Font.system(.largeTitle, design: .rounded, weight: .bold)
    static let title = Font.system(.title2, design: .rounded, weight: .bold)
    static let headline = Font.system(.headline, design: .rounded, weight: .semibold)
    static let body = Font.system(.body, design: .rounded)
    static let caption = Font.system(.caption, design: .rounded)
    static let number = Font.system(.title, design: .rounded, weight: .bold)
}

extension Color {
    init(light: UInt32, dark: UInt32) {
        self = Color(uiColor: UIColor { traits in
            UIColor(hex: traits.userInterfaceStyle == .dark ? dark : light)
        })
    }
}

extension UIColor {
    convenience init(hex: UInt32) {
        self.init(red: CGFloat((hex >> 16) & 0xFF) / 255,
                  green: CGFloat((hex >> 8) & 0xFF) / 255,
                  blue: CGFloat(hex & 0xFF) / 255, alpha: 1)
    }
}

extension View {
    /// Rounded card with a soft shadow (stands in for AppShadow until Phase 15).
    func cardStyle() -> some View {
        padding(AppSpacing.m)
            .background(AppColors.card, in: RoundedRectangle(cornerRadius: AppRadius.l, style: .continuous))
            .shadow(color: .black.opacity(0.05), radius: 12, y: 4)
    }
}
