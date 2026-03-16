import Kingfisher
import SwiftData
import SwiftUI

struct PprqKumkZetHome: View {
  #if DEBUG
    @ObserveInjection var forceRedraw
  #endif
  @EnvironmentObject var appState: RlbHdbTvacState
  @Environment(\.modelContext) private var modelContext
  @EnvironmentObject var router: SvcdXfvTsxRouter
  @Query private var dynamics: [DynamicModel]
  var filteredPictureDynamics: [DynamicModel] {
    guard let blockList = appState.wfzqCubCpmUser?.blockList else {
      return dynamics.filter { $0.dynamicType == 0 }
    }
    return dynamics.filter {
      !blockList.contains($0.user?.userId ?? "") && $0.dynamicType == 0
    }
  }
  var filteredVideoDynamics: [DynamicModel] {
    guard let blockList = appState.wfzqCubCpmUser?.blockList else {
      return dynamics.filter { $0.dynamicType == 1 }
    }
    return dynamics.filter {
      !blockList.contains($0.user?.userId ?? "") && $0.dynamicType == 1
    }
  }
  var body: some View {
    #if DEBUG
      let _ = forceRedraw
    #endif
    GeometryReader { g in
      Image("Assets/leepy_splash_bg").resizable().scaledToFill().ignoresSafeArea()
      VStack(spacing: 0) {
        Spacer().frame(height: 10.h)
        HStack(spacing: 0) {
          Text("Welcome to\nLeepy")
            .foregroundColor(Color("text1"))
            .font(.system(size: 24.sp, weight: .bold))
          Spacer()
          KFImage(URL(string: appState.wfzqCubCpmUser!.avatar))
            .fade(duration: 0.25)
            .resizable()
            .scaledToFill()
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
            ForEach(filteredPictureDynamics, id: \.self) { dynamicEntity in
              KFImage(URL(string: dynamicEntity.dynamicPic.first!))
                .fade(duration: 0.25)
                .resizable()
                .scaledToFill()
                .frame(width: 132.w, height: 166.h)
                .cornerRadius(30.r)
                .overlay(
                  RoundedRectangle(cornerRadius: 30.r)
                    .stroke(Color.black, lineWidth: 1)
                )
                .onTapGesture {
                  router.leepyPath.append(
                    WwaQhwoEkuMainRoute.wfueZroFsmnPrimary(
                      url: URL(
                        string:
                          "http://192.168.9.129:2025/article-detail?id=\(dynamicEntity.dynamicId)")!
                    ))
                }
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
          ).offset(x: -51.w), alignment: .bottomTrailing
        )
        .onTapGesture {
          router.leepyPath.append(
            WwaQhwoEkuMainRoute.wfueZroFsmnPrimary(
              url: URL(
                string:
                  "http://192.168.9.129:2025/chat-view")!
            ))
        }
        Spacer().frame(height: 20.h)
        Text("Pop Look")
          .foregroundColor(Color("text1"))
          .font(.system(size: 20.sp, weight: .bold))
          .padding(.leading, 20.w)
          .frame(maxWidth: .infinity, alignment: .leading)
        Spacer().frame(height: 16.h)
        ScrollView(.vertical) {
          VStack(spacing: 16.h) {
            ForEach(filteredVideoDynamics, id: \.self) { dynamicEntity in
              HStack(spacing: 12.w) {
                KFImage(URL(string: dynamicEntity.dynamicPic.first!))
                  .fade(duration: 0.25)
                  .resizable()
                  .scaledToFill()
                  .frame(width: 128.w, height: 150.h)
                  .cornerRadius(24.r)
                  .overlay(
                    RoundedRectangle(cornerRadius: 24.r)
                      .stroke(Color.black, lineWidth: 1)
                  )
                  .overlay(
                    Image("Assets/leepy_play_icon").resizable().scaledToFit().frame(
                      width: 20.r, height: 20.r), alignment: .center)
                VStack(spacing: 0) {
                  HStack(spacing: 8.w) {
                    KFImage(URL(string: dynamicEntity.user?.avatar ?? ""))
                      .fade(duration: 0.25)
                      .resizable()
                      .scaledToFill()
                      .frame(width: 30.r, height: 30.r)
                      .overlay(
                        Circle()
                          .stroke(Color.black, lineWidth: 1)
                      )
                      .clipShape(Circle())
                    Text(dynamicEntity.user?.name ?? "")
                      .foregroundColor(Color("text1"))
                      .font(.system(size: 14.sp))
                    Spacer()
                  }
                  Spacer().frame(height: 10.h)
                  Text(dynamicEntity.dynamicDesc)
                    .foregroundColor(Color("text2"))
                    .font(.system(size: 14.sp))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(3)
                  Spacer().frame(height: 12.h)
                  Spacer()
                  HStack(spacing: 4.w) {
                    Image(
                      appState.wfzqCubCpmUser!.picPostLikeIds.contains(dynamicEntity.dynamicId)
                        ? "Assets/leepy_like_icon" : "Assets/leepy_unlike_icon"
                    )
                    .resizable().scaledToFit().frame(width: 30.r, height: 30.r)
                    Text("\(dynamicEntity.dynamicLikeCount)")
                      .foregroundColor(.white)
                      .font(.system(size: 14.sp))
                  }
                  .frame(width: 77.w, height: 30.h)
                  .background(Color(red: 233 / 255, green: 175 / 255, blue: 251 / 255))
                  .overlay(
                    RoundedRectangle(cornerRadius: 10.r)
                      .stroke(Color.black.opacity(1), lineWidth: 1)
                  )
                  .cornerRadius(10.r)
                  .frame(maxWidth: .infinity, alignment: .leading)
                  Spacer()
                }
              }
              .padding(.all, 8)
              .overlay(
                RoundedRectangle(cornerRadius: 30.r)
                  .stroke(Color.black, lineWidth: 1)
              )
              .cornerRadius(30.r)
              .onTapGesture {
                router.leepyPath.append(
                  WwaQhwoEkuMainRoute.wfueZroFsmnPrimary(
                    url: URL(
                      string:
                        "http://192.168.9.129:2025/short-video?id=\(dynamicEntity.dynamicId)")!
                  ))
              }
              .padding(.horizontal, 9.w)
            }
          }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, 10.w)
      }
    }
    .enableInjection()
  }
}
