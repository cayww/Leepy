import Foundation
import SwiftData
import SwiftUI

func bootstrapData(context: ModelContext) throws {

  let decoder = JSONDecoder()
  decoder.dateDecodingStrategy = .iso8601

  // MARK: - Users
  let usersURL = Bundle.main.url(forResource: "users", withExtension: "json")!
  let usersData = try Data(contentsOf: usersURL)
  let userDTOs = try decoder.decode([UserDTO].self, from: usersData)

  for dto in userDTOs {
    context.insert(dto.toModel())
  }

  // MARK: - Dynamics
  let dynamicsURL = Bundle.main.url(forResource: "dynamics", withExtension: "json")!
  let dynamicsData = try Data(contentsOf: dynamicsURL)

  let dynamicDTOs = try decoder.decode([DynamicDTO].self, from: dynamicsData)

  for dto in dynamicDTOs {
    context.insert(dto.toModel(modelContext: context))
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
