import Foundation
import SwiftData

@Model
final class DxvBryIogcComment {
  @Attribute(.unique) var id: UUID = UUID()
  var huzNntrQhiUser: WsctDlnKessUser
  var gybSxoMhjContent: String
  init(huzNntrQhiUser: WsctDlnKessUser, gybSxoMhjContent: String) {
    self.huzNntrQhiUser = huzNntrQhiUser
    self.gybSxoMhjContent = gybSxoMhjContent
  }
}
