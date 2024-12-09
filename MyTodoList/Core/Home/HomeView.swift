//
//  HomeView.swift
//  MyTodoList
//
//  Created by Lucas Newlands on 26/11/24.
//

import SwiftUI

struct TodoItem: Identifiable {
    var id = UUID()
    var task: String
    var priority: String
    var isCompleted: Bool = false
}

struct HomeView: View {
    @State private var newTask: String = ""
    @State private var newPriority: String = "Baixa"
    @State private var todoItems: [TodoItem] = []
    @State private var showModal: Bool = false
    @State private var showEditModal: Bool = false
    @State private var isEditingMode: Bool = false
    @State private var selectedTask: TodoItem = TodoItem(task: "", priority: "")

    private var pendingTasksCount: Int {
        todoItems.filter { !$0.isCompleted }.count
    }

    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 0) {
                    HStack {
                        Text("Minhas Tarefas")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Spacer()

                        Button(action: {
                            withAnimation {
                                isEditingMode.toggle()
                            }
                        }) {
                            Text(isEditingMode ? "Concluído" : "Editar")
                                .foregroundColor(.blue)
                                .fontWeight(.bold)
                        }
                    }
                    .padding()

                    HStack {
                        Text("Tarefas em aberto: \(pendingTasksCount)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                }

                List {
                    ForEach(todoItems) { item in
                        HStack {
                            Rectangle()
                                .fill(priorityColor(for: item.priority))
                                .frame(width: 5)
                                .cornerRadius(5)

                            VStack(alignment: .leading) {
                                Text(item.task)
                                    .strikethrough(item.isCompleted, color: .gray)
                                    .foregroundColor(item.isCompleted ? .gray : Color(.label))
                                
                                Text("Prioridade: \(item.priority)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            
                            Spacer()

                            if isEditingMode {
                                Button(action: {
                                    selectedTask = item
                                    showEditModal = true
                                }) {
                                    Image(systemName: "square.and.pencil")
                                        .foregroundColor(Color(.label))
                                }
                            } else {
                                Button(action: {
                                    toggleCompletion(for: item)
                                }) {
                                    Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(item.isCompleted ? .green : .blue)
                                }
                            }
                        }
                        .frame(height: 50)
                        .padding(.horizontal, 15)
                        .cornerRadius(18)
                    }
                    .onDelete(perform: deleteItem)
                }
                .listStyle(PlainListStyle())
                .padding(.top)
            }
            .overlay(
                Button(action: {
                    withAnimation(.spring().speed(0.5)) {
                        showModal = true
                    }
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 30))
                        .foregroundColor(Color(.systemBackground))
                        .frame(width: 45, height: 45)
                        .background(Circle().fill())
                        .shadow(radius: 10)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing), alignment: .bottomTrailing
            )
            .sheet(isPresented: $showModal) {
                ModalView(newTask: $newTask, newPriority: $newPriority, showModal: $showModal) { task, priority in
                    withAnimation(.easeIn(duration: 0.5)) {
                        addTask(task: task, priority: priority)
                    }
                }
            }
            .sheet(isPresented: $showEditModal, onDismiss: {
                if let index = todoItems.firstIndex(where: { $0.id == selectedTask.id }) {
                    todoItems[index] = selectedTask
                }
            }) {
                EditTaskView(
                    task: $selectedTask.task,
                    priority: $selectedTask.priority,
                    showEditModal: $showEditModal,
                    onDelete: {
                        if let index = todoItems.firstIndex(where: { $0.id == selectedTask.id }) {
                            todoItems.remove(at: index)
                        }
                    }
                )
            }
        }
        .background(Color(.systemBackground))
        .foregroundColor(Color(.label))
    }

    func addTask(task: String, priority: String) {
        guard !task.isEmpty else { return }
        let newTodoItem = TodoItem(task: task, priority: priority)
        todoItems.append(newTodoItem)
        newTask = ""
    }

    func deleteItem(at offsets: IndexSet) {
        withAnimation {
            todoItems.remove(atOffsets: offsets)
        }
    }

    func toggleCompletion(for item: TodoItem) {
        if let index = todoItems.firstIndex(where: { $0.id == item.id }) {
            todoItems[index].isCompleted.toggle()
        }
    }

    private func priorityColor(for priority: String) -> Color {
        switch priority {
        case "Média":
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
        ContentView()
    }
}
