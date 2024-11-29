//
//  LoginView.swift
//  MyTodoList
//
//  Created by Lucas Newlands on 26/11/24.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn
import Firebase

struct LoginView: View {
    // Estado para controlar o texto do título
    @State private var titleText = ""
    private let fullTitle = "My-Todo App"
    
    var body: some View {
        
        HStack {
            Image(systemName: "pencil.and.list.clipboard")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 35, height: 35)
        }
        
        Spacer()
        
        VStack {
            // Animação do título
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(titleText)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .onAppear {
                            startTypingAnimation()
                        }

                    Text("O seu app de notas diário.")
                }

                Spacer()
            }
            
            Spacer()

            // Botão de login
            Button {
                FireAuth.share.signInWithGoogle(presenting: getRootViewController()) { error in
                    print("Error: \(error)")
                }
            } label: {
                HStack(spacing: 10) {
                    Image("Google")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)

                    Text("Fazer login com o Google")
                        .fontWeight(.medium)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.horizontal, 55)
                .background(Color(.systemBackground))
                .foregroundColor(Color(.label))
                .border(Color(.label))
                .overlay(
                    RoundedRectangle(cornerRadius: 12) // Borda arredondada
                        .stroke(Color(.label), lineWidth: 1) // Cor e largura da borda
                )
                .cornerRadius(12)
            }

            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .foregroundColor(Color(.label))
    }
    
    // Função para iniciar a animação em loop
    private func startTypingAnimation() {
        titleText = ""
        for (index, letter) in fullTitle.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.1) {
                withAnimation {
                    titleText.append(letter)
                }
            }
        }
        
        let totalDuration = Double(fullTitle.count) * 0.3 + 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + totalDuration) {
            startTypingAnimation()
        }
    }
}

#Preview {
    LoginView()
}
