//
//  ProfileView.swift
//  MyTodoList
//
//  Created by Lucas Newlands on 27/11/24.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn
import Firebase

struct ProfileView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Perfil")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            Spacer()
            
            VStack(spacing: 15) {
                
                HStack {
                    
                    Button {
                        FireAuth.share.SignOut(presenting: getRootViewController()) { error in
                            print("Error: \(error)")
                        }
                    } label: {
                        Text("Sair do app")
                        
                        Spacer()
                        
                        Image(systemName: "door.left.hand.open")
                            .font(.system(size: 25))

                    }
                    .foregroundColor(.red)
                    }


                Divider()
            }
            
            Spacer()
            Spacer()
            Spacer()

        }
        .padding()
    }
}

#Preview {
    ProfileView()
}
