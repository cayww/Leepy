import SwiftUI

struct SwipeBackModifier: ViewModifier {
  @EnvironmentObject var router: WwaQhwoEkuRouter
  func body(content: Content) -> some View {
    content
      .gesture(
        DragGesture(minimumDistance: 20)
          .onEnded { value in
            if value.translation.width > 50 {
              router.qmzjFtvKuhPath.removeLast()
            }
          }
      )
  }
}

extension View {
  func swipeBack() -> some View {
    modifier(SwipeBackModifier())
  }
}
