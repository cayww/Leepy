import Kingfisher
import SwiftData
import SwiftUI

struct IrlvCtgVhhFound: View {
  #if DEBUG
    @ObserveInjection var forceRedraw
  #endif
  @EnvironmentObject var appState: RlbHdbTvacState
  @Environment(\.modelContext) private var modelContext
  @EnvironmentObject var router: SvcdXfvTsxRouter
  @Query private var dynamics: [DynamicModel]
  var filteredVideoDynamics: [DynamicModel] {
    guard let blockList = appState.wfzqCubCpmUser?.blockList else {
      return dynamics.filter { $0.dynamicType == 1 }
    }
    return dynamics.filter {
      !blockList.contains($0.user?.userId ?? "") && $0.dynamicType == 1
    }
  }
  var filteredVideoDynamicsWithFollow: [DynamicModel] {
    guard let blockList = appState.wfzqCubCpmUser?.blockList else {
      return dynamics.filter { $0.dynamicType == 1 }
    }
    guard let followList = appState.wfzqCubCpmUser?.follow else {
      return dynamics.filter { $0.dynamicType == 1 }
    }
    return dynamics.filter {
      !blockList.contains($0.user?.userId ?? "") && $0.dynamicType == 1
        && followList.contains($0.user?.userId ?? "")
    }
  }
  enum Tab: Hashable {
    case lastest
    case following
  }

