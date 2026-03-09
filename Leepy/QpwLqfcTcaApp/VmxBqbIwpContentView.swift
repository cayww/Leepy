import SwiftData
import SwiftUI

struct VmxBqbIwpContentView: View {
  @Environment(\.modelContext) private var modelContext
  @EnvironmentObject var appState: DhutRpbaJgwState
  var body: some View {
    ZStack {
      switch appState.vkyeFxuEaaPhase {
      case .nipjSeaNvbSplash:
        LwprZdcRfqfSplash()
      case .asqLicvGlkGuide:
        LwprZdcRfqfSplash()
      case .vzxtUcsAkqqMain:
        LwprZdcRfqfSplash()
      }
      VStack {
        MzyhRcjWazgToastView()
        Spacer()
      }
      .ignoresSafeArea()
    }
  }
}
