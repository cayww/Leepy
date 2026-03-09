@_exported import HotSwiftUI
import SwiftData
import SwiftUI

@main
struct LeepyApp: App {
  let container: ModelContainer
  @StateObject private var appState = RlbHdbTvacState()
  @StateObject private var purchaseManager = VvolHdqhEszePurchase()
  init() {
    #if DEBUG
      Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
      if let path = Bundle.main.path(
        forResource:
          "iOSInjection", ofType: "bundle")
      {
        Bundle(path: path)!.load()
      }
    #endif
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
          bootstrapIfNeeded(context: container.mainContext)
        }
        .environmentObject(appState)
        .environmentObject(purchaseManager)
    }
    .modelContainer(container)
  }
}
