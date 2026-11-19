
import SwiftUI

struct Student: Identifiable {
    var id = UUID()
    var name: String
    var course: String
}

struct ContentView: View {

    @State private var students: [Student] = []
    @State private var searchText = ""
    @State private var filteredStudents: [Student] = []

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search Student", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding()

                if filteredStudents.isEmpty {
                    Text("No students found")
                        .foregroundColor(.secondary)
                } else {
                    List(filteredStudents) { student in
                        VStack(alignment: .leading) {
                            Text(student.name)
                                .font(.headline)

                            Text(student.course)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Student Directory")
            .task {
                if students.isEmpty {
                    loadStudents()
                    filteredStudents = students
                }
            }
            .task(id: searchText) {
                let currentText = searchText

                try? await Task.sleep(for: .milliseconds(300))

                if Task.isCancelled {
                    return
                }

                if currentText.isEmpty {
                    filteredStudents = students
                } else {
                    filteredStudents = students.filter {
                        $0.name.localizedCaseInsensitiveContains(currentText) ||
                        $0.course.localizedCaseInsensitiveContains(currentText)
                    }
                }
            }
        }
    }

    func loadStudents() {
        for number in 1...1000 {
            let student = Student(
                name: "Student \(number)",
                course: number % 2 == 0 ? "Computer Science" : "Information Technology"
            )

            students.append(student)
        }
    }
}

#Preview {
    ContentView()
}