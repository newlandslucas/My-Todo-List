//
//  ContentView.swift
//  MyTodoList
//
//  Created by Lucas Newlands on 26/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Ajustes")
            }
        }
        .accentColor(Color(.label))
    }
}

#Preview {
    ContentView()
}
