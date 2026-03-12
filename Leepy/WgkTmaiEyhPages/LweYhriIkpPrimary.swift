import StoreKit
import SwiftData
import SwiftUI
import WebKit

// MARK: - JS Handlers 名称
struct JsHandlers {
  static let jsConsole = "jsConsole"
  static let close = "close"
  static let updateUser = "updateUser"
  static let updatePost = "updatePost"
  static let updateComment = "updateComment"
  static let uploadChat = "uploadChat"
  static let uploadMessage = "uploadMessage"
  static let logout = "logout"
  static let deleteAccount = "deleteaccount"
  static let recharge = "Recharge"
}

// MARK: - WebView 内容
struct LweYhriIkpPrimaryContent: UIViewRepresentable {
  let appState: RlbHdbTvacState
  let trvudfhvSsxcUrl: URL
  let modelContext: ModelContext
  let router: SvcdXfvTsxRouter
  let purchaseManager: VvolHdqhEszePurchase
  func makeUIView(context: Context) -> WKWebView {
    // ⚙️ 网页首选项
    let preferences = WKWebpagePreferences()
    preferences.allowsContentJavaScript = true

    let configuration: WKWebViewConfiguration = WKWebViewConfiguration()
    configuration.defaultWebpagePreferences = preferences

    // JS handler
    let userController = WKUserContentController()

    let handlers = [
      JsHandlers.close,
      JsHandlers.updateUser,
      JsHandlers.updatePost,
      JsHandlers.updateComment,
      JsHandlers.uploadChat,
      JsHandlers.uploadMessage,
      JsHandlers.logout,
      JsHandlers.deleteAccount,
      JsHandlers.recharge,
    ]
    for name in handlers {
      userController.add(context.coordinator, name: name)
    }
    let consoleScript = """
      (function() {
          const oldLog = console.log;
          console.log = function(...args) {
              window.webkit.messageHandlers.jsConsole.postMessage({type: 'log', message: args});
              oldLog.apply(console, args);
          };
          const oldError = console.error;
          console.error = function(...args) {
              window.webkit.messageHandlers.jsConsole.postMessage({type: 'error', message: args});
              oldError.apply(console, args);
          };
      })();
      """
    let userConsoleScript = WKUserScript(
      source: consoleScript,
      injectionTime: .atDocumentStart,
      forMainFrameOnly: true
    )
    userController.addUserScript(userConsoleScript)
    userController.add(context.coordinator, name: "jsConsole")
    // ⚡️ 注入初始数据
    let initialScript = generateUserScript()
    let userScript = WKUserScript(
      source: initialScript,
      injectionTime: .atDocumentStart,
      forMainFrameOnly: false
    )
    userController.addUserScript(userScript)

    configuration.userContentController = userController

    let webView = WKWebView(frame: .zero, configuration: configuration)

    // UI 设置
    webView.isOpaque = false
    webView.backgroundColor = .clear
    webView.scrollView.backgroundColor = .clear
    webView.scrollView.showsVerticalScrollIndicator = false
    webView.scrollView.showsHorizontalScrollIndicator = false
    webView.scrollView.bounces = false
    webView.scrollView.pinchGestureRecognizer?.isEnabled = false
    context.coordinator.webView = webView
    webView.navigationDelegate = context.coordinator
    webView.uiDelegate = context.coordinator
    webView.load(URLRequest(url: trvudfhvSsxcUrl))
    return webView
  }

  func updateUIView(_ webView: WKWebView, context: Context) {
    if webView.url == nil {
      webView.load(URLRequest(url: trvudfhvSsxcUrl))
    }
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(
      modelContext: modelContext, router: router, appState: appState,
      purchaseManager: purchaseManager)
  }

