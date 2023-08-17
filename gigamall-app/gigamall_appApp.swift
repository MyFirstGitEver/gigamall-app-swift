//
//  gigamall_appApp.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 14/08/2023.
//

import SwiftUI

@main
struct gigamall_appApp: App {
    @State private var user : UserEntity? = nil
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                LoginView(user: $user)
                    .offset(x: user != nil ? -1000 : 0)
                MainView(myUser: user ?? UserEntity())
                    .offset(x: user != nil ? 0 : -1000)
            }
        }
    }
}
