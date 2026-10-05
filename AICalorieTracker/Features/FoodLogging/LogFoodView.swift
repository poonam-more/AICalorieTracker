import SwiftUI

private enum LogOption: String, CaseIterable, Identifiable {
    case takePhoto = "Take photo"
    case choosePhoto = "Choose photo"
    case search = "Search food"
    case manual = "Enter manually"
    case recent = "Recent foods"

    var id: String { rawValue }
    var symbol: String {
        switch self {
        case .takePhoto: "camera.fill"
        case .choosePhoto: "photo.on.rectangle"
        case .search: "magnifyingglass"
        case .manual: "square.and.pencil"
        case .recent: "clock.arrow.circlepath"
        }
    }
    var detail: String {
        switch self {
        case .takePhoto, .choosePhoto: "Available in Phase 6"
        case .search, .manual: "Available in Phase 4"
        case .recent: "Available in Phase 5"
        }
    }
}

struct LogFoodView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: AppSpacing.s) {
                    ForEach(LogOption.allCases) { option in
                        HStack(spacing: AppSpacing.m) {
                            Image(systemName: option.symbol)
                                .font(.title3).foregroundStyle(AppColors.accent).frame(width: 32)
                            VStack(alignment: .leading, spacing: 2) {
                                Text(option.rawValue).font(AppTypography.headline)
                                Text(option.detail).font(AppTypography.caption).foregroundStyle(AppColors.textSecondary)
                            }
                            Spacer()
                        }
                        .cardStyle()
                        .accessibilityElement(children: .combine)
                    }
                    Text("Photo results are estimates. You'll review every portion before anything is saved.")
                        .font(AppTypography.caption).foregroundStyle(AppColors.textSecondary)
                        .padding(.top, AppSpacing.m)
                }
                .padding(AppSpacing.m)
            }
            .background(AppColors.background.ignoresSafeArea())
            .navigationTitle("Log food")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() } } }
        }
    }
}
