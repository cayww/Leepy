import SwiftData
import SwiftUI

func bootstrapData(context: ModelContext) throws {

  let decoder = JSONDecoder()
  decoder.dateDecodingStrategy = .iso8601

  let usersURL = Bundle.main.url(forResource: "users", withExtension: "json")!
  let usersData = try Data(contentsOf: usersURL)
  let userDTOs = try decoder.decode([UserDTO].self, from: usersData)

  var userMap: [Int: WsctDlnKessUser] = [:]
  for dto in userDTOs {
    let user = WsctDlnKessUser(
      sabIkrcRkhpName: dto.name,
      nzbgLccjPmazEmail: dto.email,
      zkuiBvnFmuyCoin: dto.coin,
      rsccVbjuQzoPhoto: dto.photo,
      dfguDfuhAdsGender: dto.gender,
      enuGvpcQwufXx: dto.xx,
      sfuAfdvYsdBackground: dto.background
    )
    context.insert(user)
    userMap[dto.id] = user
  }

  let comments: [DxvBryIogcComment] = [
    DxvBryIogcComment(
      huzNntrQhiUser: userMap[1]!, gybSxoMhjContent: "Hi there! Nice to meet you 😊"),
    DxvBryIogcComment(
      huzNntrQhiUser: userMap[2]!, gybSxoMhjContent: "Hello! Hope you're having a great day!"),
    DxvBryIogcComment(
      huzNntrQhiUser: userMap[3]!, gybSxoMhjContent: "Hey! How's everything going?"),
    DxvBryIogcComment(
      huzNntrQhiUser: userMap[5]!, gybSxoMhjContent: "Hi! Glad to connect with you."),
    DxvBryIogcComment(
      huzNntrQhiUser: userMap[6]!, gybSxoMhjContent: "Hello! Wishing you a wonderful day!"),
  ]

  for comment in comments {
    context.insert(comment)
  }

  try context.save()
}

func bootstrapIfNeeded(context: ModelContext) {
  let key = "didBootstrapPostData"
  guard !UserDefaults.standard.bool(forKey: key) else { return }

  do {
    try bootstrapData(context: context)
    UserDefaults.standard.set(true, forKey: key)
  } catch {
    print("Bootstrap failed: \(error)")
  }
}

extension Date {
  func toYMDString() -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: self)
  }
  func to12HourString() -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "h:mm a"
    formatter.amSymbol = "am"
    formatter.pmSymbol = "pm"
    return formatter.string(from: self)
  }
}
