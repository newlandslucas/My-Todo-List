//
//  RegistrationView.swift
//  MyTodoList
//
//  Created by Lucas Newlands on 26/11/24.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email: String = ""
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
    @State private var isEmailValid: Bool = false
    @State private var isPasswordValid: Bool = false
    @State private var isNameValid: Bool = false
    @State private var emailTapped: Bool = false
    @State private var passwordTapped: Bool = false
    @State private var nameTapped: Bool = false

    var body: some View {
        VStack(spacing: 100) {
            VStack {
                HStack {
                    Text("Crie sua\nconta.")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.top, 100)
                
                Spacer()
                
                VStack(spacing: 20) {
                    // Campo de email com ícone de validação
                    CustomTextField(placeholder: "Insira seu email", text: $email, isValid: $isEmailValid, fieldTapped: $emailTapped)
                        .onChange(of: email) { newValue in
                            isEmailValid = isValidEmail(email)
                        }
                    
                    // Campo de nome com ícone de validação
                    CustomTextField(placeholder: "Insira seu nome", text: $name, isValid: $isNameValid, fieldTapped: $nameTapped)
                        .onChange(of: name) { newValue in
                            isNameValid = !name.isEmpty
                        }
                    
                    // Campo de senha com ícone de validação
                    CustomSecureField(placeholder: "Insira sua senha", text: $password, isValid: $isPasswordValid, fieldTapped: $passwordTapped)
                        .onChange(of: password) { newValue in
                            isPasswordValid = password.count >= 8
                        }
                }
                
                Spacer()
                
                if areFieldsFilled() {
                    Button {
                        if isEmailValid && isPasswordValid && isNameValid {
                            print("Conta criada com sucesso!")
                        } else {
                            alertMessage = "Verifique se todos os campos estão preenchidos corretamente."
                            showAlert = true
                        }
                    } label: {
                        Text("Criar conta")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .frame(width: 350, height: 44)
                            .background(.white)
                            .cornerRadius(15)
                    }
                    .padding(.bottom, 20)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Erro"),
                            message: Text(alertMessage),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                }
                
                Spacer()
            }
            
            Spacer()
        }
        .padding()
        .background(Color.black)
    }
    
    private func areFieldsFilled() -> Bool {
        return !email.isEmpty && !password.isEmpty && !name.isEmpty
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
}

#Preview {
    RegistrationView()
}
