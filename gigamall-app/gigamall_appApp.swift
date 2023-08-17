//
//  gigamall_appApp.swift
//  gigamall-app
//
//  Created by FVFH4069Q6L7 on 14/08/2023.
//

import SwiftUI

@main
struct gigamall_appApp: App {
    @State private var showsMain : Bool = false
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                LoginView(showsMain: $showsMain)
                    .offset(x: showsMain ? -1000 : 0)
                MainView()
                    .offset(x: showsMain ? 0 : -1000)
            }
        }
    }
}
