//
//  AcessView.swift
//  MyTodoList
//
//  Created by Lucas Newlands on 26/11/24.
//

import SwiftUI

struct AcessView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isEmailValid: Bool = false
    @State private var isPasswordValid: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Acesse sua\nConta.")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(Color(.label))
                
                Spacer()
            }
            .padding()
            .padding(.top, 120)
            
            Spacer()

            VStack(spacing: 20){
                CustomTextField(placeholder: "Insira seu email",
                                text: $email,
                                isValid: $isEmailValid,
                                fieldTapped: .constant(!email.isEmpty))
                    .onChange(of: email) { newValue in
                        isEmailValid = isValidEmail(newValue)
                    }

                // Campo de Senha
                CustomSecureField(placeholder: "Insira sua senha",
                                  text: $password,
                                  isValid: $isPasswordValid,
                                  fieldTapped: .constant(!password.isEmpty))
                    .onChange(of: password) { newValue in
                        isPasswordValid = newValue.count >= 8
                    }
            }
            .padding(.bottom, 45)


            Button(action: {
                if isEmailValid && isPasswordValid {
                    print("Login realizado com sucesso!")
                } else {
                    alertMessage = "Por favor, insira um email válido e uma senha com pelo menos 8 dígitos."
                    showAlert = true
                }
            }) {
                Text("Login")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.systemBackground))
                    .frame(width: 350, height: 44)
                    .background(Color(.label))
                    .cornerRadius(15)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Erro"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            
            Button {
                print("ainda não tem conta")
            } label: {
                Text("Ainda não tem conta?")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.label))
                    .frame(width: 350, height: 44)
                    .border(Color(.systemBackground), width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color(.systemBackground), lineWidth: 1)
                    )
            }

            
            Spacer()

        }
        .padding()
        .edgesIgnoringSafeArea(.all)
        

    }
    
    
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
}

#Preview {
    AcessView()
}
