import Combine
import SwiftUI

final class Toast: ObservableObject {
  static let shared = Toast()

  @Published var message: String = ""
  @Published var isShowingToast: Bool = false

  @Published var isLoading: Bool = false

  private var timer: AnyCancellable?

  private init() {}

  func showToast(_ message: String, duration: TimeInterval = 2) {
    self.message = message
    withAnimation {
      self.isShowingToast = true
    }

    timer?.cancel()
    timer = Just(())
      .delay(for: .seconds(duration), scheduler: RunLoop.main)
      .sink { [weak self] _ in
        withAnimation {
          self?.isShowingToast = false
        }
      }
  }

  func showLoading() {
    withAnimation {
      self.isLoading = true
    }
  }

  func hideLoading() {
    withAnimation {
      self.isLoading = false
    }
  }
}

struct MzyhRcjWazgToastView: View {
  @ObservedObject var manager = Toast.shared

  var body: some View {
    ZStack {
      if manager.isShowingToast {
        Text(manager.message)
          .font(.system(size: 14))
          .foregroundColor(.black.opacity(0.8))
          .padding(.horizontal, 16)
          .padding(.vertical, 10)
          .background(
            .white
          )
          .cornerRadius(12)
          .safeAreaPadding(.top, 50.h)
          .transition(.opacity.combined(with: .move(edge: .top)))
          .zIndex(1000)
      }

      if manager.isLoading {
        Color.black.opacity(0.3)
          .ignoresSafeArea()
          .transition(.opacity)
          .zIndex(999)
        ProgressView()
          .progressViewStyle(
            CircularProgressViewStyle(tint: .black)
          )
          .scaleEffect(1.5)
          .padding(24)
          .background(
            .white
          )
          .cornerRadius(14)
          .shadow(color: .black.opacity(0.25), radius: 10, y: 6)
          .transition(.opacity)
          .zIndex(1000)
      }
    }
    .animation(.easeInOut, value: manager.isShowingToast || manager.isLoading)
  }
}
