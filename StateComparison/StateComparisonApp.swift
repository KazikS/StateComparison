import SwiftUI

@main
struct StateComparisonApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

struct RootView: View {
    var body: some View {
        TabView {
            NativeCharacterListView()
                .tabItem { Label("Native", systemImage: "swift") }
            ReduxCharacterListView()
                .tabItem { Label("Redux", systemImage: "arrow.triangle.2.circlepath") }
        }
    }
}