  private func generateUserScript() -> String {
    func arrayJsonString<T>(_ array: [T]?, toJson: (T) -> String) -> String {
      guard let arr = array else { return "[]" }
      return "[" + arr.map(toJson).joined(separator: ",") + "]"
    }

    let users = try? modelContext.fetch(FetchDescriptor<UserModel>())
    let dynamics = try? modelContext.fetch(FetchDescriptor<DynamicModel>())
    let comments = try? modelContext.fetch(FetchDescriptor<CommentModel>())
    let chats = try? modelContext.fetch(FetchDescriptor<ChatModel>())
    let messages = try? modelContext.fetch(FetchDescriptor<MessageModel>())

    let usersJson = arrayJsonString(users) { $0.toJsonString() ?? "{}" }
    let dynamicsJson = arrayJsonString(dynamics) { $0.toJsonString() ?? "{}" }
    let commentsJson = arrayJsonString(comments) { $0.toJsonString() ?? "{}" }
    let chatsJson = arrayJsonString(chats) { $0.toJsonString() ?? "{}" }
    let messagesJson = arrayJsonString(messages) { $0.toJsonString() ?? "{}" }
    return """
      window.userJson = \(appState.wfzqCubCpmUser?.toJsonString() ?? "{}");
      window.userListJson = \(usersJson);
      window.dynamicJson = \(dynamicsJson);
      window.commentJson = \(commentsJson);
      window.chatListJson = \(chatsJson);
      window.messageListJson = \(messagesJson);
      """
  }

  class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {
    let modelContext: ModelContext
    let router: SvcdXfvTsxRouter
    let appState: RlbHdbTvacState
    let purchaseManager: VvolHdqhEszePurchase
    weak var webView: WKWebView?
    init(
      modelContext: ModelContext, router: SvcdXfvTsxRouter, appState: RlbHdbTvacState,
      purchaseManager: VvolHdqhEszePurchase
    ) {
      self.modelContext = modelContext
      self.router = router
      self.appState = appState
      self.purchaseManager = purchaseManager
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      print("网页加载完成")
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
      print("网页加载失败：\(error.localizedDescription)")
    }

