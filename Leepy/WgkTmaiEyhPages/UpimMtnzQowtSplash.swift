import SwiftUI

struct LwprZdcRfqfSplash: View {
  @EnvironmentObject var appState: RlbHdbTvacState
  @EnvironmentObject var purchaseManager: VvolHdqhEszePurchase
  var body: some View {
    GeometryReader { _ in
      Image("Assets/leepy_splash_bg").resizable().scaledToFill().ignoresSafeArea()
      VStack {
        Spacer().frame(height: 275.h)
        Image("LeepyLogo").resizable().scaledToFit().frame(width: 92.r, height: 92.r)
          .cornerRadius(20.r)
        Spacer().frame(height: 11.h)
        Text("Leepy").foregroundColor(.black).font(.system(size: 36.sp))
        Spacer()
      }
      .ignoresSafeArea()
      .frame(maxWidth: .infinity)
    }
    .task {
      purchaseManager.muiodslhvbcyis()
      try? await Task.sleep(for: .seconds(1))
      appState.vkyeFxuEaaPhase = .kfdvnhfrtdsGuide
    }
  }
}
