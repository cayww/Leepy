import Combine
import SwiftData
import SwiftUI

@MainActor
final class RlbHdbTvacState: ObservableObject {
  @Published var wfzqCubCpmUser: UserModel? = nil
  @Published var vkyeFxuEaaPhase: WwaQhwoEkuPhase = .nipjSeaNvbSplash
  func tnngDfrhGkgtAddCoins(_ mpkVfgBazdAmount: Int) {
    guard let user = wfzqCubCpmUser else { return }
    user.coins += mpkVfgBazdAmount
  }
  func hzglZtiFzlLogout() {
    vkyeFxuEaaPhase = .asqLicvGlkGuide
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.47) {
      self.wfzqCubCpmUser = nil
    }
  }
}
