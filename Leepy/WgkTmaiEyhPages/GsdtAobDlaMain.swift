import SwiftData
import SwiftUI

struct GsdtAobDlaMain: View {
  #if DEBUG
    @ObserveInjection var forceRedraw
  #endif
  @EnvironmentObject var appState: RlbHdbTvacState
  @Environment(\.modelContext) private var modelContext
  @StateObject private var router: SvcdXfvTsxRouter = SvcdXfvTsxRouter()

  enum Tab: Hashable {
    case home
    case found
    case message
    case profile
  }

  @State private var selectedTab: Tab = .home
  var body: some View {
    #if DEBUG
      let _ = forceRedraw
    #endif
    NavigationStack(path: $router.leepyPath) {
      TabView(selection: $selectedTab) {
        PprqKumkZetHome()
          .tag(Tab.home)
        IrlvCtgVhhFound()
          .tag(Tab.found)
        KwcJszQyjMessage()
          .tag(Tab.message)
        EckPjrFxxkProfile()
          .tag(Tab.profile)
      }
      .navigationDestination(for: WwaQhwoEkuMainRoute.self) { route in
        switch route {
        case .wfueZroFsmnPrimary(let url):
          LweYhriIkpPrimary(trvudfhvSsxcUrl: url)
        case .zowFpvnJooAgree(let url):
          GljqWbqvDgmAgree(trvudfhvSsxcUrl: url)
        }
      }
      .safeAreaInset(edge: .bottom) {
        VStack(spacing: 0) {
          HStack(spacing: 120.w) {
            HStack {
              Image(selectedTab == .home ? "Assets/leepy_home_a" : "Assets/leepy_home_u")
                .resizable()
                .scaledToFit()
                .frame(width: 26.r, height: 26.r)
                .onTapGesture {
                  selectedTab = .home
                }
              Spacer()
              Image(selectedTab == .found ? "Assets/leepy_found_a" : "Assets/leepy_found_u")
                .resizable()
                .scaledToFit()
                .frame(width: 26.r, height: 26.r)
                .onTapGesture {
                  selectedTab = .found
                }
            }
            HStack {
              Image(selectedTab == .message ? "Assets/leepy_msg_a" : "Assets/leepy_msg_u")
                .resizable()
                .scaledToFit()
                .frame(width: 26.r, height: 26.r)
                .onTapGesture {
                  selectedTab = .message
                }
              Spacer()
              Image(selectedTab == .profile ? "Assets/leepy_profile_a" : "Assets/leepy_profile_u")
                .resizable()
                .scaledToFit()
                .frame(width: 26.r, height: 26.r)
                .onTapGesture {
                  selectedTab = .profile
                }
            }
          }
          .padding(.horizontal, 31.w)
          .frame(maxWidth: .infinity)
          .frame(height: 48.h)
          .background(
            Image("Assets/leepy_tabbar_bg")
              .resizable()
              .scaledToFit()
          )
          .overlay(alignment: .top) {
            Image("Assets/leepy_add_post_icon")
              .resizable()
              .scaledToFit()
              .frame(
                width: 46.r, height: 46.r
              )
              .onTapGesture {
                router.leepyPath.append(
                  WwaQhwoEkuMainRoute.wfueZroFsmnPrimary(
                    url: URL(
                      string:
                        "https://spectacular-taiyaki-a6924e.netlify.app/send-dynamic")!
                  ))
              }
              .offset(y: -31.r)
          }
          Color.clear
            .frame(maxWidth: .infinity)
            .frame(height: 0)
            .safeAreaPadding(.bottom)
            .background(Color(red: 233 / 255, green: 175 / 255, blue: 251 / 255))
        }
      }
      .ignoresSafeArea(edges: .bottom)
    }
    .environmentObject(router)
    .enableInjection()
  }
}
