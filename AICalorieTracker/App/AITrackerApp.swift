import SwiftUI

import SwiftUI
import SwiftData

@main
struct AITrackerApp: App {
    private let environment = AppEnvironment.mock
    /// Opened at launch so schema problems surface immediately.
    /// Repositories start using it in Milestone 3. Views never receive it.
    private let database: Result<ModelContainer, Error> = Result { try ModelContainerFactory.make() }

    var body: some Scene {
        WindowGroup {
            switch database {
            case .success: RootView(environment: environment)
            case .failure: LaunchErrorView()
            }
        }
    }
}

    