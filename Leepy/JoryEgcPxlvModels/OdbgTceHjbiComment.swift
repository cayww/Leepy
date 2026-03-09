import Foundation
import SwiftData

@Model
final class CommentModel {

  /// 评论ID
  @Attribute(.unique)
  var commentId: String

  /// 所属帖子ID
  var dynamicId: String

  /// 评论用户ID
  var userId: String

  /// 评论内容
  var content: String

  init(
    dynamicId: String,
    commentId: String,
    userId: String,
    content: String
  ) {
    self.dynamicId = dynamicId
    self.commentId = commentId
    self.userId = userId
    self.content = content
  }
}

// MARK: - JSON Support
extension CommentModel {

  /// 转 Dictionary
  func toJson() -> [String: Any] {
    return [
      "dynamicId": dynamicId,
      "commentId": commentId,
      "userId": userId,
      "content": content,
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
  static func fromJson(_ json: [String: Any]) -> CommentModel? {
    guard
      let dynamicId = json["dynamicId"] as? String,
      let commentId = json["commentId"] as? String,
      let userId = json["userId"] as? String,
      let content = json["content"] as? String
    else {
      return nil
    }

    return CommentModel(
      dynamicId: dynamicId,
      commentId: commentId,
      userId: userId,
      content: content
    )
  }
}
