import SwiftUI
import WebKit

struct GljqWbqvDgmAgreeContent: UIViewRepresentable {

  var trvudfhvSsxcUrl: URL

  func makeUIView(context: Context) -> WKWebView {
    let webView = WKWebView()
    webView.scrollView.showsVerticalScrollIndicator = false
    webView.scrollView.showsHorizontalScrollIndicator = false
    return webView
  }

  func updateUIView(_ webView: WKWebView, context: Context) {
    let request = URLRequest(url: trvudfhvSsxcUrl)
    webView.load(request)
  }
}

struct GljqWbqvDgmAgree: View {
  #if DEBUG
    @ObserveInjection var forceRedraw
  #endif
  @EnvironmentObject var router: BtdusvhvDdsRouter
  let trvudfhvSsxcUrl: URL
  var body: some View {
    #if DEBUG
      let _ = forceRedraw
    #endif
    GeometryReader { geo in
      Image("Assets/leepy_splash_bg").resizable().scaledToFill().ignoresSafeArea()
      ProgressView()
        .progressViewStyle(CircularProgressViewStyle(tint: Color("text1")))
      GljqWbqvDgmAgreeContent(trvudfhvSsxcUrl: trvudfhvSsxcUrl)
        .edgesIgnoringSafeArea(.bottom)
    }
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button {
          router.leepyPath.removeLast()
        } label: {
          Image("Assets/leepy_back")
            .resizable()
            .scaledToFit()
            .frame(width: 40.r, height: 40.r)
        }
      }
    }
    .enableInjection()
  }
}
