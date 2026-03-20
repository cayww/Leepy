import SwiftData
import SwiftUI

struct HzbdGyvZrklContentView: View {
  @Environment(\.modelContext) private var modelContext
  @EnvironmentObject var appState: RlbHdbTvacState
  var body: some View {
    ZStack {
      switch appState.vkyeFxuEaaPhase {
      case .kjfdkvbfdvcSplash:
        LwprZdcRfqfSplash()
      case .kfdvnhfrtdsGuide:
        YwxKvvRbdkGuide()
      case .dfsizvhbfdsvrMain:
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
