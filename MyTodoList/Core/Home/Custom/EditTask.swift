//
//  EditTask.swift
//  MyTodoList
//
//  Created by Lucas Newlands on 29/11/24.
//

import SwiftUI

struct EditTaskView: View {
    @Binding var task: String // Binding para o texto da tarefa
    @Binding var priority: String // Binding para a prioridade da tarefa
    @Binding var showEditModal: Bool // Controle para fechar o modal de edição
    var onDelete: () -> Void // Closure para deletar a tarefa
    
    var body: some View {
        VStack {
            HStack {
                Text("Editar Tarefa")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                // Botão para fechar o modal
                Button(action: {
                    showEditModal = false
                }) {
                    Image(systemName: "x.circle.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 20)
            
            // Campo para editar o texto da tarefa
            TextField("Escreva sua tarefa...", text: $task)
                .padding()
                .background(Color.gray.opacity(0.2).cornerRadius(10))
                .foregroundColor(.black)
            
            // Seletor de prioridade
            VStack(alignment: .leading) {
                Text("Prioridade")
                    .font(.headline)
                    .padding(.top, 20)
                
                Picker("Selecione a prioridade", selection: $priority) {
                    Text("Baixa").tag("Baixa")
                    Text("Média").tag("Média")
                    Text("Requer Atenção").tag("Requer Atenção")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
            }
            
            Spacer()
            
            // Botão "Salvar"
            Button(action: {
                showEditModal = false // Fecha o modal ao salvar
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
            
            // Botão "Excluir Tarefa"
            Button(action: {
                onDelete() // Chama a função de deletar a tarefa
                showEditModal = false // Fecha o modal
            }) {
                Text("Excluir Tarefa")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(8)
            }
            .padding(.horizontal, 10)
            .padding(.top, 10)
        }
        .padding()
    }
}
