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
            Text("SettingsView")
                .tabItem {
                    Image(systemName: "person")
                    Text("Ajustes")
            }
        }
        .accentColor(.black)
    }
}

#Preview {
    ContentView()
}
