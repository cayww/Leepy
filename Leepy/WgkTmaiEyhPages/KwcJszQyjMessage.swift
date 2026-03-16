import Kingfisher
import SwiftData
import SwiftUI

struct KwcJszQyjMessage: View {
  #if DEBUG
    @ObserveInjection var forceRedraw
  #endif
  @EnvironmentObject var appState: RlbHdbTvacState
  @Environment(\.modelContext) private var modelContext
  @EnvironmentObject var router: SvcdXfvTsxRouter
  @Query private var chats: [ChatModel]
  var filteredChats: [ChatModel] {
    guard let blockList = appState.wfzqCubCpmUser?.blockList else {
      return []
    }
    return chats.filter {
      !blockList.contains($0.chatUserIds.first ?? "")
        && !blockList.contains($0.chatUserIds.last ?? "")
        && !$0.lastSendContent.isEmpty
        && $0.chatUserIds.contains(appState.wfzqCubCpmUser?.userId ?? "")
    }
  }
  var body: some View {
    #if DEBUG
      let _ = forceRedraw
    #endif
    GeometryReader { geo in
      Image("Assets/leepy_splash_bg").resizable().scaledToFill().ignoresSafeArea()
      VStack(spacing: 0) {
        Spacer().frame(height: 32.h)
        HStack(spacing: 0) {
          VStack(spacing: 10.h) {
            Image("Assets/leepy_msg_followed")
              .resizable().scaledToFit().frame(width: 44.r, height: 44.r)
            Text("Followed")
              .font(.system(size: 14.sp, weight: .medium))
              .foregroundColor(
                Color("text1")
              )
              .italic()
              .padding(.horizontal, 12.w)
              .padding(.vertical, 6.h)
              .background(.white)
              .overlay(
                RoundedRectangle(cornerRadius: 40.r)
                  .stroke(.black.opacity(1), lineWidth: 1)
              )
              .cornerRadius(40.r)
          }
          .onTapGesture {
            router.leepyPath.append(
              WwaQhwoEkuMainRoute.wfueZroFsmnPrimary(
                url: URL(
                  string:
                    "http://192.168.9.129:2025/fans?id=\(appState.wfzqCubCpmUser?.userId ?? "")"
                )!
              ))
          }
          Spacer()
          VStack(spacing: 10.h) {
            Image("Assets/leepy_msg_following")
              .resizable().scaledToFit().frame(width: 44.r, height: 44.r)
            Text("Following")
              .font(.system(size: 14.sp, weight: .medium))
              .foregroundColor(
                Color("text1")
              )
              .italic()
              .padding(.horizontal, 12.w)
              .padding(.vertical, 6.h)
              .background(.white)
              .overlay(
                RoundedRectangle(cornerRadius: 40.r)
                  .stroke(.black.opacity(1), lineWidth: 1)
              )
              .cornerRadius(40.r)
          }
          .onTapGesture {
            router.leepyPath.append(
              WwaQhwoEkuMainRoute.wfueZroFsmnPrimary(
                url: URL(
                  string:
                    "http://192.168.9.129:2025/follow?id=\(appState.wfzqCubCpmUser?.userId ?? "")"
                )!
              ))
          }
          Spacer()
          VStack(spacing: 10.h) {
            Image("Assets/leepy_msg_liked")
              .resizable().scaledToFit().frame(width: 44.r, height: 44.r)
            Text("Likes")
              .font(.system(size: 14.sp, weight: .medium))
              .foregroundColor(
                Color("text1")
              )
              .italic()
              .padding(.horizontal, 12.w)
              .padding(.vertical, 6.h)
              .background(.white)
              .overlay(
                RoundedRectangle(cornerRadius: 40.r)
                  .stroke(.black.opacity(1), lineWidth: 1)
              )
              .cornerRadius(40.r)
          }
        }
        .padding(.horizontal, 20.w)
        Spacer().frame(height: 20.h)
        Text("Direct messages")
          .foregroundColor(Color("text1"))
          .font(.system(size: 24.sp, weight: .bold))
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal, 20.w)
        Spacer().frame(height: 20.h)
        ScrollView {
          VStack(spacing: 16.h) {
            ForEach(filteredChats) { chat in
              let otherUserId =
                chat.chatUserIds.filter { $0 != appState.wfzqCubCpmUser?.userId }
                .first ?? ""
              let userDescriptor = FetchDescriptor<UserModel>(
                predicate: #Predicate { $0.userId == otherUserId }
              )
              if let otherUser = try? modelContext.fetch(userDescriptor).first {
                HStack(spacing: 11.w) {
                  KFImage(URL(string: otherUser.avatar))
                    .fade(duration: 0.25)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50.r, height: 50.r)
                    .overlay(
                      Circle()
                        .stroke(Color.black, lineWidth: 1)
                    )
                    .clipShape(Circle())
                  VStack(spacing: 5.h) {
                    Text(otherUser.name)
                      .foregroundColor(Color("text1"))
                      .font(.system(size: 16.sp, ))
                      .frame(maxWidth: .infinity, alignment: .leading)
                    Text(otherUser.name)
                      .foregroundColor(Color("text2"))
                      .font(.system(size: 16.sp, ))
                      .frame(maxWidth: .infinity, alignment: .leading)
                  }
                }
                .padding(.all, 10)
                .background(.white)
                .overlay(
                  RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.black, lineWidth: 1)
                )
                .cornerRadius(40)
                .overlay(
                  Text(chat.lastSendTime ?? "")
                    .foregroundColor(Color("text3"))
                    .font(.system(size: 10.sp))
                    .offset(x: -16.w, y: 10.h), alignment: .topTrailing
                )
                .onTapGesture {
                  router.leepyPath.append(
                    WwaQhwoEkuMainRoute.wfueZroFsmnPrimary(
                      url: URL(
                        string:
                          "http://192.168.9.129:2025/private-chat?id=\(chat.chatId)"
                      )!
                    ))
                }
              }
            }
          }
        }
        .padding(.horizontal, 20.w)
        .scrollIndicators(.hidden)
      }
    }
    .enableInjection()
  }
}
