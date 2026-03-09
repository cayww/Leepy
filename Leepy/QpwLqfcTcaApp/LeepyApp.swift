@_exported import HotSwiftUI
import SwiftData
import SwiftUI

@main
struct LeepyApp: App {
  let container: ModelContainer
  @StateObject private var appState = DhutRpbaJgwState()
  @StateObject private var purchaseManager = DpcyDvfCnfmPurchaseManager()
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
            FniPjwAurrChatRoom.self,
          ShnUkhDhiiMessage.self,
          UrciHxomQmyBlock.self,
          WsctDlnKessUser.self,
          ZgdsWuxoNzkyFollow.self,
          DxvBryIogcComment.self,
          LnawZngBfgAiXx.self,
        )
    } catch {
      fatalError("\(error)")
    }
  }

  var body: some Scene {
    WindowGroup {
      VmxBqbIwpContentView()
        .task {
          // bootstrapIfNeeded(context: container.mainContext)
        }
        .environmentObject(appState)
        .environmentObject(purchaseManager)
    }
    .modelContainer(container)
  }
}
