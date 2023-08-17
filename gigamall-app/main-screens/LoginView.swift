//
//  LoginView.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 14/08/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var userName = ""
    @State private var password = ""
    @State private var warningText = ""
    @State private var showsLogo = false
    @State private var showsRegistrationView = false
    
    @Binding var user : UserEntity?
    
    var body: some View {
        NavigationStack {
            ZStack {
                topDisplay
                loginTextFields
                registerArea
                warningDialog
            }.ignoresSafeArea(.keyboard)
        }
    }
    
    var warningDialog : some View {
        VStack {
            Text("Thông báo")
                .bold()
                .foregroundColor(.blue)
                .font(.system(size: 25))
                .padding([.bottom], 15)
            Spacer()
            Text(warningText)
                .multilineTextAlignment(.center)
            Spacer()
            Button(action: {
                withAnimation(.spring()) {
                    warningText = ""
                }
            }) {
                Text("OK")
            }
        }
        .frame(maxHeight: 150)
        .padding([.horizontal], 20)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 5)
        .offset(y: warningText != ""
                ? 0 : 1000)
    }
    
    var registerArea : some View {
        VStack {
            Spacer()
            Button(action: {
                showsRegistrationView = true
            }) {
                Text("Chưa có tài khoản?")
                    .padding([.top], 15)
                    .foregroundColor(.red)
                    .font(.system(size: 25))
            }.navigationDestination(
                isPresented: $showsRegistrationView) {
                    RegisterView()
                }
        }
    }
    
    var loginTextFields : some View {
        VStack {
            buildLoginTextField(
                title: "Tài khoản",
                binder: $userName)
            .padding([.horizontal], 60)
            .padding([.bottom], 60)
            
            buildSecureField(
                title: "Mật khẩu",
                binder: $password)
            .padding([.horizontal], 60)
            
            Button(action: {
                withAnimation(.spring()) {
                    UserAPICaller.instance.login(
                        userName: userName,
                        password: password) { result in
                            processLoginResult(result: result)
                        }
                }
            }) {
            Text("Đăng nhập")
                    .padding([.top], 25)
                    .font(.system(size: 24))
                    .bold()
            }
        }
    }
    
    var topDisplay : some View {
        VStack {
            Image("gigamall")
                .resizable()
                .frame(maxWidth: 100, maxHeight: 100)
            Text("Gigamall")
                .bold()
                .foregroundColor(.orange)
                .font(.system(size: 30))
                .padding([.top], 30)
            Spacer()
        }
        .opacity(showsLogo ? 1 : 0)
        .offset(y: showsLogo ? 0 : -100)
        .onAppear {
            withAnimation(.spring()) {
                showsLogo = true
            }
        }
    }
    
    func buildSecureField(title: String, binder : Binding<String>) -> some View {
        SecureField(title, text: binder)
            .padding(15)
            .overlay(
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(.blue, lineWidth: 2)
                    HStack {
                        Spacer()
                        Image(systemName: "lock.circle.fill")
                            .resizable()
                            .frame(maxWidth: 30, maxHeight: 30)
                            .padding([.trailing], 10)
                            .foregroundColor(.blue)
                    }
                })
    }
    
    func buildLoginTextField(title: String, binder: Binding<String>) -> some View{
        TextField(title, text: binder)
            .padding(15)
            .overlay(
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(.blue, lineWidth: 2)
                    HStack {
                        Spacer()
                        Image(systemName: "lock.circle.fill")
                            .resizable()
                            .frame(maxWidth: 30, maxHeight: 30)
                            .padding([.trailing], 10)
                            .foregroundColor(.blue)
                    }
                })
    }
    
    func processLoginResult(result :Result<UserEntity, Error>) {
        do {
            let loggedInUser = try result.get()
            
            withAnimation(.spring()) {
                self.user = loggedInUser
            }
        }
        catch let err {
            withAnimation(.spring()) {
                switch err {
                case UserAPICallerError.CONNECTION_FAILED:
                    warningText = "Không thể kết nối! Vui lòng kiểm tra lại kết nối mạng"
                case UserAPICallerError.LOGIN_FAILED:
                    warningText = "Sai mật khẩu hoặc tài khoản!"
                default:
                    warningText = "Lỗi của ứng dụng! Vui lòng thử lại!"
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(user: .constant(nil))
    }
}
