import SwiftData
import SwiftUI

struct HzbdGyvZrklContentView: View {
  @Environment(\.modelContext) private var modelContext
  @EnvironmentObject var appState: RlbHdbTvacState
  var body: some View {
    ZStack {
      switch appState.vkyeFxuEaaPhase {
      case .nipjSeaNvbSplash:
        LwprZdcRfqfSplash()
      case .asqLicvGlkGuide:
        YwxKvvRbdkGuide()
      case .vzxtUcsAkqqMain:
        GsdtAobDlaMain()
      }
      VStack {
        MzyhRcjWazgToastView()
        Spacer()
      }
      .ignoresSafeArea()
    }
  }
}
