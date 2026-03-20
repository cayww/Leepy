import Kingfisher
import SwiftData
import SwiftUI

struct IrlvCtgVhhFound: View {

  @EnvironmentObject var appState: RlbHdbTvacState
  @EnvironmentObject var router: BtdusvhvDdsRouter
  @Query private var dynamics: [DynamicModel]

  enum Tab: Hashable {
    case lastest
    case following
  }

  @State private var selectedTab: Tab = .lastest

  // MARK: - 数据过滤
  private var filteredVideoDynamics: [DynamicModel] {
    guard let blockList = appState.wfzqCubCpmUser?.blockList else {
      return dynamics.filter { $0.dynamicType == 1 }
    }
    return dynamics.filter {
      !blockList.contains($0.user?.userId ?? "") && $0.dynamicType == 1
    }
  }

  private var filteredVideoDynamicsWithFollow: [DynamicModel] {
    guard let blockList = appState.wfzqCubCpmUser?.blockList,
      let followList = appState.wfzqCubCpmUser?.follow
    else {
      return dynamics.filter { $0.dynamicType == 1 }
    }
    return dynamics.filter {
      !blockList.contains($0.user?.userId ?? "") && $0.dynamicType == 1
        && followList.contains($0.user?.userId ?? "")
    }
  }

  // MARK: - UI
  var body: some View {
    ZStack {
      bgView

      VStack(spacing: 0) {
        header
        Spacer().frame(height: 25.h)
        tabs
      }
    }
  }

  // MARK: - 背景
  private var bgView: some View {
    Image("Assets/leepy_splash_bg")
      .resizable()
      .scaledToFill()
      .ignoresSafeArea()
  }

  // MARK: - 顶部
  private var header: some View {
    HStack {
      HStack(spacing: 24.w) {
        tabItem("Lastest", .lastest)
        tabItem("Following", .following)
      }

      Spacer()

      Image("Assets/leepy_video_post_add")
        .resizable()
        .scaledToFit()
        .frame(width: 40.r, height: 40.r)
        .onTapGesture {
          router.leepyPath.append(
            BdfuivDvufhtdsMainRoute.wfueZroFsmnPrimary(
              url: URL(string: "https://spectacular-taiyaki-a6924e.netlify.app/publish-video")!
            )
          )
        }
    }
    .padding(.horizontal, 20.w)
  }

  private func tabItem(_ title: String, _ tab: Tab) -> some View {
    Text(title)
      .foregroundColor(selectedTab == tab ? Color("text1") : Color("text3"))
      .font(.system(size: 24.sp, weight: .bold))
      .onTapGesture {
        selectedTab = tab
      }
  }

  // MARK: - TabView
  private var tabs: some View {
    TabView(selection: $selectedTab) {

      listView(filteredVideoDynamics)
        .tag(Tab.lastest)

      listView(filteredVideoDynamicsWithFollow)
        .tag(Tab.following)
    }
    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
  }

  // MARK: - 列表
  private func listView(_ list: [DynamicModel]) -> some View {
    ScrollView {
      VStack(spacing: 40.h) {
        ForEach(list, id: \.self) { item in
          FoundItemView(dynamicEntity: item)
        }
      }
      .padding(.top, 25.h)
    }
    .scrollIndicators(.hidden)
    .padding(.horizontal, 10.w)
  }
}

struct FoundItemView: View {

  let dynamicEntity: DynamicModel

  @EnvironmentObject var appState: RlbHdbTvacState
  @EnvironmentObject var router: BtdusvhvDdsRouter

  var body: some View {
    VStack {
      Spacer().frame(height: 26.h)

      HStack(spacing: 12.w) {
        coverView
        rightContent
      }

      Spacer().frame(height: 10.h)
      bottomBar
    }
    .padding(8)
    .background(cardBackground)
    .onTapGesture {
      router.leepyPath.append(
        BdfuivDvufhtdsMainRoute.wfueZroFsmnPrimary(
          url: URL(
            string:
              "https://spectacular-taiyaki-a6924e.netlify.app/short-video?id=\(dynamicEntity.dynamicId)"
          )!
        )
      )
    }
    .overlay(topUserInfo, alignment: .top)
    .padding(.horizontal, 9.w)
  }

