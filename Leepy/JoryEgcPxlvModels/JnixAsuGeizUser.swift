import Foundation
import SwiftData

@Model
final class UserModel {

  @Attribute(.unique)
  var userId: String

  var email: String
  var password: String
  var avatar: String
  var name: String
  var about: String
  var coins: Int

  var follow: [String]
  var fans: [String]
  var blockList: [String]
  var picPostLikeIds: [String]
  var videoPostLikeIds: [String]

  init(
    userId: String,
    email: String,
    password: String,
    avatar: String,
    name: String,
    about: String,
    coins: Int,
    follow: [String] = [],
    fans: [String] = [],
    blockList: [String] = [],
    picPostLikeIds: [String] = [],
    videoPostLikeIds: [String] = []
  ) {
    self.userId = userId
    self.email = email
    self.password = password
    self.avatar = avatar
    self.name = name
    self.about = about
    self.coins = coins
    self.follow = follow
    self.fans = fans
    self.blockList = blockList
    self.picPostLikeIds = picPostLikeIds
    self.videoPostLikeIds = videoPostLikeIds
  }
}

// MARK: - JSON
extension UserModel {

  func toJson() -> [String: Any] {
    return [
      "userId": userId,
      "email": email,
      "password": password,
      "avatar": avatar,
      "name": name,
      "about": about,
      "coins": coins,
      "follow": follow,
      "fans": fans,
      "blockList": blockList,
      "picPostLikeIds": picPostLikeIds,
      "videoPostLikeIds": videoPostLikeIds,
    ]
  }

  func toJsonString() -> String? {
    guard let data = try? JSONSerialization.data(withJSONObject: toJson()) else {
      return nil
    }
    return String(data: data, encoding: .utf8)
  }

  static func fromJson(_ json: [String: Any]) -> UserModel? {
    guard
      let userId = json["userId"] as? String,
      let email = json["email"] as? String,
      let password = json["password"] as? String,
      let avatar = json["avatar"] as? String,
      let name = json["name"] as? String,
      let about = json["about"] as? String,
      let coins = json["coins"] as? Int
    else { return nil }

    return UserModel(
      userId: userId,
      email: email,
      password: password,
      avatar: avatar,
      name: name,
      about: about,
      coins: coins,
      follow: json["follow"] as? [String] ?? [],
      fans: json["fans"] as? [String] ?? [],
      blockList: json["blockList"] as? [String] ?? [],
      picPostLikeIds: json["picPostLikeIds"] as? [String] ?? [],
      videoPostLikeIds: json["videoPostLikeIds"] as? [String] ?? []
    )
  }
}

// MARK: - Copy
extension UserModel {

  func copyWith(
    email: String? = nil,
    password: String? = nil,
    avatar: String? = nil,
    name: String? = nil,
    about: String? = nil,
    coins: Int? = nil,
    follow: [String]? = nil,
    fans: [String]? = nil,
    blockList: [String]? = nil,
    picPostLikeIds: [String]? = nil,
    videoPostLikeIds: [String]? = nil
  ) -> UserModel {

    return UserModel(
      userId: userId,
      email: email ?? self.email,
      password: password ?? self.password,
      avatar: avatar ?? self.avatar,
      name: name ?? self.name,
      about: about ?? self.about,
      coins: coins ?? self.coins,
      follow: follow ?? self.follow,
      fans: fans ?? self.fans,
      blockList: blockList ?? self.blockList,
      picPostLikeIds: picPostLikeIds ?? self.picPostLikeIds,
      videoPostLikeIds: videoPostLikeIds ?? self.videoPostLikeIds
    )
  }
}

extension UserModel {

  func updateUser(
    context: ModelContext,
    email: String? = nil,
    password: String? = nil,
    avatar: String? = nil,
    name: String? = nil,
    about: String? = nil,
    coins: Int? = nil,
    follow: [String]? = nil,
    fans: [String]? = nil,
    blockList: [String]? = nil,
    picPostLikeIds: [String]? = nil,
    videoPostLikeIds: [String]? = nil
  ) throws {

    self.email = email ?? self.email
    self.password = password ?? self.password
    self.avatar = avatar ?? self.avatar
    self.name = name ?? self.name
    self.about = about ?? self.about
    self.coins = coins ?? self.coins
    self.follow = follow ?? self.follow
    self.fans = fans ?? self.fans
    self.blockList = blockList ?? self.blockList
    self.picPostLikeIds = picPostLikeIds ?? self.picPostLikeIds
    self.videoPostLikeIds = videoPostLikeIds ?? self.videoPostLikeIds

    try context.save()
  }
}

struct UserDTO: Codable {

  let userId: String
  let email: String
  let password: String
  let avatar: String
  let name: String
  let about: String
  let coins: Int

  let follow: [String]
  let fans: [String]
  let blockList: [String]
  let picPostLikeIds: [String]
  let videoPostLikeIds: [String]
}

extension UserDTO {

  func toModel() -> UserModel {
    return UserModel(
      userId: userId,
      email: email,
      password: password,
      avatar: avatar,
      name: name,
      about: about,
      coins: coins,
      follow: follow,
      fans: fans,
      blockList: blockList,
      picPostLikeIds: picPostLikeIds,
      videoPostLikeIds: videoPostLikeIds
    )
  }

}
