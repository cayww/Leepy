import Foundation
import SwiftData

@Model
final class FniPjwAurrChatRoom {

  @Attribute(.unique)
  var id: String

  var fzguPzsZgrsFirstUser: WsctDlnKessUser

  var ajqNvncQvmSecondUser: WsctDlnKessUser

  var emfPflhEweLastMessage: String?

  var valzVjbJuuLastMessageAt: Date

  init(
    id: String,
    fzguPzsZgrsFirstUser: WsctDlnKessUser,
    ajqNvncQvmSecondUser: WsctDlnKessUser,
    valzVjbJuuLastMessageAt: Date = .now
  ) {
    self.id = id
    self.fzguPzsZgrsFirstUser = fzguPzsZgrsFirstUser
    self.ajqNvncQvmSecondUser = ajqNvncQvmSecondUser
    self.valzVjbJuuLastMessageAt = valzVjbJuuLastMessageAt
  }

  static func makeRoomId(userA: UUID, userB: UUID) -> String {
    [userA.uuidString, userB.uuidString].sorted().joined(separator: "_")
  }
}
