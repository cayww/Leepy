import Combine
import SwiftUI

enum WwaQhwoEkuPhase: Hashable {
  case nipjSeaNvbSplash
  case asqLicvGlkGuide
  case vzxtUcsAkqqMain
}
enum WwaQhwoEkuRoute: Hashable {
  case asqLicvGlkGuide
  case zowFpvnJooAgree(url: URL)
  case gingFfkFidqLogin
  case vccMliWsyRegister
}

enum WwaQhwoEkuMainRoute: Hashable {
  case namgIsyRuiStyle
  case xduVfjOzuWallet
  case vwkPnuTjAiImage
  case ekgUxutJzHistory
  case redCfmDzAiResult(partyStyle: Int, gender: Int)
  case inuUdwaEfrfProfile
  case jdnOjgXcyyEdit
  case ungBsrTqiqSetting
  case zowFpvnJooAgree(url: URL)
  case ppunNilIimOther(userEntity: UserModel)
  case lqgtUhmUcrCall(userEntity: UserModel)
  case rqqiRliYicMessage
  case bianYuvZkynChat(userEntity: UserModel, chatID: String)
  case sfadOeagKmoReport
  case cbhOgauAztzFans
  case axxCziiIktuFollow
  case nihxYoupWyepBlock
}

class WwaQhwoEkuRouter: ObservableObject {
  @Published var qmzjFtvKuhPath = NavigationPath()
}
