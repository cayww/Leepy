import Foundation
import SwiftData

@Model
final class LnawZngBfgAiXx {
  @Attribute(.unique) var id: UUID = UUID()
  var ldshCxuqBvkqUser: WsctDlnKessUser
  var sjpwEcwDodmGender: Int
  var ldzwJljVhfwAiXx: Int
  var cnrmEggNzwTime: Date
  init(
    ldshCxuqBvkqUser: WsctDlnKessUser, sjpwEcwDodmGender: Int, ldzwJljVhfwAiXx: Int,
    cnrmEggNzwTime: Date = .now
  ) {
    self.ldshCxuqBvkqUser = ldshCxuqBvkqUser
    self.sjpwEcwDodmGender = sjpwEcwDodmGender
    self.ldzwJljVhfwAiXx = ldzwJljVhfwAiXx
    self.cnrmEggNzwTime = cnrmEggNzwTime
  }
}
