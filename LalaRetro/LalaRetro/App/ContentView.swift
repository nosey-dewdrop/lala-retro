import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("home")
                }
                .tag(0)

            ScannerTabView()
                .tabItem {
                    Image(systemName: "barcode.viewfinder")
                    Text("scan")
                }
                .tag(1)

            LogReactionView()
                .tabItem {
                    Image(systemName: "exclamationmark.triangle")
                    Text("react")
                }
                .tag(2)

            AnalyzeView()
                .tabItem {
                    Image(systemName: "flask")
                    Text("analyze")
                }
                .tag(3)

            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("profile")
                }
                .tag(4)
        }
        .tint(Color(red: 0.75, green: 0.55, blue: 0.85))
    }
}

#Preview {
    ContentView()
}
