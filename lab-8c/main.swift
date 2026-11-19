
import SwiftUI

struct Course: Identifiable {
    var id = UUID()
    var name: String
    var category: String
    var duration: String
    var description: String
    var isFavourite: Bool
}

class CourseViewModel: ObservableObject {

    @Published var courses = [
        Course(
            name: "Swift Programming",
            category: "Programming",
            duration: "4 Weeks",
            description: "Learn Swift basics, variables, functions and programming concepts.",
            isFavourite: false
        ),
        Course(
            name: "iOS Development",
            category: "App Development",
            duration: "6 Weeks",
            description: "Learn to develop iOS applications using SwiftUI.",
            isFavourite: false
        ),
        Course(
            name: "Python Programming",
            category: "Programming",
            duration: "5 Weeks",
            description: "Learn Python syntax, loops and functions.",
            isFavourite: false
        ),
        Course(
            name: "Web Development",
            category: "Development",
            duration: "8 Weeks",
            description: "Learn HTML, CSS and JavaScript.",
            isFavourite: false
        )
    ]

    func toggleFavourite(for course: Course) {
        if let index = courses.firstIndex(where: { $0.id == course.id }) {
            courses[index].isFavourite.toggle()
        }
    }
}

struct ContentView: View {

    @StateObject private var viewModel = CourseViewModel()
    @State private var searchText = ""

    var filteredCourses: [Course] {
        if searchText.isEmpty {
            return viewModel.courses
        } else {
            return viewModel.courses.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search courses", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding()

                List {
                    ForEach(filteredCourses) { course in
                        NavigationLink {
                            CourseDetailView(
                                course: course,
                                viewModel: viewModel
                            )
                        } label: {
                            CourseRow(
                                course: course,
                                viewModel: viewModel
                            )
                        }
                    }
                }
            }
            .navigationTitle("My Courses")
        }
    }
}

struct CourseRow: View {

    var course: Course
    @ObservedObject var viewModel: CourseViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(course.name)
                    .font(.headline)

                Text(course.category)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text(course.duration)
                    .font(.caption)
                    .foregroundColor(.blue)
            }

            Spacer()

            Button {
                viewModel.toggleFavourite(for: course)
            } label: {
                Image(systemName: course.isFavourite ? "heart.fill" : "heart")
                    .foregroundColor(.red)
                    .font(.title2)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 5)
    }
}

struct CourseDetailView: View {

    var course: Course
    @ObservedObject var viewModel: CourseViewModel

    var currentCourse: Course {
        viewModel.courses.first(where: { $0.id == course.id }) ?? course
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {

            Text(currentCourse.name)
                .font(.largeTitle)
                .bold()

            Text("Category: \(currentCourse.category)")

            Text("Duration: \(currentCourse.duration)")
                .foregroundColor(.blue)

            Divider()

            Text(currentCourse.description)

            Button {
                viewModel.toggleFavourite(for: currentCourse)
            } label: {
                Label(
                    currentCourse.isFavourite ? "Remove Favourite" : "Add Favourite",
                    systemImage: currentCourse.isFavourite ? "heart.fill" : "heart"
                )
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Course Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ContentView()
}