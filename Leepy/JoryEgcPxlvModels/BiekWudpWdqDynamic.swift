import Foundation
import SwiftData

@Model
final class DynamicModel {

  /// 帖子ID
  @Attribute(.unique)
  var dynamicId: String

  /// 发布人ID
  var userId: String

  /// 帖子类型（0=图片，1=视频）
  var dynamicType: Int

  /// 帖子描述
  var dynamicDesc: String

  /// 图片帖子类型下标
  var dynamicTitleType: Int

  /// 图片地址列表
  var dynamicPic: [String]

  /// 视频地址
  var dynamicVideo: String

  /// 点赞数
  var dynamicLikeCount: Int

  /// 评论数
  var dynamicCommentCount: Int

  init(
    dynamicId: String,
    userId: String,
    dynamicType: Int,
    dynamicDesc: String,
    dynamicTitleType: Int,
    dynamicPic: [String],
    dynamicVideo: String,
    dynamicLikeCount: Int,
    dynamicCommentCount: Int
  ) {
    self.dynamicId = dynamicId
    self.userId = userId
    self.dynamicType = dynamicType
    self.dynamicDesc = dynamicDesc
    self.dynamicTitleType = dynamicTitleType
    self.dynamicPic = dynamicPic
    self.dynamicVideo = dynamicVideo
    self.dynamicLikeCount = dynamicLikeCount
    self.dynamicCommentCount = dynamicCommentCount
  }
}

// MARK: - JSON Support
extension DynamicModel {

  /// 转 Dictionary
  func toJson() -> [String: Any] {
    return [
      "dynamicId": dynamicId,
      "userId": userId,
      "dynamicType": dynamicType,
      "dynamicDesc": dynamicDesc,
      "dynamicTitleType": dynamicTitleType,
      "dynamicPic": dynamicPic,
      "dynamicVideo": dynamicVideo,
      "dynamicLikeCount": dynamicLikeCount,
      "dynamicCommentCount": dynamicCommentCount,
    ]
  }

  /// 转 JSON 字符串
  func toJsonString() -> String? {
    guard let data = try? JSONSerialization.data(withJSONObject: toJson()) else {
      return nil
    }
    return String(data: data, encoding: .utf8)
  }

  /// 从 JSON 创建对象
  static func fromJson(_ json: [String: Any]) -> DynamicModel? {
    guard
      let dynamicId = json["dynamicId"] as? String,
      let userId = json["userId"] as? String,
      let dynamicType = json["dynamicType"] as? Int,
      let dynamicDesc = json["dynamicDesc"] as? String,
      let dynamicTitleType = json["dynamicTitleType"] as? Int,
      let dynamicPic = json["dynamicPic"] as? [String],
      let dynamicVideo = json["dynamicVideo"] as? String,
      let dynamicLikeCount = json["dynamicLikeCount"] as? Int,
      let dynamicCommentCount = json["dynamicCommentCount"] as? Int
    else {
      return nil
    }

    return DynamicModel(
      dynamicId: dynamicId,
      userId: userId,
      dynamicType: dynamicType,
      dynamicDesc: dynamicDesc,
      dynamicTitleType: dynamicTitleType,
      dynamicPic: dynamicPic,
      dynamicVideo: dynamicVideo,
      dynamicLikeCount: dynamicLikeCount,
      dynamicCommentCount: dynamicCommentCount
    )
  }
}
struct DynamicDTO: Codable {

  /// 帖子ID
  let dynamicId: String

  /// 发布人ID
  let userId: String

  /// 帖子类型（0=图片，1=视频）
  let dynamicType: Int

  /// 帖子描述
  let dynamicDesc: String

  /// 图片帖子类型下标
  let dynamicTitleType: Int

  /// 图片地址
  let dynamicPic: [String]

  /// 视频地址
  let dynamicVideo: String

  /// 点赞数
  let dynamicLikeCount: Int

  /// 评论数
  let dynamicCommentCount: Int
}

extension DynamicDTO {

  func toModel() -> DynamicModel {
    DynamicModel(
      dynamicId: dynamicId,
      userId: userId,
      dynamicType: dynamicType,
      dynamicDesc: dynamicDesc,
      dynamicTitleType: dynamicTitleType,
      dynamicPic: dynamicPic,
      dynamicVideo: dynamicVideo,
      dynamicLikeCount: dynamicLikeCount,
      dynamicCommentCount: dynamicCommentCount
    )
  }

}
