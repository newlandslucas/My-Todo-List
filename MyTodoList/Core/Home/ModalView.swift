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
    
    var body: some View {
        VStack {
            HStack {
                Text("Nova Tarefa")
                    .font(.title)
                    .padding(.top, 20)
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            Spacer()
            
            // Campo de texto para digitar a tarefa
            TextField("Digite a tarefa", text: $newTask)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .frame(height: 50)
            
            // Seletor de prioridade
            VStack(alignment: .leading) {
                Text("Prioridade")
                    .font(.headline)
                    .padding(.top, 20)
                
                Picker("Selecione a prioridade", selection: $newPriority) {
                    Text("Tranquilo").tag("Tranquilo")
                    Text("Médio").tag("Médio")
                    Text("Requer Atenção").tag("Requer Atenção")
                }
                .pickerStyle(SegmentedPickerStyle()) // Estilo de picker segmentado
                .padding(.horizontal)
            }
            
            Spacer()
            
            // Botão "Salvar"
            Button(action: {
                addTask(newTask, newPriority)  // Chama a função de adicionar a tarefa com prioridade
                showModal = false // Fecha o modal
            }) {
                Text("Salvar")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.horizontal, 10)
                        
            // Botão "Cancelar"
            Button(action: {
                showModal = false // Fecha o modal sem salvar
            }) {
                Text("Cancelar")
                    .font(.headline)
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
            .padding(.horizontal, 10)
            
        }
        .padding()
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(newTask: .constant(""), newPriority: .constant("Tranquilo"), showModal: .constant(true), addTask: { _, _ in })
    }
}
