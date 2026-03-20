import Combine
import SwiftData
import SwiftUI

@MainActor
final class RlbHdbTvacState: ObservableObject {
  @Published var wfzqCubCpmUser: UserModel? = nil
  @Published var vkyeFxuEaaPhase: BdfuivDvufhtdsPhase = .kjfdkvbfdvcSplash
  func tnngDfrhGkgtAddCoins(_ mpkVfgBazdAmount: Int) {
    guard let user = wfzqCubCpmUser else { return }
    user.coins += mpkVfgBazdAmount
  }
  func hzglZtiFzlLogout() {
    vkyeFxuEaaPhase = .kfdvnhfrtdsGuide
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.47) {
      self.wfzqCubCpmUser = nil
    }
  }
}
