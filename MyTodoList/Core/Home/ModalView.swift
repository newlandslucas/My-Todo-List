//
//  ModalView.swift
//  MyTodoList
//
//  Created by Lucas Newlands on 26/11/24.
//

import SwiftUI

struct ModalView: View {
    @Binding var newTask: String
    @Binding var newPriority: String // Prioridade da nova tarefa
    @Binding var showModal: Bool
    var addTask: (String, String) -> Void  // Função para adicionar a tarefa com prioridade
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Nova Tarefa")
                    .font(.title)
                    .padding(.top, 20)
                    .fontWeight(.bold)
                
                Spacer()
                
                // Ícone de "X" para fechar o modal
                Button(action: {
                    showModal = false // Fecha o modal
                }) {
                    Image(systemName: "x.circle.fill") // Ícone de "X"
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            
            TextField("Escreva sua tarefa...", text: $newTask)
                .padding()
                .background(Color.gray.opacity(0.2).cornerRadius(10))
                .foregroundColor(.black)
            
            // Seletor de prioridade
            VStack(alignment: .leading) {
                Text("Prioridade")
                    .font(.headline)
                    .padding(.top, 20)
                
                Picker("Selecione a prioridade", selection: $newPriority) {
                    Text("Baixa").tag("Baixa")
                    Text("Média").tag("Média")
                    Text("Requer Atenção").tag("Requer Atenção")
                }
                .pickerStyle(SegmentedPickerStyle()) // Estilo de picker segmentado
                .padding(.horizontal)
            }
            
            Spacer()
            
            // Mostrar o botão "Salvar" somente se newTask não estiver vazio
            if !newTask.isEmpty {
                Button(action: {
                    if newTask.isEmpty {
                        showAlert = true // Se o campo de tarefa estiver vazio, exibe o alerta
                    } else {
                        addTask(newTask, newPriority)  // Chama a função de adicionar a tarefa com prioridade
                        showModal = false // Fecha o modal
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


