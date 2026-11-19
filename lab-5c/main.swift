
import SwiftUI

struct Student: Identifiable {
    var id = UUID()
    var name: String
    var marks: Int
}

struct Course {
    var name: String
    var duration: String
}

@MainActor
class StudentViewModel: ObservableObject {

    @Published var students: [Student] = []
    @Published var course: Course?
    @Published var isLoading = false
    @Published var status = "No data available"

    func fetchData() {
        isLoading = true
        students = []
        course = nil
        status = "Loading data..."

        Task {
            do {
                let result = try await fetchAllData()

                students = result.students
                course = result.course
                status = "Data loaded successfully"

            } catch {
                status = "Unable to load data"
            }

            isLoading = false
        }
    }

    func fetchAllData() async throws -> (students: [Student], course: Course) {

        async let studentData = fetchStudents()
        async let courseData = fetchCourse()

        let students = try await studentData
        let course = try await courseData

        return (students, course)
    }

    func fetchStudents() async throws -> [Student] {
        try await Task.sleep(for: .seconds(3))

        return [
            Student(name: "Santosh Kare", marks: 85),
            Student(name: "Rahul", marks: 90),
            Student(name: "Aman", marks: 78)
        ]
    }

    func fetchCourse() async throws -> Course {
        try await Task.sleep(for: .seconds(2))

        return Course(name: "Swift Programming", duration: "3 Months")
    }
}

struct ContentView: View {

    @StateObject private var viewModel = StudentViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {

                Text("Student Data App")
                    .font(.largeTitle)
                    .bold()

                Text(viewModel.status)
                    .foregroundColor(.secondary)

                if viewModel.isLoading {
                    ProgressView("Fetching Data...")
                }

                if let course = viewModel.course {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Course Details")
                            .font(.headline)

                        Text("Course: \(course.name)")
                        Text("Duration: \(course.duration)")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.gray.opacity(0.15))
                    .cornerRadius(10)
                }

                List(viewModel.students) { student in
                    VStack(alignment: .leading) {
                        Text(student.name)
                            .font(.headline)

                        Text("Marks: \(student.marks)")
                            .foregroundColor(.secondary)
                    }
                }

                Button("Fetch Student Data") {
                    viewModel.fetchData()
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.isLoading)
            }
            .padding()
            .navigationTitle("Task Groups")
        }
    }
}

#Preview {
    ContentView()
}