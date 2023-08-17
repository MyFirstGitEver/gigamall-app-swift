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
    
    @State private var showsLogo = false
    @State private var showsRegistrationView = false
    
    @Binding var showsMain : Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
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
                            showsMain = true
                        }
                    }) {
                    Text("Đăng nhập")
                            .padding([.top], 25)
                            .font(.system(size: 24))
                            .bold()
                    }
                }
                
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
            }.ignoresSafeArea(.keyboard)
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
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(showsMain: .constant(true))
    }
}
