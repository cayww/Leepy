import Combine
import Foundation
import StoreKit

struct CoinProduct: Hashable, Identifiable, Decodable {
  let id: String
  let price: Double
  let coin: Int
}

@MainActor
final class VvolHdqhEszePurchase: NSObject, ObservableObject {

  @Published var kfgskdbvhjfdrs: [SKProduct] = []
  @Published var fjvcxkbvjyhf: Set<String> = []

  let dijvfuocbjfgtrs: [CoinProduct] = [
    .init(id: "qathgzqkvpudnhyn", price: 0.99, coin: 400),
    .init(id: "duafsphdgogponwz", price: 1.99, coin: 800),
    .init(id: "kfjdslqwepzmxtya", price: 2.99, coin: 1200),
    .init(id: "avnpmwpxvquluvjh", price: 4.99, coin: 2450),
    .init(id: "amiheafsizsziwsg", price: 9.99, coin: 5150),
    .init(id: "illidzvnwnkqkezk", price: 19.99, coin: 10800),
    .init(id: "qplmznxvtyskwrah", price: 29.99, coin: 15000),
    .init(id: "kcsshxnugpymztvi", price: 49.99, coin: 29400),
    .init(id: "xmvqplratynskdwe", price: 69.99, coin: 36000),
    .init(id: "lgsezzfwkqfxynjc", price: 99.99, coin: 63700),
  ]

  private var mcvbvchjxkv7rues: ((Int) -> Void)?

  override init() {
    super.init()
    SKPaymentQueue.default().add(self)
  }

  private func mnvcdyisacvb(_ transaction: SKPaymentTransaction, coin: Int = 0) {
    SKPaymentQueue.default().finishTransaction(transaction)
    mcvbvchjxkv7rues?(coin)
    mcvbvchjxkv7rues = nil
  }

  func ojnjkstyvcresavtrjhy(_ product: SKProduct, completion: @escaping (Int) -> Void) {
    mcvbvchjxkv7rues = completion
    SKPaymentQueue.default().add(SKPayment(product: product))
  }
  func muiodslhvbcyis() {
    let ids = Set(dijvfuocbjfgtrs.map(\.id))
    let request = SKProductsRequest(productIdentifiers: ids)
    request.delegate = self
    request.start()
  }
}

extension VvolHdqhEszePurchase: SKPaymentTransactionObserver {
  private func bglcxkzmvbuiyfde(_ transaction: SKPaymentTransaction) {
    guard
      let config = dijvfuocbjfgtrs.first(where: {
        $0.id == transaction.payment.productIdentifier
      })
    else {
      mnvcdyisacvb(transaction)
      return
    }
    fjvcxkbvjyhf.insert(config.id)
    mnvcdyisacvb(transaction, coin: config.coin)
  }
  nonisolated func paymentQueue(
    _ queue: SKPaymentQueue,
    updatedTransactions transactions: [SKPaymentTransaction]
  ) {
    Task { @MainActor in
      for tx in transactions {
        switch tx.transactionState {
        case .purchased:
          bglcxkzmvbuiyfde(tx)
        case .failed, .restored:
          mnvcdyisacvb(tx)
        case .purchasing, .deferred:
          break
        @unknown default:
          break
        }
      }
    }
  }
}
extension VvolHdqhEszePurchase: SKProductsRequestDelegate {
  nonisolated func productsRequest(
    _ request: SKProductsRequest, didReceive response: SKProductsResponse
  ) {
    Task { @MainActor in
      self.kfgskdbvhjfdrs = response.products
    }
  }
}
