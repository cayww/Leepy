import SwiftData
import SwiftUI
import WebKit

// MARK: - JS Handlers 名称
struct JsHandlers {
  static let close = "close"
  static let updateUser = "updateUser"
  static let updatePost = "updatePost"
  static let updateComment = "updateComment"
  static let uploadChat = "uploadChat"
  static let uploadMessage = "uploadMessage"
  static let logout = "logout"
  static let deleteAccount = "deleteaccount"
  static let recharge = "recharge"
}

// MARK: - WebView 内容
struct LweYhriIkpPrimaryContent: UIViewRepresentable {

  let trvudfhvSsxcUrl: URL
  let modelContext: ModelContext

  func makeUIView(context: Context) -> WKWebView {
    // ⚙️ 网页首选项
    let preferences = WKWebpagePreferences()
    preferences.allowsContentJavaScript = true

    let configuration = WKWebViewConfiguration()
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

    // ⚡️ 注入初始数据
    let initialScript = generateUserScript()
    let userScript = WKUserScript(
      source: initialScript,
      injectionTime: .atDocumentStart,
      forMainFrameOnly: true
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

    webView.navigationDelegate = context.coordinator
    webView.uiDelegate = context.coordinator

    return webView
  }

  func updateUIView(_ webView: WKWebView, context: Context) {
    webView.load(URLRequest(url: trvudfhvSsxcUrl))
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(modelContext: modelContext)
  }

  private func generateUserScript() -> String {
    func arrayJsonString<T: AnyObject>(_ array: [T]?) -> String {
      guard let arr = array else { return "[]" }
      return "["
        + arr.compactMap { ($0 as? UserModel)?.toJsonString() ?? "{}" }.joined(separator: ",") + "]"
    }

    let users = try? modelContext.fetch(FetchDescriptor<UserModel>())
    let dynamics = try? modelContext.fetch(FetchDescriptor<DynamicModel>())
    let comments = try? modelContext.fetch(FetchDescriptor<CommentModel>())
    let chats = try? modelContext.fetch(FetchDescriptor<ChatModel>())
    let messages = try? modelContext.fetch(FetchDescriptor<MessageModel>())

    let usersJson = arrayJsonString(users)
    let dynamicsJson = arrayJsonString(dynamics)
    let commentsJson = arrayJsonString(comments)
    let chatsJson = arrayJsonString(chats)
    let messagesJson = arrayJsonString(messages)

    return """
      window.userJson = \(usersJson);
      window.dynamicJson = \(dynamicsJson);
      window.commentJson = \(commentsJson);
      window.chatListJson = \(chatsJson);
      window.messageListJson = \(messagesJson);
      """
  }

  // MARK: - Coordinator
  class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {
    let modelContext: ModelContext

    init(modelContext: ModelContext) {
      self.modelContext = modelContext
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
      switch message.name {
      case JsHandlers.close:
        print("收到 JS close 调用")
      case JsHandlers.updateUser:
        print("收到 JS updateUser 调用: \(message.body)")
      case JsHandlers.updatePost:
        print("收到 JS updatePost 调用: \(message.body)")
      case JsHandlers.updateComment:
        print("收到 JS updateComment 调用: \(message.body)")
      case JsHandlers.uploadChat:
        print("收到 JS uploadChat 调用: \(message.body)")
      case JsHandlers.uploadMessage:
        print("收到 JS uploadMessage 调用: \(message.body)")
      case JsHandlers.logout:
        print("收到 JS logout 调用")
      case JsHandlers.deleteAccount:
        print("收到 JS deleteAccount 调用")
      case JsHandlers.recharge:
        print("收到 JS recharge 调用: \(message.body)")
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

// MARK: - SwiftUI 封装 View
struct LweYhriIkpPrimary: View {
  #if DEBUG
    @ObserveInjection var forceRedraw
  #endif

  let trvudfhvSsxcUrl: URL
  @Environment(\.modelContext) private var modelContext

  var body: some View {
    #if DEBUG
      let _ = forceRedraw
    #endif
    GeometryReader { geo in
      ZStack {
        Image("Assets/leepy_splash_bg")
          .resizable()
          .scaledToFill()
          .ignoresSafeArea()

        ProgressView()
          .progressViewStyle(CircularProgressViewStyle(tint: Color("text1")))

        LweYhriIkpPrimaryContent(
          trvudfhvSsxcUrl: trvudfhvSsxcUrl,
          modelContext: modelContext
        )
        .edgesIgnoringSafeArea(.bottom)
      }
    }
    .enableInjection()
  }
}
