
import SwiftUI

struct Course: Identifiable {
    var id = UUID()
    var name: String
    var category: String
    var duration: String
    var description: String
}

struct ContentView: View {

    let courses = [
        Course(
            name: "Swift Programming",
            category: "Programming",
            duration: "4 Weeks",
            description: "Learn Swift basics, variables, functions and object-oriented programming."
        ),
        Course(
            name: "iOS Development",
            category: "App Development",
            duration: "6 Weeks",
            description: "Learn to create iOS applications using Swift and SwiftUI."
        ),
        Course(
            name: "Python Programming",
            category: "Programming",
            duration: "5 Weeks",
            description: "Learn Python syntax, functions and programming concepts."
        ),
        Course(
            name: "Web Development",
            category: "Development",
            duration: "8 Weeks",
            description: "Learn HTML, CSS and JavaScript to create websites."
        )
    ]

    @State private var showInfo = false

    var body: some View {
        NavigationStack {
            List(courses) { course in
                NavigationLink {
                    CourseDetailView(course: course)
                } label: {
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
                    .padding(.vertical, 5)
                }
            }
            .navigationTitle("My Courses")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showInfo = true
                    } label: {
                        Image(systemName: "info.circle")
                    }
                }
            }
            .sheet(isPresented: $showInfo) {
                InfoView()
            }
        }
    }
}

struct CourseDetailView: View {

    var course: Course

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {

            Text(course.name)
                .font(.largeTitle)
                .bold()

            Text("Category: \(course.category)")
                .font(.headline)

            Text("Duration: \(course.duration)")
                .foregroundColor(.blue)

            Divider()

            Text("Course Description")
                .font(.title3)
                .bold()

            Text(course.description)
                .font(.body)

            Spacer()
        }
        .padding()
        .navigationTitle("Course Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InfoView: View {

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                Image(systemName: "book.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.blue)

                Text("Course Explorer")
                    .font(.title)
                    .bold()

                Text("This application helps students explore different programming courses.")
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .padding()
            .navigationTitle("Information")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}