    func userContentController(
      _ userContentController: WKUserContentController, didReceive message: WKScriptMessage
    ) {
      print("JS CALL -> \(message.name)")
      switch message.name {
      case JsHandlers.jsConsole:
        if let body = message.body as? [String: Any],
          let type = body["type"] as? String,
          let msg = body["message"]
        {
          switch type {
          case "log":
            print("[JS LOG] \(msg)")
          case "error":
            print("[JS ERROR] \(msg)")
          default:
            break
          }
        }
      case JsHandlers.close:
        router.leepyPath.removeLast()
      case JsHandlers.updateUser:
        guard let rawList = message.body as? [[String: Any]] else { return }
        for json in rawList {
          guard let newUser = UserModel.fromJson(json) else { continue }
          let userId = newUser.userId
          let descriptor = FetchDescriptor<UserModel>(
            predicate: #Predicate { $0.userId == userId }
          )
          if let existing = try? modelContext.fetch(descriptor).first {
            existing.email = newUser.email
            existing.password = newUser.password
            existing.avatar = newUser.avatar
            existing.name = newUser.name
            existing.about = newUser.about
            existing.coins = newUser.coins
            existing.follow = newUser.follow
            existing.fans = newUser.fans
            existing.blockList = newUser.blockList
            existing.picPostLikeIds = newUser.picPostLikeIds
            existing.videoPostLikeIds = newUser.videoPostLikeIds
          } else {
            modelContext.insert(newUser)
          }
        }
        try? modelContext.save()
      case JsHandlers.updatePost:
        guard let rawList: [[String: Any]] = message.body as? [[String: Any]] else { return }
        for json in rawList {
          guard let newDynamic = DynamicModel.fromJson(json) else { continue }
          let dynamicId = newDynamic.dynamicId
          let descriptor = FetchDescriptor<DynamicModel>(
            predicate: #Predicate { $0.dynamicId == dynamicId }
          )
          if let existing: DynamicModel = try? modelContext.fetch(descriptor).first {
            existing.userId = newDynamic.userId
            existing.dynamicType = newDynamic.dynamicType
            existing.dynamicDesc = newDynamic.dynamicDesc
            existing.dynamicTitleType = newDynamic.dynamicTitleType
            existing.dynamicPic = newDynamic.dynamicPic
            existing.dynamicVideo = newDynamic.dynamicVideo
            existing.dynamicLikeCount = newDynamic.dynamicLikeCount
            existing.dynamicCommentCount = newDynamic.dynamicCommentCount
          } else {
            modelContext.insert(newDynamic)
          }
        }
        try? modelContext.save()
      case JsHandlers.updateComment:
        print(message.body)
        guard let rawList = message.body as? [[String: Any]] else { return }
        for json in rawList {
          guard let newComment = CommentModel.fromJson(json) else { continue }
          let commentId = newComment.commentId
          let descriptor = FetchDescriptor<CommentModel>(
            predicate: #Predicate { $0.commentId == commentId }
          )
          if let existing = try? modelContext.fetch(descriptor).first {
            existing.dynamicId = newComment.dynamicId
            existing.userId = newComment.userId
            existing.content = newComment.content
          } else {
            modelContext.insert(newComment)
          }
        }
        try? modelContext.save()
      case JsHandlers.uploadChat:

        guard let rawList = message.body as? [[String: Any]] else { return }

        for json in rawList {

          guard let newChat = ChatModel.fromJson(json) else { continue }
          let chatId = newChat.chatId
          let descriptor = FetchDescriptor<ChatModel>(
            predicate: #Predicate { $0.chatId == chatId }
          )

          if let existing = try? modelContext.fetch(descriptor).first {

            existing.chatUserIds = newChat.chatUserIds
            existing.lastSendContent = newChat.lastSendContent
            existing.lastSendTime = newChat.lastSendTime
            existing.unreadMsgCount = newChat.unreadMsgCount
            existing.lastSendUserId = newChat.lastSendUserId

          } else {
            modelContext.insert(newChat)
          }
        }

        try? modelContext.save()
      case JsHandlers.uploadMessage:

        guard let rawList = message.body as? [[String: Any]] else { return }

        for json in rawList {

          guard let newMessage = MessageModel.fromJson(json) else { continue }
          let msgId = newMessage.msgId
          let descriptor = FetchDescriptor<MessageModel>(
            predicate: #Predicate { $0.msgId == msgId }
          )

          if let existing = try? modelContext.fetch(descriptor).first {
            existing.loading = newMessage.loading
            existing.chatId = newMessage.chatId
            existing.userId = newMessage.userId
            existing.name = newMessage.name
            existing.avatar = newMessage.avatar
            existing.position = newMessage.position
            existing.sendContent = newMessage.sendContent
            existing.sendPicUrl = newMessage.sendPicUrl
            existing.sendTime = newMessage.sendTime

          } else {
            modelContext.insert(newMessage)
          }
        }

        try? modelContext.save()
      case JsHandlers.logout:
        appState.hzglZtiFzlLogout()
      case JsHandlers.deleteAccount:
        appState.hzglZtiFzlLogout()
      case JsHandlers.recharge:
        guard let key = message.body as? String else { return }
        guard
          let product = purchaseManager.products.first(where: {
            $0.productIdentifier == key
          })
        else {
          Toast.shared.showToast(
            "Product not found. Please check your network connection.")
          return
        }
        Toast.shared.showLoading()
        purchaseManager.purchase(product) { result in
          Toast.shared.hideLoading()
          if result > 0 {
            self.appState.tnngDfrhGkgtAddCoins(result)
            let js = "window.onRechargeSuccess && window.onRechargeSuccess(\(result))"
            DispatchQueue.main.async {
              self.webView?.evaluateJavaScript(js)
            }
            Toast.shared.showToast("Purchase success")
          } else {
            Toast.shared.showToast("Purchase failed")
          }
        }
      default:
        print("未知 JS 调用: \(message.name)")
      }
    }

    @available(iOS 15.0, *)
    func webView(
      _ webView: WKWebView,
      requestMediaCapturePermissionFor origin: WKSecurityOrigin,
      initiatedByFrame frame: WKFrameInfo,
      type: WKMediaCaptureType,
      decisionHandler: @escaping (WKPermissionDecision) -> Void
    ) {
      decisionHandler(.grant)
    }
  }
}

struct LweYhriIkpPrimary: View {
  @EnvironmentObject var purchaseManager: VvolHdqhEszePurchase
  let trvudfhvSsxcUrl: URL
  @Environment(\.modelContext) private var modelContext
  @EnvironmentObject var router: SvcdXfvTsxRouter
  @EnvironmentObject var appState: RlbHdbTvacState
  var body: some View {
    GeometryReader { geo in
      ZStack {
        Image("Assets/leepy_splash_bg")
          .resizable()
          .scaledToFill()
          .ignoresSafeArea()
        LweYhriIkpPrimaryContent(
          appState: appState,
          trvudfhvSsxcUrl: trvudfhvSsxcUrl,
          modelContext: modelContext,
          router: router,
          purchaseManager: purchaseManager
        )
        .edgesIgnoringSafeArea(.all)
      }
    }
    .navigationBarBackButtonHidden(true)
  }
}
