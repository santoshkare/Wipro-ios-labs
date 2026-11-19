import UIKit

struct TodoItem {
    let id = UUID()
    var title: String
    var isDone = false
}

class TodoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var todos: [TodoItem] = []
    var showOnlyPending = false

    let tableView = UITableView()
    let textField = UITextField()
    let addButton = UIButton(type: .system)
    let filterButton = UIButton(type: .system)

    var visibleTodos: [TodoItem] {
        if showOnlyPending {
            return todos.filter { !$0.isDone }
        }
        return todos
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tasks (MVC)"
        view.backgroundColor = .white

        textField.placeholder = "New task"
        textField.borderStyle = .roundedRect

        addButton.setTitle("Add", for: .normal)
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)

        filterButton.setTitle("Show Pending", for: .normal)
        filterButton.addTarget(self, action: #selector(filterTapped), for: .touchUpInside)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        let topRow = UIStackView(arrangedSubviews: [textField, addButton])
        topRow.spacing = 10

        topRow.translatesAutoresizingMaskIntoConstraints = false
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(topRow)
        view.addSubview(filterButton)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            topRow.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            topRow.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            topRow.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            filterButton.topAnchor.constraint(equalTo: topRow.bottomAnchor, constant: 10),
            filterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            tableView.topAnchor.constraint(equalTo: filterButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc func addTapped() {
        let text = (textField.text ?? "").trimmingCharacters(in: .whitespaces)
        if text.isEmpty {
            textField.placeholder = "Task cannot be empty"
            return
        }
        todos.append(TodoItem(title: text))
        textField.text = ""
        textField.placeholder = "New task"
        tableView.reloadData()
    }

    @objc func filterTapped() {
        showOnlyPending.toggle()
        let buttonTitle = showOnlyPending ? "Show All" : "Show Pending"
        filterButton.setTitle(buttonTitle, for: .normal)
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibleTodos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let todo = visibleTodos[indexPath.row]
        cell.textLabel?.text = todo.title
        cell.accessoryType = todo.isDone ? .checkmark : .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tapped = visibleTodos[indexPath.row]
        if let index = todos.firstIndex(where: { $0.id == tapped.id }) {
            todos[index].isDone.toggle()
        }
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let tapped = visibleTodos[indexPath.row]
            todos.removeAll { $0.id == tapped.id }
            tableView.reloadData()
        }
    }
}
import SwiftUI

struct TaskItem: Identifiable {
    let id = UUID()
    var title: String
    var isDone = false
}

enum TaskFilter {
    case all
    case pending
    case completed
}

class TaskViewModel: ObservableObject {

    @Published var tasks: [TaskItem] = []
    @Published var filter: TaskFilter = .all
    @Published var errorMessage = ""

    var visibleTasks: [TaskItem] {
        switch filter {
        case .all:
            return tasks
        case .pending:
            return tasks.filter { !$0.isDone }
        case .completed:
            return tasks.filter { $0.isDone }
        }
    }

    @discardableResult
    func addTask(title: String) -> Bool {
        let trimmed = title.trimmingCharacters(in: .whitespaces)
        if trimmed.isEmpty {
            errorMessage = "Task title cannot be empty"
            return false
        }
        tasks.append(TaskItem(title: trimmed))
        errorMessage = ""
        return true
    }

    func toggle(_ task: TaskItem) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isDone.toggle()
        }
    }

    func delete(at offsets: IndexSet) {
        let idsToDelete = offsets.map { visibleTasks[$0].id }
        tasks.removeAll { idsToDelete.contains($0.id) }
    }
}

struct TaskListView: View {

    @StateObject private var viewModel = TaskViewModel()
    @State private var newTitle = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("New task", text: $newTitle)
                        .textFieldStyle(.roundedBorder)
                    Button("Add") {
                        if viewModel.addTask(title: newTitle) {
                            newTitle = ""
                        }
                    }
                }
                .padding()

                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                }

                Picker("Filter", selection: $viewModel.filter) {
                    Text("All").tag(TaskFilter.all)
                    Text("Pending").tag(TaskFilter.pending)
                    Text("Done").tag(TaskFilter.completed)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                List {
                    ForEach(viewModel.visibleTasks) { task in
                        HStack {
                            Text(task.title)
                            Spacer()
                            if task.isDone {
                                Image(systemName: "checkmark")
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.toggle(task)
                        }
                    }
                    .onDelete { offsets in
                        viewModel.delete(at: offsets)
                    }
                }
            }
            .navigationTitle("Tasks (MVVM)")
        }
    }
}

#Preview {
    TaskListView()
}