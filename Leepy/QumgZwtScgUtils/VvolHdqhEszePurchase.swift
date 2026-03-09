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

  @Published var products: [SKProduct] = []
  @Published var purchasedIds: Set<String> = []

  let configs: [CoinProduct] = [
    .init(id: "lvbsvhxcgcrvesor", price: 0.99, coin: 400),
    .init(id: "dxismgcwewhrtezo", price: 4.99, coin: 2450),
    .init(id: "khtxlcejaxmqcsra", price: 9.99, coin: 4900),
    .init(id: "yadwwvxspgxwlndb", price: 19.99, coin: 9800),
    .init(id: "qnrcuelbtiuflyky", price: 49.99, coin: 24500),
    .init(id: "ymohxnvpkqxutvab", price: 99.99, coin: 49000),
  ]

  private var purchaseCompletion: ((Int) -> Void)?

  override init() {
    super.init()
    SKPaymentQueue.default().add(self)
  }

  func fetchProducts() {
    let ids = Set(configs.map(\.id))
    let request = SKProductsRequest(productIdentifiers: ids)
    request.delegate = self
    request.start()
  }

  func purchase(_ product: SKProduct, completion: @escaping (Int) -> Void) {
    purchaseCompletion = completion
    SKPaymentQueue.default().add(SKPayment(product: product))
  }

  private func finish(_ transaction: SKPaymentTransaction, coin: Int = 0) {
    SKPaymentQueue.default().finishTransaction(transaction)
    purchaseCompletion?(coin)
    purchaseCompletion = nil
  }
}

extension VvolHdqhEszePurchase: SKProductsRequestDelegate {
  func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
    products = response.products
  }
}

extension VvolHdqhEszePurchase: SKPaymentTransactionObserver {
  func paymentQueue(
    _ queue: SKPaymentQueue,
    updatedTransactions transactions: [SKPaymentTransaction]
  ) {
    for tx in transactions {
      switch tx.transactionState {
      case .purchased:
        handlePurchased(tx)
      case .failed, .restored:
        finish(tx)
      case .purchasing, .deferred:
        break
      @unknown default:
        break
      }
    }
  }

  private func handlePurchased(_ transaction: SKPaymentTransaction) {
    guard
      let config = configs.first(where: {
        $0.id == transaction.payment.productIdentifier
      })
    else {
      finish(transaction)
      return
    }
    purchasedIds.insert(config.id)
    finish(transaction, coin: config.coin)
  }
}
