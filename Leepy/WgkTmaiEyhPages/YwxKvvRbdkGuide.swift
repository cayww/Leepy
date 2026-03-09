import SwiftUI

struct YwxKvvRbdkGuide: View {
  #if DEBUG
    @ObserveInjection var forceRedraw
  #endif

  var body: some View {
    #if DEBUG
      let _ = forceRedraw
    #endif
    GeometryReader { geometry in
      Image("Assets/leepy_guide_bg")
        .resizable().scaledToFill().ignoresSafeArea()
      VStack {
        Spacer().frame(height: 11.h)
        HStack {
          Image("LeepyLogo").resizable().scaledToFit().frame(width: 80.r, height: 80.r)
            .cornerRadius(20.r)
            .overlay(
              RoundedRectangle(cornerRadius: 20)
                .stroke(.white, lineWidth: 2.67)
            )
          Spacer()
          Text("EULA")
            .foregroundColor(Color("text1"))
            .font(.system(size: 16))
            .padding(.horizontal, 10.w)
            .padding(.vertical, 6.5.h)
            .background(.white)
            .cornerRadius(10)
        }
        .padding(.horizontal, 20.w)
        Spacer()
        Button(action: {

        }) {
          Text("Login by email")
            .foregroundColor(Color("text1"))
            .font(.system(size: 20.sp, weight: .bold))
        }
        .frame(height: 62.h)
        .frame(maxWidth: .infinity)
        .background(
          Rectangle()
            .fill(
              LinearGradient(
                gradient: Gradient(colors: [
                  Color(red: 233 / 255, green: 175 / 255, blue: 251 / 255),
                  Color(red: 238 / 255, green: 250 / 255, blue: 136 / 255),
                ]),
                startPoint: .bottom,
                endPoint: .top
              )
            )
        )
        .cornerRadius(40)
        .padding(.horizontal, 73.w)
      }
    }
    .enableInjection()
  }
}
