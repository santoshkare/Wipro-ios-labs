
import SwiftUI

struct Course: Identifiable {
    var id = UUID()
    var name: String
}

@MainActor
class CourseViewModel: ObservableObject {

    @Published var courses: [Course] = []
    @Published var isLoading = false
    @Published var status = "No data available"
    @Published var errorMessage = ""

    var fetchTask: Task<Void, Never>?

    func fetchCourses() {
        fetchTask?.cancel()

        fetchTask = Task {
            isLoading = true
            courses = []
            errorMessage = ""
            status = "Loading courses..."

            do {
                let result = try await getCourses()

                try Task.checkCancellation()

                if result.isEmpty {
                    status = "No courses found"
                } else {
                    courses = result
                    status = "Courses loaded successfully"
                }

            } catch is CancellationError {
                status = "Fetching cancelled"
            } catch {
                errorMessage = error.localizedDescription
                status = "Failed to load courses"
            }

            isLoading = false
        }
    }

    func getCourses() async throws -> [Course] {
        try await Task.sleep(for: .seconds(3))
        try Task.checkCancellation()

        return [
            Course(name: "Swift Programming"),
            Course(name: "iOS Development"),
            Course(name: "Data Structures"),
            Course(name: "Database Management")
        ]
    }

    func cancelFetching() {
        fetchTask?.cancel()
    }

    func reset() {
        fetchTask?.cancel()
        courses = []
        errorMessage = ""
        status = "No data available"
        isLoading = false
    }
}

struct ContentView: View {

    @StateObject private var viewModel = CourseViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {

                Text("Course Fetching App")
                    .font(.largeTitle)
                    .bold()

                Text(viewModel.status)
                    .foregroundColor(.secondary)

                if viewModel.isLoading {
                    ProgressView("Fetching Courses...")
                }

                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                }

                List(viewModel.courses) { course in
                    Text(course.name)
                }

                Button("Fetch Courses") {
                    viewModel.fetchCourses()
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.isLoading)

                Button("Cancel Fetching") {
                    viewModel.cancelFetching()
                }
                .buttonStyle(.bordered)
                .disabled(!viewModel.isLoading)

                Button("Reset") {
                    viewModel.reset()
                }
                .foregroundColor(.red)
            }
            .padding()
            .navigationTitle("Async/Await")
        }
    }
}

#Preview {
    ContentView()
}