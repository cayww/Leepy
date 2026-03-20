import Foundation
import SwiftData
import SwiftUI

func grtesvfdiusvbnrtew(context: ModelContext) throws {

  let kfdhjzvbfhdkzv = JSONDecoder()
  kfdhjzvbfhdkzv.dateDecodingStrategy = .iso8601

  // MARK: - Users
  let kryuedabvdfb = Bundle.main.url(forResource: "users", withExtension: "json")!
  let kdvmxvkhjgbfs = try Data(contentsOf: kryuedabvdfb)
  let iknufkydgbvfd = try kfdhjzvbfhdkzv.decode([UserDTO].self, from: kdvmxvkhjgbfs)

  for dto in iknufkydgbvfd {
    context.insert(dto.toModel())
  }

  // MARK: - Dynamics
  let oopresnvhjdfgvc = Bundle.main.url(forResource: "dynamics", withExtension: "json")!
  let rtevouhvrefv = try Data(contentsOf: oopresnvhjdfgvc)

  let oreukbndkshyv = try kfdhjzvbfhdkzv.decode([DynamicDTO].self, from: rtevouhvrefv)

  for dto in oreukbndkshyv {
    context.insert(dto.toModel(modelContext: context))
  }

  try context.save()
}

func iotrvunbldfkhjsvb(context: ModelContext) {
  let key = "iroexvniysufhdbv"
  guard !UserDefaults.standard.bool(forKey: key) else { return }

  do {
    try grtesvfdiusvbnrtew(context: context)
    UserDefaults.standard.set(true, forKey: key)
  } catch {
    print("Bootstrap failed: \(error)")
  }
}
