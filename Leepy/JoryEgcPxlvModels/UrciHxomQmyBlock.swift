import SwiftData
import SwiftUI

@Model
class UrciHxomQmyBlock {
  @Attribute(.unique) var id: UUID = UUID()
  @Relationship var ifaqVeseKypFromUser: WsctDlnKessUser
  var nvlYfwrGfjnToUser: WsctDlnKessUser

  init(ifaqVeseKypFromUser: WsctDlnKessUser, nvlYfwrGfjnToUser: WsctDlnKessUser) {
    self.ifaqVeseKypFromUser = ifaqVeseKypFromUser
    self.nvlYfwrGfjnToUser = nvlYfwrGfjnToUser
  }
}
