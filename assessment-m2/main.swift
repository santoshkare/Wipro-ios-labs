import SwiftUI

struct DashboardData {
    let courses: [String]
    let notices: [String]
}

enum DashboardError: Error {
    case noticesUnavailable
}

enum DashboardState {
    case idle
    case loading
    case success(DashboardData)
    case error(String)
    case cancelled
}

func fetchCourseList() async throws -> [String] {
    try await Task.sleep(nanoseconds: 2_000_000_000)
    return ["Swift Basics", "iOS Development", "Databases"]
}

func fetchNotices(shouldFail: Bool) async throws -> [String] {
    try await Task.sleep(nanoseconds: 1_000_000_000)
    if shouldFail {
        throw DashboardError.noticesUnavailable
    }
    return ["Lab submission on Friday", "Viva next week"]
}

@MainActor
class DashboardViewModel: ObservableObject {

    @Published var state: DashboardState = .idle
    @Published var simulateError = false
    private var loadTask: Task<Void, Never>?

    var isLoading: Bool {
        if case .loading = state {
            return true
        }
        return false
    }

    func load() {
        if isLoading { return }
        state = .loading
        let failNotices = simulateError

        loadTask = Task {
            do {
                async let courses = fetchCourseList()
                async let notices = fetchNotices(shouldFail: failNotices)

                let courseResult = try await courses
                let noticeResult = try await notices

                state = .success(DashboardData(courses: courseResult, notices: noticeResult))
            } catch is CancellationError {
                state = .cancelled
            } catch {
                state = .error("Could not load the dashboard. Please try again.")
            }
        }
    }

    func cancel() {
        loadTask?.cancel()
    }
}

struct DashboardView: View {

    @StateObject private var viewModel = DashboardViewModel()

    var body: some View {
        VStack(spacing: 16) {
            Text("Dashboard")
                .font(.largeTitle)

            Toggle("Simulate error", isOn: $viewModel.simulateError)
                .disabled(viewModel.isLoading)

            HStack(spacing: 20) {
                Button("Load") {
                    viewModel.load()
                }
                .disabled(viewModel.isLoading)

                Button("Cancel") {
                    viewModel.cancel()
                }
                .disabled(!viewModel.isLoading)
            }

            content

            Spacer()
        }
        .padding()
    }

    @ViewBuilder
    var content: some View {
        switch viewModel.state {
        case .idle:
            Text("Press Load to get data")
        case .loading:
            ProgressView("Loading...")
        case .success(let data):
            List {
                Section("Courses") {
                    ForEach(data.courses, id: \.self) { course in
                        Text(course)
                    }
                }
                Section("Notices") {
                    ForEach(data.notices, id: \.self) { notice in
                        Text(notice)
                    }
                }
            }
        case .error(let message):
            Text(message)
                .foregroundColor(.red)
        case .cancelled:
            Text("Loading was cancelled")
        }
    }
}

#Preview {
    DashboardView()
}