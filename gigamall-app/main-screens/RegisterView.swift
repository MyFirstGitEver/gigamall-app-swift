//
//  RegisterView.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 15/08/2023.
//

import SwiftUI

struct RegisterView: View {
    @State private var userName = ""
    @State private var password = ""
    @State private var retype = ""
    @State private var gmail = ""
    
    @State private var showsConfirmationView : Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Text("Đăng ký ngay để trải nghiệm dịch vụ mua sắm tiết kiệm và tiện lợi!")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.red)
                        .padding([.top], 20)
                    Image("gigamall")
                        .resizable()
                        .frame(maxWidth: 100, maxHeight: 100)
                    Spacer()
                }
                
                form
                
                
                VStack {
                    Spacer()
                    Button(action: {
                        showsConfirmationView = true
                    }) {
                        Text("Hoàn tất")
                            .font(.system(size: 20))
                            .bold()
                    }
                    .navigationDestination(isPresented: $showsConfirmationView) {
                        ConfirmationView(gmail: gmail)
                    }
                }
            }
            .ignoresSafeArea(.keyboard)
            .navigationBarBackButtonHidden(true)
        }
    }
    
    var form: some View {
        VStack {
            buildRegisterTextField(
                title: "Tên đăng nhập",
                binder: $userName)
            .padding(20)
            
            buildSecureField(
                title: "Mật khẩu",
                binder: $password)
            .padding(20)
            
            buildSecureField(
                title: "Nhập lại mật khẩu",
                binder: $retype)
            .padding(20)
            
            buildRegisterTextField(
                title: "Email xác nhận",
                binder: $gmail)
            .padding(20)
            
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.backward.circle.fill")
                    .resizable()
                    .frame(maxWidth: 30, maxHeight: 30)
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

    
    func buildRegisterTextField(title: String, binder: Binding<String>) -> some View{
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
                }
            )
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
