import SwiftData
import SwiftUI

@main
struct LeepyApp: App {
  let container: ModelContainer
  @StateObject private var appState = RlbHdbTvacState()
  @StateObject private var purchaseManager = VvolHdqhEszePurchase()
  init() {
    let appearance = UITabBarAppearance()
    appearance.configureWithTransparentBackground()
    appearance.backgroundEffect = nil
    appearance.backgroundColor = .clear
    UITabBar.appearance().backgroundColor = .clear
    UITabBar.appearance().standardAppearance = appearance
    UITabBar.appearance().scrollEdgeAppearance = appearance
    ScreenUtil.shared.updateSize()
    do {
      container =
        try ModelContainer(
          for:
            ChatModel.self,
          MessageModel.self,
          UserModel.self,
          CommentModel.self,
          DynamicModel.self,
        )
    } catch {
      fatalError("\(error)")
    }
  }

  var body: some Scene {
    WindowGroup {
      HzbdGyvZrklContentView()
        .task {
          iotrvunbldfkhjsvb(context: container.mainContext)
        }
        .environmentObject(appState)
        .environmentObject(purchaseManager)
    }
    .modelContainer(container)
  }
}
