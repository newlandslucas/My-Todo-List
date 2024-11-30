//
//  ModalView.swift
//  MyTodoList
//
//  Created by Lucas Newlands on 26/11/24.
//

import SwiftUI

struct ModalView: View {
    @Binding var newTask: String
    @Binding var newPriority: String
    @Binding var showModal: Bool
    var addTask: (String, String) -> Void
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Nova Tarefa")
                    .font(.title)
                    .padding(.top, 20)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    showModal = false
                }) {
                    Image(systemName: "x.circle.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            
            TextField("Escreva sua tarefa...", text: $newTask)
                .padding()
                .background(Color.gray.opacity(0.2).cornerRadius(10))
                .foregroundColor(Color(.label))
            
            VStack(alignment: .leading) {
                Text("Prioridade")
                    .font(.headline)
                    .padding(.top, 20)
                
                Picker("Selecione a prioridade", selection: $newPriority) {
                    Text("Baixa").tag("Baixa")
                    Text("Média").tag("Média")
                    Text("Requer Atenção").tag("Requer Atenção")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
            }
            
            Spacer()
            
            if !newTask.isEmpty {
                Button(action: {
                    if newTask.isEmpty {
                        showAlert = true
                    } else {
                        addTask(newTask, newPriority)
                        showModal = false
                    }
                }) {
                    Text("Salvar")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 10)
            }
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Campo obrigatório"),
                message: Text("Por favor, insira uma tarefa antes de salvar."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(newTask: .constant(""), newPriority: .constant("Baixa"), showModal: .constant(true), addTask: { _, _ in })
    }
}
