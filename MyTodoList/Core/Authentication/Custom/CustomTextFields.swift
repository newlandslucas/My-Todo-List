//
//  CustomTextFields.swift
//  MyTodoList
//
//  Created by Lucas Newlands on 26/11/24.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    @Binding var isValid: Bool
    @Binding var fieldTapped: Bool
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(Color(.lightGray))
                        .padding(.horizontal, 2)
                }
                
                TextField("", text: $text)
                    .foregroundColor(Color(.label))
                    .font(.subheadline)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 2)
                    .overlay(Rectangle().frame(height: 1)
                        .foregroundColor(text.isEmpty ? Color(.darkGray) : Color(.label)),
                             alignment: .bottom)
                    .onTapGesture {
                        fieldTapped = true
                    }
                    .keyboardType(.emailAddress)
            }
            
            // Ícone de validação
            if fieldTapped {
                if isValid && !text.isEmpty {
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.green)
                } else if !isValid && !text.isEmpty {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.red)
                }
            }
        }
        .padding(.horizontal, 10)
    }
}

struct CustomSecureField: View {
    var placeholder: String
    @Binding var text: String
    @Binding var isValid: Bool
    @Binding var fieldTapped: Bool
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(Color(.lightGray))
                        .padding(.horizontal, 2)
                }
                
                SecureField("", text: $text)
                    .foregroundColor(Color(.label))
                    .font(.subheadline)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 2)
                    .overlay(Rectangle().frame(height: 1)
                                .foregroundColor(text.isEmpty ? Color(.darkGray) :Color(.label)),
                             alignment: .bottom)
                    .onTapGesture {
                        fieldTapped = true
                    }
            }
            
            // Ícone de validação
            if fieldTapped {
                if text.count >= 8 {
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.green)
                } else if !text.isEmpty {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.red)
                }
            }
        }
        .padding(.horizontal, 10)
    }
}
