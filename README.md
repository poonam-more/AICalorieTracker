# AI Calorie Tracker

An iOS calorie and nutrition tracker built with SwiftUI. Log meals by photo, search, or manual entry, and track daily calories and macros against a personal target.

The design rule behind the whole app: **AI perceives, the database calculates, the user confirms.** A model may suggest "2 chapatis and some dal", but nutrition numbers always come from a food database through a deterministic calculator, and nothing is saved until the user reviews it.

> Calorie and nutrient values are estimates and are not medical advice.

## Status

| Phase | Scope | Status |
|---|---|---|
| 1 | Architecture, design system, navigation, mock UI | Done |
| 2 | Offline tracker: SwiftData, food database, manual logging, diary, onboarding, goals | In progress (Milestone 2 of 9: SwiftData entities and container) |
| 3 | AI photo logging through a backend | Planned (API contract drafted) |
| Later | AI Coach, HealthKit, insights, hardening, App Store | Planned |

### What works today
- Splash, welcome, goal selection, and a 5-tab shell (Home, Diary, Insights, AI Coach, Profile).
- Home dashboard with calorie ring, macro cards and meals, driven by **sample data**.
- Log Food sheet (placeholder options).
- `NutritionCalculator` and the `Nutrition` value type.
- SwiftData schema (entities, mapping, versioned container), opened at launch but not yet used by any screen.
- 14 unit tests.

### Not built yet
Repositories that connect screens to storage, food search, manual logging, diary, full onboarding, camera and photo analysis, and any AI.

## Requirements
- Xcode 16 or later
- iOS 17 or later (uses the Observation framework)
- No third-party dependencies

## Getting started
1. Open the Xcode project and select an iPhone simulator.
2. Build and run (⌘R).
3. Run tests with ⌘U, or from the command line:
   ```bash
   xcodebuild test -scheme AITracker -destination 'platform=iOS Simulator,name=<simulator name>'
   ```

Tests need no network, API key, or camera.

## Architecture

```
Views  →  ViewModels  →  Services / Use cases  →  Repository protocols  →  Implementations  →  SwiftData
```

- Views contain layout only. Business logic lives in ViewModels and services.
- Views and ViewModels never touch `ModelContext` or `URLSession`.
- Dependencies are injected through one composition root, `AppEnvironment`. No singletons.
- Domain models are plain Swift value types. SwiftData entities (Phase 2) are separate and mapped by repositories.

### Folder structure

```
AITracker/
  App/                  entry point, RootView
  Core/
    DI/                 AppEnvironment
    DesignSystem/       tokens, buttons, nutrition components
    Persistence/        SwiftData entities, mapping, versioned schema, container factory
    Preview/            PreviewData (sample foods and meals)
  Features/             Splash, Onboarding, Dashboard, FoodLogging, Main
  Models/Domain/        Nutrition, FoodItem, MealItem, Meal, NutritionGoal, UserProfile, enums
  Repositories/Meal/    MealRepositoryProtocol (+ temporary mock)
  Services/Nutrition/   NutritionCalculator
  Tests/Nutrition/
docs/phase3/            API_CONTRACT.md
```

### Domain model
- `Nutrition`: calories (kcal), protein, carbohydrates, fat, fiber (grams). Supports `+`, `*`, and `.summed()`.
- `FoodItem`: a database food with nutrition **per serving** (`servingSize` x `servingUnit`).
- `MealItem`: a food, a quantity, and its calculated nutrition. Immutable, so values cannot go stale.
- `Meal`: type (breakfast, lunch, dinner, snack), date, and items.

### Nutrition calculation
```
nutrition = food.nutritionPerServing × (quantity ÷ food.servingSize)
```
Quantity is measured in the food's own serving unit. The calculator is deterministic and does no I/O. Invalid input (zero, negative, NaN) returns zero; screens validate quantity first.

## AI design (Phase 3, planned)

```
Photo → image preprocessing → backend → AI vision → schema validation
      → candidate foods and portions → match to local food database
      → NutritionCalculator → user review and edit → save
```

- The iOS app talks only to our backend. The AI provider key never ships in the app.
- The backend returns structured, validated JSON. See [`docs/phase3/API_CONTRACT.md`](docs/phase3/API_CONTRACT.md).
- Confidence labels (high, medium, low) are heuristic, not calibrated probabilities.
- Photos are uploaded only after an explicit user action.

## Security and privacy principles
- No API keys in source, `Info.plist`, `UserDefaults`, or Git. Backend secrets come from environment variables or a secret manager. Keep `.env` files git-ignored.
- Send the minimum data needed. No HealthKit or profile data goes to the AI service.
- Do not log image bytes.
- A prototype backend needs HTTPS, rate limits and a spend cap. Public release additionally needs App Attest, accounts and quotas. Details are in the API contract.

## Roadmap

**Phase 2 milestones:** 1 domain and calculator (done) · 2 SwiftData persistence (done) · 3 repositories · 4 food database and search · 5 manual logging and portion editor · 6 diary · 7 dashboard integration · 8 onboarding, profile and goals · 9 tests.

**Phase 3 milestones:** 1 review and API contract · 2 photo selection, camera, preprocessing · 3 recognition contracts and transport models · 4 backend and AI integration · 5 recognition and domain mapping · 6 review screen · 7 calculator and repository integration · 8 dashboard and diary wiring · 9 errors, privacy, cancellation · 10 tests and QA.

## License
Not yet chosen.
