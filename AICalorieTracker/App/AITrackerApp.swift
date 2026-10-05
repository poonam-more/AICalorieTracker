import SwiftUI

@main
struct AITrackerApp: App {
    private let environment = AppEnvironment.mock

    var body: some Scene {
        WindowGroup { RootView(environment: environment) }
    }
}
