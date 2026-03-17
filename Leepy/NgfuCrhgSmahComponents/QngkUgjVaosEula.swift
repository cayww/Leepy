import SwiftUI

struct QngkUgjVaosEula: View {
  @Binding var isAgreeEula: Bool
  @Binding var isShowEula: Bool
  var body: some View {
    ZStack {
      Color.black.opacity(0.2).ignoresSafeArea()
      VStack(spacing: 0) {
        Spacer().frame(height: 60.h)
        Text("EULA")
          .foregroundColor(Color("text1"))
          .font(.system(size: 24.sp, weight: .bold))
        Spacer().frame(height: 20.h)
        Text(
          """
          Welcome to Leepy! To make a better place,the following content is not allowed in the app in particular.

          1.Any content about child harm,pornography related detrimental to children.
          2. Fake and harmful messages about recent or current events.
          3. Any violence,bullying content, publicly promotes pornography and other content.

          If we find any content including and not limited to the above violations your content will be deleted and account will be banned.By clicking the above button,you agreeto the Terms of Use and Privacy Policy
          """
        )
        .foregroundColor(Color("text2"))
        .font(.system(size: 14.sp))
        .padding(.horizontal, 32.w)
        Spacer().frame(height: 60.h)
        HStack(spacing: 23.w) {
          Button(action: {
            isShowEula = false
            isAgreeEula = false
          }) {
            Text("Cancle")
              .foregroundColor(.white)
              .font(.system(size: 16.sp, weight: .bold))
              .frame(maxWidth: .infinity)
          }
          .frame(height: 38.h)
          .background(
            Rectangle()
              .fill(.black)
              .overlay(
                RoundedRectangle(cornerRadius: 12)
                  .stroke(Color.clear)
                  .shadow(color: Color.white.opacity(0.6), radius: 2, x: -2, y: -2)
                  .clipShape(RoundedRectangle(cornerRadius: 12))
              )
              .overlay(
                RoundedRectangle(cornerRadius: 12)
                  .stroke(Color.clear)
                  .shadow(color: Color.white.opacity(0.5), radius: 2, x: 2, y: 2)
                  .clipShape(RoundedRectangle(cornerRadius: 12))
              )
          )
          .cornerRadius(40)
          Button(action: {
            isShowEula = false
            isAgreeEula = true
          }) {
            Text("I agree")
              .foregroundColor(Color("text1"))
              .font(.system(size: 16.sp, weight: .bold))
              .frame(maxWidth: .infinity)
          }
          .frame(height: 38.h)
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
        }
        .padding(.horizontal, 36.w)
        Spacer()
      }
      .frame(width: 335.w, height: 611.h)
      .background(
        Image("Assets/leepy_eula_bg").resizable().scaledToFill().ignoresSafeArea()
      )
    }
  }
}
