import Foundation
import SwiftData

@Model
final class MessageModel {

  /// 发送中状态
  var loading: Bool?

  /// 消息ID
  @Attribute(.unique)
  var msgId: String

  /// 会话ID
  var chatId: String

  /// 发送人ID
  var userId: String

  /// 用户名
  var name: String?

  /// 头像
  var avator: String?

  /// 消息位置（left/right）
  var position: String?

  /// 文本内容
  var sendContent: String

  /// 图片URL
  var sendPicUrl: String

  /// 发送时间
  var sendTime: String?

  init(
    loading: Bool? = nil,
    msgId: String,
    chatId: String,
    userId: String,
    name: String? = nil,
    avator: String? = nil,
    position: String? = nil,
    sendContent: String,
    sendPicUrl: String,
    sendTime: String? = nil
  ) {
    self.loading = loading
    self.msgId = msgId
    self.chatId = chatId
    self.userId = userId
    self.name = name
    self.avator = avator
    self.position = position
    self.sendContent = sendContent
    self.sendPicUrl = sendPicUrl
    self.sendTime = sendTime
  }
}

// MARK: - JSON Support
extension MessageModel {

  /// 转 Dictionary
  func toJson() -> [String: Any] {
    return [
      "loading": loading as Any,
      "msgId": msgId,
      "chatId": chatId,
      "userId": userId,
      "name": name as Any,
      "avator": avator as Any,
      "position": position as Any,
      "sendContent": sendContent,
      "sendPicUrl": sendPicUrl,
      "sendTime": sendTime as Any,
    ]
  }

  /// 转 JSON String
  func toJsonString() -> String? {
    guard let data = try? JSONSerialization.data(withJSONObject: toJson()) else {
      return nil
    }
    return String(data: data, encoding: .utf8)
  }

  /// 从 JSON 创建对象
  static func fromJson(_ json: [String: Any]) -> MessageModel? {
    guard
      let msgId = json["msgId"] as? String,
      let chatId = json["chatId"] as? String,
      let userId = json["userId"] as? String,
      let sendContent = json["sendContent"] as? String,
      let sendPicUrl = json["sendPicUrl"] as? String
    else {
      return nil
    }

    return MessageModel(
      loading: json["loading"] as? Bool,
      msgId: msgId,
      chatId: chatId,
      userId: userId,
      name: json["name"] as? String,
      avator: json["avator"] as? String,
      position: json["position"] as? String,
      sendContent: sendContent,
      sendPicUrl: sendPicUrl,
      sendTime: json["sendTime"] as? String
    )
  }
}