  @State private var selectedTab: Tab = .lastest
  var body: some View {
    #if DEBUG
      let _ = forceRedraw
    #endif
    GeometryReader { geo in
      Image("Assets/leepy_splash_bg").resizable().scaledToFill().ignoresSafeArea()
      VStack(spacing: 0) {
        HStack(spacing: 0) {
          HStack(spacing: 24.w) {
            Text("Lastest")
              .foregroundColor(selectedTab == .lastest ? Color("text1") : Color("text3"))
              .font(.system(size: 24.sp, weight: .bold))
              .onTapGesture {
                selectedTab = .lastest
              }
            Text("Following")
              .foregroundColor(selectedTab == .following ? Color("text1") : Color("text3"))
              .font(.system(size: 24.sp, weight: .bold))
              .onTapGesture {
                selectedTab = .following
              }
          }
          Spacer()
          Image("Assets/leepy_video_post_add")
            .resizable().scaledToFit().frame(width: 40.r, height: 40.r)
            .onTapGesture {
              router.leepyPath.append(
                WwaQhwoEkuMainRoute.wfueZroFsmnPrimary(
                  url: URL(
                    string:
                      "http://192.168.9.129:2025/publish-video")!
                ))
            }
        }.padding(.horizontal, 20.w)
        Spacer().frame(height: 25.h)
        TabView(selection: $selectedTab) {
          ScrollView(.vertical) {
            VStack(spacing: 40.h) {
              ForEach(filteredVideoDynamics, id: \.self) { dynamicEntity in
                VStack {
                  Spacer().frame(height: 26.h)
                  HStack(spacing: 12.w) {
                    KFImage(URL(string: dynamicEntity.dynamicPic.first!))
                      .fade(duration: 0.25)
                      .resizable()
                      .scaledToFill()
                      .frame(width: 192.w, height: 150.h)
                      .cornerRadius(24.r)
                      .overlay(
                        RoundedRectangle(cornerRadius: 24.r)
                          .stroke(Color.black, lineWidth: 1)
                      )
                      .overlay(
                        Image("Assets/leepy_play_icon").resizable().scaledToFit().frame(
                          width: 20.r, height: 20.r), alignment: .center)
                    VStack(spacing: 0) {
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
                  Spacer().frame(height: 10.h)
                  HStack(spacing: 0) {
                    Image("Assets/leepy_found_item_inputer")
                      .resizable().scaledToFit().frame(width: 234.w, height: 40.h)
                    Spacer()
                    HStack(spacing: 4.w) {
                      Image(
                        "Assets/leepy_video_comment_icon"
                      )
                      .resizable().scaledToFit().frame(width: 20.r, height: 20.r)
                      Text("\(dynamicEntity.dynamicCommentCount)")
                        .foregroundColor(Color("text2"))
                        .font(.system(size: 14.sp))
                    }
                    .frame(width: 77.w, height: 30.h)
                    .background(Color(red: 238 / 255, green: 250 / 255, blue: 136 / 255))
                    .overlay(
                      RoundedRectangle(cornerRadius: 10.r)
                        .stroke(Color.black.opacity(1), lineWidth: 1)
                    )
                    .cornerRadius(10.r)
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
                .overlay(
                  HStack(spacing: 8.w) {
                    KFImage(URL(string: dynamicEntity.user?.avatar ?? ""))
                      .fade(duration: 0.25)
                      .resizable()
                      .scaledToFill()
                      .frame(width: 40.r, height: 40.r)
                      .overlay(
                        Circle()
                          .stroke(Color.black, lineWidth: 1)
                      )
                      .clipShape(Circle())
                    Text(dynamicEntity.user?.name ?? "")
                      .foregroundColor(Color("text1"))
                      .font(.system(size: 18.sp, weight: .bold))
                    Spacer()
                  }
                  .padding(.all, 6)
                  .background(Color(red: 169 / 255, green: 192 / 255, blue: 255 / 255))
                  .overlay(
                    RoundedRectangle(cornerRadius: 40.r)
                      .stroke(Color.black, lineWidth: 1)
                  )
                  .cornerRadius(40.r)
                  .padding(.horizontal, 20.w)
                  .offset(y: -25.h), alignment: .top
                )
                .padding(.horizontal, 9.w)
              }
            }
            .padding(.top, 25.h)
          }
          .scrollIndicators(.hidden)
          .padding(.horizontal, 10.w)
          .tag(Tab.lastest)
          ScrollView(.vertical) {
            VStack(spacing: 40.h) {
              ForEach(filteredVideoDynamicsWithFollow, id: \.self) { dynamicEntity in
                VStack {
                  Spacer().frame(height: 26.h)
                  HStack(spacing: 12.w) {
                    KFImage(URL(string: dynamicEntity.dynamicPic.first!))
                      .fade(duration: 0.25)
                      .resizable()
                      .scaledToFill()
                      .frame(width: 192.w, height: 150.h)
                      .cornerRadius(24.r)
                      .overlay(
                        RoundedRectangle(cornerRadius: 24.r)
                          .stroke(Color.black, lineWidth: 1)
                      )
                      .overlay(
                        Image("Assets/leepy_play_icon").resizable().scaledToFit().frame(
                          width: 20.r, height: 20.r), alignment: .center)
                    VStack(spacing: 0) {
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
                  Spacer().frame(height: 10.h)
                  HStack(spacing: 0) {
                    Image("Assets/leepy_found_item_inputer")
                      .resizable().scaledToFit().frame(width: 234.w, height: 40.h)
                    Spacer()
                    HStack(spacing: 4.w) {
                      Image(
                        "Assets/leepy_video_comment_icon"
                      )
                      .resizable().scaledToFit().frame(width: 20.r, height: 20.r)
                      Text("\(dynamicEntity.dynamicCommentCount)")
                        .foregroundColor(Color("text2"))
                        .font(.system(size: 14.sp))
                    }
                    .frame(width: 77.w, height: 30.h)
                    .background(Color(red: 238 / 255, green: 250 / 255, blue: 136 / 255))
                    .overlay(
                      RoundedRectangle(cornerRadius: 10.r)
                        .stroke(Color.black.opacity(1), lineWidth: 1)
                    )
                    .cornerRadius(10.r)
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
                .overlay(
                  HStack(spacing: 8.w) {
                    KFImage(URL(string: dynamicEntity.user?.avatar ?? ""))
                      .fade(duration: 0.25)
                      .resizable()
                      .scaledToFill()
                      .frame(width: 40.r, height: 40.r)
                      .overlay(
                        Circle()
                          .stroke(Color.black, lineWidth: 1)
                      )
                      .clipShape(Circle())
                    Text(dynamicEntity.user?.name ?? "")
                      .foregroundColor(Color("text1"))
                      .font(.system(size: 18.sp, weight: .bold))
                    Spacer()
                  }
                  .padding(.all, 6)
                  .background(Color(red: 169 / 255, green: 192 / 255, blue: 255 / 255))
                  .overlay(
                    RoundedRectangle(cornerRadius: 40.r)
                      .stroke(Color.black, lineWidth: 1)
                  )
                  .cornerRadius(40.r)
                  .padding(.horizontal, 20.w)
                  .offset(y: -25.h), alignment: .top
                )
                .padding(.horizontal, 9.w)
              }
            }
            .padding(.top, 25.h)
          }
          .scrollIndicators(.hidden)
          .padding(.horizontal, 10.w)
          .tag(Tab.following)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .background(Color.clear)
      }
    }
    .enableInjection()
  }
}
