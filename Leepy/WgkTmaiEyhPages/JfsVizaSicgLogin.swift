import SwiftData
import SwiftUI

struct JfsVizaSicgLogin: View {
  enum Field: Hashable {
    case email
    case password
  }
  @State var email: String = ""
  @State var password: String = ""
  @FocusState private var focusedField: Field?
  @EnvironmentObject var router: BtdusvhvDdsRouter
  @State private var isLoading = false
  @EnvironmentObject var appState: RlbHdbTvacState
  @Environment(\.modelContext) private var modelContext
  var body: some View {
    GeometryReader { geometry in
      Image("Assets/leepy_splash_bg").resizable().scaledToFill().ignoresSafeArea()
      VStack(spacing: 0) {
        Spacer().frame(height: 20.h)
        Image("Assets/leepy_signin_title")
          .resizable()
          .scaledToFit()
          .frame(
            width: 136.49.w, height: 55.h)
        Spacer().frame(height: 73.h)
        TextField(
          "", text: $email,
          prompt: Text("Email")
            .foregroundColor(Color("text1").opacity(0.5))
            .font(.system(size: 16.sp)),
        )
        .keyboardType(.emailAddress)
        .textInputAutocapitalization(.never)
        .disableAutocorrection(true)
        .font(.system(size: 16.sp))
        .foregroundColor(.black)
        .padding(.horizontal, 15.w)
        .padding(.vertical, 16.h)
        .padding(.leading, 30.w)
        .overlay(
          Image("Assets/leepy_email_icon").resizable().scaledToFit().frame(
            width: 24.w, height: 24.h
          ).padding(.leading, 10.w), alignment: .leading
        )
        .background(
          RoundedRectangle(cornerRadius: 20).fill(
            .white)
        )
        .overlay(
          RoundedRectangle(cornerRadius: 20)
            .stroke(Color.black, lineWidth: 1)
        )
        .focused($focusedField, equals: .email)
        .submitLabel(.next)
        .onSubmit {
          focusedField = .password
        }
        Spacer().frame(height: 24.h)
        SecureField(
          "", text: $password,
          prompt: Text("Password")
            .foregroundColor(Color("text1").opacity(0.5))
            .font(.system(size: 16.sp)),
        )
        .textInputAutocapitalization(.never)
        .disableAutocorrection(true)
        .font(.system(size: 16.sp))
        .foregroundColor(.black)
        .padding(.horizontal, 15.w)
        .padding(.vertical, 16.h)
        .padding(.leading, 30.w)
        .overlay(
          Image("Assets/leepy_password_icon").resizable().scaledToFit().frame(
            width: 24.w, height: 24.h
          ).padding(.leading, 10.w), alignment: .leading
        )
        .background(
          RoundedRectangle(cornerRadius: 20).fill(
            .white)
        )
        .overlay(
          RoundedRectangle(cornerRadius: 20)
            .stroke(Color.black, lineWidth: 1)
        )
        .focused($focusedField, equals: .password)
        .submitLabel(.done)
        .onSubmit {
          focusedField = nil
        }
        Spacer()
        Button(action: {
          guard !email.isEmpty, !password.isEmpty, !isLoading else { return }
          isLoading = true
          Task {
            defer {
              isLoading = false
            }
            do {
              try await Task.sleep(for: .milliseconds(613))
              let descriptor = FetchDescriptor<UserModel>(
                predicate: #Predicate { $0.email == email }
              )
              let user = try modelContext.fetch(descriptor).first
              await MainActor.run {
                guard let user = user else {
                  DwoaInlQetuToast.shared.bvjcbnhjvckvrf(
                    "Invalid email or password. Please try again.")
                  return
                }
                appState.wfzqCubCpmUser = user
                appState.vkyeFxuEaaPhase = .dfsizvhbfdsvrMain
              }
            } catch {
              await MainActor.run {
                DwoaInlQetuToast.shared.bvjcbnhjvckvrf(
                  "Invalid email or password. Please try again.")
              }
            }
          }
        }) {
          if isLoading {
            ProgressView()
              .progressViewStyle(CircularProgressViewStyle(tint: Color("text1")))
              .frame(maxWidth: .infinity)
          } else {
            Text("Sign in")
              .foregroundColor(Color("text1"))
              .font(.system(size: 20.sp, weight: .bold))
              .frame(maxWidth: .infinity)
          }
        }
        .frame(height: 62.h)
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
        Spacer()
      }
      .padding(.horizontal, 30.w)
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button {
          router.leepyPath.removeLast()
        } label: {
          Image("Assets/leepy_back")
            .resizable()
            .scaledToFit()
            .frame(width: 40.r, height: 40.r)
        }
      }
    }
    .navigationBarBackButtonHidden(true)
    .enableSwipeBack()
  }
}