  // MARK: - 封面
  private var coverView: some View {
    ZStack {
      KFImage(URL(string: dynamicEntity.dynamicPic.first ?? ""))
        .resizable()
        .scaledToFill()
        .frame(width: 192.w, height: 150.h)
        .cornerRadius(24.r)

      Image("Assets/leepy_play_icon")
        .resizable()
        .scaledToFit()
        .frame(width: 20.r, height: 20.r)
    }
  }

  // MARK: - 右侧
  private var rightContent: some View {
    VStack(alignment: .leading) {
      Text(dynamicEntity.dynamicDesc)
        .foregroundColor(Color("text2"))
        .font(.system(size: 14.sp))
        .lineLimit(3)

      Spacer().frame(height: 12.h)
      Spacer()

      likeView

      Spacer()
    }
  }

  // MARK: - 点赞
  private var likeView: some View {
    HStack(spacing: 4.w) {
      Image(
        appState.wfzqCubCpmUser?.picPostLikeIds.contains(dynamicEntity.dynamicId) == true
          ? "Assets/leepy_like_icon"
          : "Assets/leepy_unlike_icon"
      )
      .resizable()
      .scaledToFit()
      .frame(width: 30.r, height: 30.r)

      Text("\(dynamicEntity.dynamicLikeCount)")
        .foregroundColor(.white)
        .font(.system(size: 14.sp))
    }
    .frame(width: 77.w, height: 30.h)
    .background(Color(red: 233 / 255, green: 175 / 255, blue: 251 / 255))
    .overlay(
      RoundedRectangle(cornerRadius: 10.r)
        .stroke(Color.black, lineWidth: 1)
    )
    .cornerRadius(10.r)
  }

  // MARK: - 底部
  private var bottomBar: some View {
    HStack {
      Image("Assets/leepy_found_item_inputer")
        .resizable()
        .scaledToFit()
        .frame(width: 234.w, height: 40.h)

      Spacer()

      HStack(spacing: 4.w) {
        Image("Assets/leepy_video_comment_icon")
          .resizable()
          .scaledToFit()
          .frame(width: 20.r, height: 20.r)

        Text("\(dynamicEntity.dynamicCommentCount)")
          .foregroundColor(Color("text2"))
          .font(.system(size: 14.sp))
      }
      .frame(width: 77.w, height: 30.h)
      .background(Color(red: 238 / 255, green: 250 / 255, blue: 136 / 255))
      .overlay(
        RoundedRectangle(cornerRadius: 10.r)
          .stroke(Color.black, lineWidth: 1)
      )
      .cornerRadius(10.r)
    }
  }

  // MARK: - 用户信息
  private var topUserInfo: some View {
    HStack(spacing: 8.w) {
      KFImage(URL(string: dynamicEntity.user?.avatar ?? ""))
        .resizable()
        .scaledToFill()
        .frame(width: 40.r, height: 40.r)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.black, lineWidth: 1))

      Text(dynamicEntity.user?.name ?? "")
        .foregroundColor(Color("text1"))
        .font(.system(size: 18.sp, weight: .bold))

      Spacer()
    }
    .padding(6)
    .background(Color(red: 169 / 255, green: 192 / 255, blue: 255 / 255))
    .overlay(
      RoundedRectangle(cornerRadius: 40.r)
        .stroke(Color.black, lineWidth: 1)
    )
    .cornerRadius(40.r)
    .padding(.horizontal, 20.w)
    .offset(y: -25.h)
  }

  // MARK: - 卡片背景
  private var cardBackground: some View {
    RoundedRectangle(cornerRadius: 30.r)
      .stroke(Color.black, lineWidth: 1)
      .background(Color.clear)
  }
}
