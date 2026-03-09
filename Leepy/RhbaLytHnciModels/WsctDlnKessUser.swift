import Foundation
import SwiftData
import SwiftUI

@Model
class WsctDlnKessUser {
  @Attribute(.unique) var id: UUID = UUID()
  var sabIkrcRkhpName: String
  var nzbgLccjPmazEmail: String
  var zkuiBvnFmuyCoin: Int
  var rsccVbjuQzoPhoto: String
  var dfguDfuhAdsGender: Int
  var enuGvpcQwufXx: Int
  var sfuAfdvYsdBackground: Int
  @Relationship(deleteRule: .cascade)
  var blocklists: [UrciHxomQmyBlock] = []
  @Relationship(deleteRule: .cascade, inverse: \WsctDlnKessUser.id)
  var followings: [UUID] = []
  @Relationship(deleteRule: .cascade, inverse: \WsctDlnKessUser.id)
  var followers: [UUID] = []
  init(
    sabIkrcRkhpName: String,
    nzbgLccjPmazEmail: String,
    zkuiBvnFmuyCoin: Int = 0,
    rsccVbjuQzoPhoto: String = "heico_default_photo.png",
    dfguDfuhAdsGender: Int = 0,
    enuGvpcQwufXx: Int = 0,
    sfuAfdvYsdBackground: Int = 0
  ) {
    self.sabIkrcRkhpName = sabIkrcRkhpName
    self.nzbgLccjPmazEmail = nzbgLccjPmazEmail
    self.zkuiBvnFmuyCoin = zkuiBvnFmuyCoin
    self.rsccVbjuQzoPhoto = rsccVbjuQzoPhoto
    self.dfguDfuhAdsGender = dfguDfuhAdsGender
    self.enuGvpcQwufXx = enuGvpcQwufXx
    self.sfuAfdvYsdBackground = sfuAfdvYsdBackground
  }

  var photoURL: URL? {
    let fileManager = FileManager.default

    if fileManager.fileExists(atPath: rsccVbjuQzoPhoto) {
      return URL(fileURLWithPath: rsccVbjuQzoPhoto)
    }

    if let resourcePath = Bundle.main.resourcePath {
      let resourceURL = URL(fileURLWithPath: resourcePath)
      let potentialURL = resourceURL.appendingPathComponent(rsccVbjuQzoPhoto)
      if fileManager.fileExists(atPath: potentialURL.path) {
        return potentialURL
      }
    }

    let name = (rsccVbjuQzoPhoto as NSString).deletingPathExtension
    let ext = (rsccVbjuQzoPhoto as NSString).pathExtension
    if let url = Bundle.main.url(forResource: name, withExtension: ext) {
      return url
    }

    return nil
  }

  var photoImage: Image {
    if let url = photoURL,
      let uiImage = UIImage(contentsOfFile: url.path)
    {
      return Image(uiImage: uiImage)
    } else {
      return Image(systemName: "person.fill")
    }
  }
}

struct UserDTO: Decodable {
  let id: Int
  let name: String
  let email: String
  let coin: Int
  let photo: String
  let gender: Int
  let xx: Int
  let background: Int
}
