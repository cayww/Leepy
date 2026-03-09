import SwiftData
import SwiftUI

@Model
class ZgdsWuxoNzkyFollow {
  @Attribute(.unique) var id: UUID = UUID()
  var aftyEnqFsbrFromUser: WsctDlnKessUser
  var uqlEhcjOukjToUser: WsctDlnKessUser
  var kfwObgXaceCreatedAt: Date

  init(
    aftyEnqFsbrFromUser: WsctDlnKessUser, uqlEhcjOukjToUser: WsctDlnKessUser,
    kfwObgXaceCreatedAt: Date = .now
  ) {
    self.aftyEnqFsbrFromUser = aftyEnqFsbrFromUser
    self.uqlEhcjOukjToUser = uqlEhcjOukjToUser
    self.kfwObgXaceCreatedAt = kfwObgXaceCreatedAt
  }
}
