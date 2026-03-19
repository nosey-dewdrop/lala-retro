import SwiftUI

@main
struct LalaRetroApp: App {
    init() {
        LocalStorageService.shared.loadMockDataIfNeeded()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
