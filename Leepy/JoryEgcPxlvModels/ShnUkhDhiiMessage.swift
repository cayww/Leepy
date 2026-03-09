import SwiftData
import SwiftUI

@Model
final class ShnUkhDhiiMessage {
  @Attribute(.unique) var id: UUID = UUID()
  var content: String?
  var image: String?
  var audio: String?
  var duration: Int
  var room: FniPjwAurrChatRoom
  var bgtrbijbdgMessageAt: Date
  init(
    content: String? = nil,
    image: String? = nil,
    audio: String? = nil,
    duration: Int = 0,
    room: FniPjwAurrChatRoom,
    bgtrbijbdgMessageAt: Date = .now
  ) {
    self.content = content
    self.image = image
    self.audio = audio
    self.duration = duration
    self.room = room
    self.bgtrbijbdgMessageAt = bgtrbijbdgMessageAt
  }
  var imageURL: URL? {
    guard let image else { return nil }

    let fileManager = FileManager.default
    if fileManager.fileExists(atPath: image) {
      return URL(fileURLWithPath: image)
    }

    return nil
  }

  var imageView: Image {
    guard
      let url = imageURL,
      let uiImage = UIImage(contentsOfFile: url.path)
    else {
      return Image(systemName: "photo")
    }

    return Image(uiImage: uiImage)
  }
  var audioURL: URL? {
    guard let audio else { return nil }

    let fileManager = FileManager.default
    if fileManager.fileExists(atPath: audio) {
      return URL(fileURLWithPath: audio)
    }

    return nil
  }
}
