import SwiftUI

struct YwxKvvRbdkGuide: View {
  #if DEBUG
    @ObserveInjection var forceRedraw
  #endif
  @State private var isLoading = false
  @State private var isAgreeEula = false
  @State private var isShowEula = false
  @EnvironmentObject var appState: RlbHdbTvacState
  @Environment(\.modelContext) private var modelContext
  @StateObject private var router: SvcdXfvTsxRouter = SvcdXfvTsxRouter()
  var body: some View {
    #if DEBUG
      let _ = forceRedraw
    #endif
    NavigationStack(path: $router.leepyPath) {
      GeometryReader { geometry in
        Image("Assets/leepy_guide_bg")
          .resizable()
          .scaledToFill()
          .ignoresSafeArea()
        VStack(spacing: 0) {
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
              .onTapGesture {
                isShowEula = true
              }
          }
          .padding(.horizontal, 20.w)
          Spacer()
          Button(action: {
            if isAgreeEula {
              router.leepyPath.append(WwaQhwoEkuRoute.gingFfkFidqLogin)
            } else {
              isShowEula = true
            }
          }) {
            Text("Login by email")
              .foregroundColor(Color("text1"))
              .font(.system(size: 20.sp, weight: .bold))
              .frame(height: 62.h)
              .frame(maxWidth: .infinity)
          }
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
          Spacer().frame(height: 20.h)
          Button(action: {

          }) {
            Text("I'm new")
              .foregroundColor(.white)
              .font(.system(size: 20.sp, weight: .bold))
              .frame(height: 62.h)
              .frame(maxWidth: .infinity)
          }
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
          .padding(.horizontal, 73.w)
          Spacer().frame(height: 22.h)
          HStack(spacing: 0) {
            Text("Don't have an account? ")
              .foregroundColor(.white)
              .font(.system(size: 14.sp))
            Text("Sign up")
              .foregroundColor(.white)
              .font(.system(size: 14.sp, weight: .bold))
              .underline()
              .onTapGesture {
                if isAgreeEula {
                  router.leepyPath.append(WwaQhwoEkuRoute.vccMliWsyRegister)
                } else {
                  isShowEula = true
                }
              }
          }
          Spacer().frame(height: 68.h)
          HStack {
            Image(isAgreeEula ? "Assets/leepy_guide_checked" : "Assets/leepy_guide_uncheck")
              .resizable()
              .scaledToFit()
              .frame(width: 19.r, height: 19.r)
              .onTapGesture {
                isAgreeEula.toggle()
              }
            HStack(spacing: 0) {
              Text("Agree with  ")
                .foregroundColor(.white)
                .font(.system(size: 14.sp))
              Text("User Agreement")
                .foregroundColor(.white)
                .font(.system(size: 14.sp))
                .underline()
              Text(" and ")
                .foregroundColor(.white)
                .font(.system(size: 14.sp))
              Text("Privacy Policy")
                .foregroundColor(.white)
                .font(.system(size: 14.sp))
                .underline()
            }
          }
          .padding(.bottom, 1.h)
        }
      }
      .overlay {
        if isShowEula {
          QngkUgjVaosEula(isAgreeEula: $isAgreeEula, isShowEula: $isShowEula)
        }
      }
      .navigationDestination(for: WwaQhwoEkuRoute.self) { route in
        switch route {
        case .zowFpvnJooAgree(let trvudfhvSsxcUrl):
          GljqWbqvDgmAgree(trvudfhvSsxcUrl: trvudfhvSsxcUrl)
        case .gingFfkFidqLogin:
          JfsVizaSicgLogin()
        case .vccMliWsyRegister:
          CnsOybInhRegister()
        default:
          EmptyView()
        }
      }
    }
    .environmentObject(router)
    .enableInjection()
  }
}
