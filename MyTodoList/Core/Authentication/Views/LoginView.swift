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
    var body: some View {
        VStack(spacing: 100) {
            Image("dragon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80)
            
            //MARK: - Title and SubTitle Label's
            
            VStack(spacing: 100) {
                
                VStack {
                    HStack {
                        Text("Minhas Notas\nTodo App")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    
                    HStack {
                        Text("O seu app de notas.")
                            .foregroundColor(.gray)
                            .fontWeight(.medium)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    
                }
                .frame(maxHeight: .infinity)
                
                
                Button {
                    guard let clientID = FirebaseApp.app()?.options.clientID else { return }

                    let config = GIDConfiguration(clientID: clientID)
                    GIDSignIn.sharedInstance.configuration = config

                    // Start the sign in flow!
                    GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { result, error in
                      guard error == nil else {
                        return
                      }

                      guard let user = result?.user,
                        let idToken = user.idToken?.tokenString
                      else {
                          return
                      }

                      let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                     accessToken: user.accessToken.tokenString)

                        Auth.auth().signIn(with: credential) { result, error in
                            guard error == nil else {
                            // MARK: - Manage Error
                                //
                                return
                            }
                            print("logado!")
                            UserDefaults.standard.set(true, forKey: "signIn")
                        }
                    }
                } label: {
                    HStack(spacing: 10) { // Ajuste o espaçamento entre a imagem e o texto
                        Image("Google")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24) // Tamanho ajustado para ícone
                            .padding(.leading, 0) // Adiciona espaço interno à esquerda
                        
                        Text("Fazer login com o Google")
                            .fontWeight(.medium)
                            .foregroundColor(Color(.systemBackground)) // Cor do texto
                            .padding(.vertical, 15)
                            .frame(maxWidth: .infinity, alignment: .center) // Garante alinhamento central
                    }
                    .padding(.horizontal, 55)
                    .background(Color(.label))
                    .cornerRadius(12)
                }
            }

            Spacer()
                        
            HStack(alignment: .center, spacing: 5) {
                Text("Ainda não tem uma conta?")
                
                Button {
                    print("criar conta")
                } label: {
                    Text("Crie sua conta")
                        .foregroundColor(.cyan)
                }

                Spacer()
            }
            .font(.footnote)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .foregroundColor(Color(.label))
    }
}

#Preview {
    LoginView()
}
