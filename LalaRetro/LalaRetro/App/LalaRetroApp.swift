import SwiftUI

@main
struct LalaRetroApp: App {
    init() {
        CloudSyncService.shared.startSync()
        LocalStorageService.shared.loadMockDataIfNeeded()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}
