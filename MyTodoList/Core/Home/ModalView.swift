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
            }
            
            TextField("Escreva sua nota...", text: $newTask)
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
            
            // Botão "Salvar"
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
            .disabled(newTask.isEmpty)  // Desabilita o botão quando o campo de texto estiver vazio
            
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
        // Alerta só será exibido quando o botão "Salvar" for clicado e o campo estiver vazio
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

