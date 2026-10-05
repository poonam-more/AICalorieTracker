# AI Calorie Tracker: Architecture (Phase 1)

## 1. Product architecture
```
iOS app ──HTTPS──> API gateway ──> Auth ──> Nutrition service ──> Food database
                                        └─> AI service ──> OpenAI (never called from the app)
                                        └─> Analytics / usage limits
```
Phases 1 to 6 run with no backend. The app talks only to protocols, so a backend slots in later.

## 2. iOS architecture
```
SwiftUI Views  (layout only)
   ↓ observe
ViewModels     (@MainActor @Observable, UI state + intent)
   ↓ call protocols
Services       (FoodRecognition, NutritionCalculator, AIProviderResolver, HealthKit, Image)
Repositories   (Meal, Food, User, Nutrition, Weight)
   ↓
Core           (APIClient, SwiftData stack, Keychain)
```
Views never touch persistence or networking. Dependencies flow downward through protocols only.

## 3. Features
Onboarding · Dashboard · Log Food (photo, library, search, manual, recents) · Diary · Insights · AI Coach · Profile · HealthKit (optional) · Privacy controls.

## 4. Navigation
```
RootView: Splash → Welcome → Onboarding → MainTabView
MainTabView: Home | Diary | Insights | AI Coach | Profile
Home → Log Food (sheet) → [photo → analyze → confirm portions → confirm nutrition → save]
```

## 5. Folder structure
```
AITracker/
  App/            entry point, RootView
  Core/           DesignSystem, DI, Networking, Persistence, Security, Extensions
  Features/       Splash, Onboarding, Dashboard, FoodLogging, Diary, Insights, AICoach, Profile, Main
  Services/       AI, Nutrition, HealthKit, Image
  Repositories/   Meal, Food, User, Nutrition
  Models/Domain/  plain Swift value types
  Resources/
  Tests/
```

## 6. Domain models
Phase 1 uses plain structs: `Meal`, `FoodItem`, `NutritionGoal`, `DailyNutrition`, `MealType`, `Confidence`.
Phase 5 adds SwiftData `@Model` types (UserProfile, WeightEntry, WaterEntry, MealPhoto, AIAnalysis, AIAnalysisFeedback, FoodDatabaseItem). Repositories map them to these domain structs, so the UI stays independent of storage.

## 7. AI architecture
```
Photo → FoodRecognitionService (perception only: "2 chapatis", rough portion, confidence)
      → FoodDatabaseProtocol lookup → NutritionCalculatorProtocol (deterministic math)
      → user confirmation → save (+ correction stored as AIAnalysisFeedback)
```
The LLM is never the source of truth for nutrition numbers. `AIProviderResolver` picks `.onDevice` (Foundation Models, text tasks), `.openAI` (via backend, vision) or `.unavailable`. Responses decode into our own `FoodAnalysis` type, never OpenAI's format.

## 8. Networking
`APIClientProtocol` + `APIClient` (URLSession, async/await) + `APIEndpoint` enum. Handles status codes, decoding, auth header, retry with backoff, timeouts, cancellation, rate limits. Everything maps to a typed `AppError`. No URLSession code in ViewModels.

## 9. Persistence
SwiftData behind repository protocols (`MealRepositoryProtocol` first). Views and ViewModels see only domain structs. Each repository has a mock for tests.

## 10. Dependency injection
Constructor injection from one composition root, `AppEnvironment` (`.mock` now, `.live` later). No singletons, no global state.

## 11. Design system
Tokens: `AppColors` (dynamic light/dark), `AppSpacing`, `AppRadius`, `AppTypography` (Dynamic Type text styles). Components: PrimaryButton, SecondaryButton, CalorieRing, MacroProgressView, MealCard, ConfidenceBadge, SectionHeader. Remaining components arrive with the screens that need them.

## 12. Roadmap
Phases 2 to 16 as in the brief: onboarding → dashboard → manual logging → SwiftData → camera → OpenAI → nutrition math → AI Coach → HealthKit → insights → tests → security → performance → accessibility → App Store.

## Phase 1 notes
- "Log food" is a bottom bar on Home, not a floating button across all tabs. A global floating action is a Phase 3 refinement.
- Onboarding has the goal step only; steps 2 to 8 are Phase 2.
