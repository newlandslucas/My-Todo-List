//
//  SignIn.swift
//  MyTodoList
//
//  Created by Lucas Newlands on 29/11/24.
//

import SwiftUI

@main
struct SignIn: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage("signIn") var isSignIn = false
    
    var body: some Scene {
        WindowGroup {
            if !isSignIn {
                LoginView()
            } else {
                HomeView()
            }
        }
    }
}
