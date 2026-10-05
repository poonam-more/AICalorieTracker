import SwiftUI

struct CalorieRing: View {
    let consumed: Int
    let target: Int
    private var progress: Double { target > 0 ? min(Double(consumed) / Double(target), 1) : 0 }

    var body: some View {
        ZStack {
            Circle().stroke(AppColors.accent.opacity(0.15), lineWidth: 14)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(AppColors.accent, style: StrokeStyle(lineWidth: 14, lineCap: .round))
                .rotationEffect(.degrees(-90))
            VStack(spacing: 2) {
                Text("\(max(target - consumed, 0))").font(AppTypography.number)
                Text("kcal left").font(AppTypography.caption).foregroundStyle(AppColors.textSecondary)
            }
        }
        .animation(.easeOut(duration: 0.8), value: progress)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(consumed) of \(target) calories consumed")
    }
}

struct MacroProgressView: View {
    let name: String
    let grams: Double
    let goal: Double
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.s) {
            Text(name).font(AppTypography.caption).foregroundStyle(AppColors.textSecondary)
            Text("\(Int(grams))g").font(AppTypography.headline)
            ProgressView(value: min(grams, goal), total: max(goal, 1)).tint(color)
            Text("of \(Int(goal))g").font(AppTypography.caption).foregroundStyle(AppColors.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
        .accessibilityElement(children: .combine)
    }
}

struct ConfidenceBadge: View {
    let confidence: Confidence

    private var color: Color {
        switch confidence {
        case .high: AppColors.accent
        case .medium: AppColors.carbs
        case .low: AppColors.protein
        }
    }

    var body: some View {
        Text("\(confidence.title) confidence")
            .font(AppTypography.caption.weight(.semibold))
            .padding(.horizontal, AppSpacing.s)
            .padding(.vertical, AppSpacing.xs)
            .foregroundStyle(color)
            .background(color.opacity(0.15), in: Capsule())
    }
}

struct SectionHeader: View {
    let title: String
    var body: some View {
        Text(title)
            .font(AppTypography.title)
            .foregroundStyle(AppColors.textPrimary)
            .accessibilityAddTraits(.isHeader)
    }
}

struct MealCard: View {
    let meal: Meal

    var body: some View {
        HStack(spacing: AppSpacing.m) {
            Image(systemName: meal.type.symbol)
                .font(.title3)
                .foregroundStyle(AppColors.accent)
                .frame(width: 48, height: 48)
                .background(AppColors.accent.opacity(0.12), in: RoundedRectangle(cornerRadius: AppRadius.m, style: .continuous))
            VStack(alignment: .leading, spacing: 2) {
                Text(meal.type.title).font(AppTypography.headline)
                Text(meal.name).font(AppTypography.caption).foregroundStyle(AppColors.textSecondary).lineLimit(2)
            }
            Spacer()
            Text("\(meal.calories) kcal").font(AppTypography.headline)
        }
        .cardStyle()
        .accessibilityElement(children: .combine)
    }
}

struct PlaceholderView: View {
    let title: String
    let systemImage: String

    var body: some View {
        VStack(spacing: AppSpacing.m) {
            Image(systemName: systemImage).font(.system(size: 44)).foregroundStyle(AppColors.accent)
            Text(title).font(AppTypography.title)
            Text("Coming in a later phase").font(AppTypography.body).foregroundStyle(AppColors.textSecondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background.ignoresSafeArea())
    }
}
