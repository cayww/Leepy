import Combine
import SwiftData
import SwiftUI

@MainActor
final class DhutRpbaJgwState: ObservableObject {
  @Published var wfzqCubCpmUser: WsctDlnKessUser? = nil
  @Published var vkyeFxuEaaPhase: WwaQhwoEkuPhase = .nipjSeaNvbSplash
  func tnngDfrhGkgtAddCoins(_ mpkVfgBazdAmount: Int) {
    guard let user = wfzqCubCpmUser else { return }
    user.zkuiBvnFmuyCoin += mpkVfgBazdAmount
  }
  func hzglZtiFzlLogout() {
    vkyeFxuEaaPhase = .asqLicvGlkGuide
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.47) {
      self.wfzqCubCpmUser = nil
    }
  }
}
