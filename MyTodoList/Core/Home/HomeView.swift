//
//  HomeView.swift
//  MyTodoList
//
//  Created by Lucas Newlands on 26/11/24.
//

import SwiftUI

// Modelo para cada item da lista
struct TodoItem: Identifiable {
    var id = UUID()
    var task: String
    var priority: String // Prioridade da tarefa
    var isCompleted: Bool = false
}

struct HomeView: View {
    @State private var newTask: String = "" // Texto da nova tarefa
    @State private var newPriority: String = "Tranquilo" // Prioridade da nova tarefa
    @State private var todoItems: [TodoItem] = [] // Lista de tarefas
    @State private var showModal: Bool = false // Controle de exibição do modal
    
    var body: some View {
        NavigationView {
            VStack {
                
                HStack {
                    Text("Minha Lista de\nTarefas")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                .padding()
                
                // Lista de tarefas
                List {
                    ForEach(todoItems) { item in
                        HStack {
                            // Barra colorida à esquerda
                            Rectangle()
                                .fill(priorityColor(for: item.priority)) // Cor da barra de prioridade
                                .frame(width: 5) // Largura da barra
                                .cornerRadius(5)
                            
                            VStack(alignment: .leading) {
                                Text(item.task)
                                    .strikethrough(item.isCompleted, color: .gray)
                                    .foregroundColor(item.isCompleted ? .gray : .black)
                                
                                Text("Prioridade: \(item.priority)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 8) // Distância vertical interna
                            .padding(.horizontal, 16) // Distância das laterais
                            
                            Spacer()
                            
                            // Botão para marcar como concluído
                            Button(action: {
                                toggleCompletion(for: item)
                            }) {
                                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(item.isCompleted ? .green : .blue)
                            }
                        }
                        .frame(height: 50) // Ajusta a altura da tarefa
                        .padding(.horizontal, 15) // Distância das laterais
                        .cornerRadius(18)
                    }
                    .onDelete(perform: deleteItem)
                }
                .listStyle(PlainListStyle())
                .padding(.top)
                
            }
            .navigationBarItems(trailing: EditButton())
            .overlay(
                Button(action: {
                    showModal = true // Exibir o modal
                }) {
                    Image(systemName: "pencil")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(Circle().fill(Color.black))
                        .shadow(radius: 10)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing), alignment: .bottomTrailing
            )
            // Modal para adicionar nova tarefa
            .sheet(isPresented: $showModal) {
                // Chamando a ModalView
                ModalView(newTask: $newTask, newPriority: $newPriority, showModal: $showModal) { task, priority in
                    addTask(task: task, priority: priority) // Adiciona a tarefa e fecha o modal
                }
            }
        }
    }
    
    // Função para adicionar uma nova tarefa
    func addTask(task: String, priority: String) {
        guard !task.isEmpty else { return }
        let newTodoItem = TodoItem(task: task, priority: priority)
        todoItems.append(newTodoItem)
        newTask = "" // Limpa o campo de texto após adicionar
    }
    
    // Função para excluir uma tarefa
    func deleteItem(at offsets: IndexSet) {
        todoItems.remove(atOffsets: offsets)
    }
    
    // Função para alternar o status de conclusão da tarefa
    func toggleCompletion(for item: TodoItem) {
        if let index = todoItems.firstIndex(where: { $0.id == item.id }) {
            todoItems[index].isCompleted.toggle()
        }
    }
    
    // Função para determinar a cor da barra de prioridade com base no nível
    private func priorityColor(for priority: String) -> Color {
        switch priority {
        case "Médio":
            return Color.yellow
        case "Requer Atenção":
            return Color.red
        default:
            return Color.green
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
