//
//  LoginView.swift
//  MyTodoList
//
//  Created by Lucas Newlands on 26/11/24.
//

import SwiftUI

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
                    .frame(maxWidth: .infinity)
                    .padding()
                    
                    Text("O seu app de notas com temática da série Game of Thrones.")
                        .foregroundColor(.gray)
                        .fontWeight(.medium)
                }
                .frame(maxHeight: .infinity)
                

                Button {
                    print("clicou para logar!")
                } label: {
                    Text("Acessar sua conta")
                        .fontWeight(.medium)
                        .padding(.vertical, 15)
                        .frame(maxWidth: 200)
                        .padding(.horizontal, 65)
                        .background(Color(.label))
                        .foregroundColor(Color(.systemBackground))
                        .border(Color(.label), width: 1)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(.label), lineWidth: 1)
                    )
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
