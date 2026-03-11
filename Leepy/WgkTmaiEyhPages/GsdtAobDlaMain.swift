import SwiftData
import SwiftUI

struct GsdtAobDlaMain: View {
  #if DEBUG
    @ObserveInjection var forceRedraw
  #endif
  @EnvironmentObject var appState: RlbHdbTvacState
  @Environment(\.modelContext) private var modelContext
  @Query private var dynamics: [DynamicModel]
  @StateObject private var router: SvcdXfvTsxRouter = SvcdXfvTsxRouter()
  var filteredDynamics: [DynamicModel] {
    guard let blockList = appState.wfzqCubCpmUser?.blockList else {
      return dynamics
    }
    let blockedUserIDs = Set(blockList)
    return dynamics.filter { !blockedUserIDs.contains($0.userId) }
  }

  var body: some View {
    #if DEBUG
      let _ = forceRedraw
    #endif
    NavigationStack(path: $router.leepyPath) {
      GeometryReader { g in
        Image("Assets/leepy_splash_bg").resizable().scaledToFill().ignoresSafeArea()
        VStack(spacing: 0) {
          Spacer().frame(height: 10.h)
          HStack(spacing: 0) {
            Text("Welcome to\nLeepy")
              .foregroundColor(Color("text1"))
              .font(.system(size: 24.sp, weight: .bold))
            Spacer()
            AsyncImage(url: URL(string: appState.wfzqCubCpmUser!.avatar)) { phase in
              switch phase {
              case .empty:
                ProgressView()
              case .success(let image):
                image
                  .resizable()
                  .scaledToFill()
              case .failure:
                Image(systemName: "photo")
              @unknown default:
                EmptyView()
              }
            }
            .frame(width: 56.r, height: 56.r)
            .overlay(
              Circle()
                .stroke(Color.black, lineWidth: 1)
            )
            .clipShape(Circle())
          }
          .padding(.horizontal, 20.w)
          Spacer().frame(height: 16.h)
          ScrollView(.horizontal) {
            HStack(spacing: 20.w) {
              ForEach(filteredDynamics, id: \.self) { dynamicEntity in
                AsyncImage(url: URL(string: dynamicEntity.dynamicPic.first!)) { phase in
                  switch phase {
                  case .empty:
                    ProgressView()
                  case .success(let image):
                    image
                      .resizable()
                      .scaledToFill()
                  case .failure:
                    Image(systemName: "image")
                  @unknown default:
                    EmptyView()
                  }
                }
                .frame(width: 132.w, height: 166.h)
                .cornerRadius(30.r)
                .overlay(
                  RoundedRectangle(cornerRadius: 30.r)
                    .stroke(Color.black, lineWidth: 1)
                )
              }
            }
          }
          .padding(.leading, 20.w)
          .scrollIndicators(.hidden)
          Spacer().frame(height: 36.h)
          HStack(spacing: 0) {
            VStack(spacing: 4.h) {
              Text("Fashion AI")
                .foregroundColor(.white)
                .font(.system(size: 14.sp, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
              Text("Based on your needs, I'll\nprovide you with the most\nsuitable outfit!")
                .foregroundColor(.white)
                .font(.system(size: 12.sp))
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer()
            Image("Assets/leepy_ai_forward")
              .resizable()
              .scaledToFit()
              .frame(width: 24.r, height: 24.r)
          }
          .padding(.horizontal, 13.w)
          .frame(width: 335.w, height: 95.h)
          .background(Image("Assets/leepy_main_ai_bar").resizable().scaledToFit())
          .overlay(
            Image("Assets/leepy_main_ai_rw").resizable().scaledToFit().frame(
              width: 87.w, height: 125.h
            ).offset(x: -51.w), alignment: .bottomTrailing)
          Spacer().frame(height: 20.h)
        }
      }
    }
    .navigationDestination(for: WwaQhwoEkuMainRoute.self) { route in
      switch route {
      case .wfueZroFsmnPrimary(let url):
        LweYhriIkpPrimary(trvudfhvSsxcUrl: url)
      case .zowFpvnJooAgree(let url):
        GljqWbqvDgmAgree(trvudfhvSsxcUrl: url)
      }
    }
    .enableInjection()
  }
}
