
import SwiftUI

struct Course: Identifiable {
    var id = UUID()
    var name: String
    var category: String
    var duration: String
    var description: String
    var status: String
}

let courseData = [
    Course(
        name: "Swift Programming",
        category: "Programming",
        duration: "4 Weeks",
        description: "Learn Swift fundamentals, variables, functions and object-oriented programming.",
        status: "Beginner"
    ),
    Course(
        name: "iOS Development",
        category: "App Development",
        duration: "6 Weeks",
        description: "Learn to develop applications for iPhone using Swift and SwiftUI.",
        status: "Intermediate"
    ),
    Course(
        name: "Python Programming",
        category: "Programming",
        duration: "5 Weeks",
        description: "Learn Python syntax, loops, functions and basic programming concepts.",
        status: "Beginner"
    ),
    Course(
        name: "Web Development",
        category: "Development",
        duration: "8 Weeks",
        description: "Learn HTML, CSS and JavaScript to build websites.",
        status: "Intermediate"
    )
]

struct ContentView: View {

    let courses = courseData

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 15) {

                    Text("Explore Courses")
                        .font(.largeTitle)
                        .bold()

                    Text("Choose a course to start learning")
                        .foregroundColor(.secondary)

                    if courses.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "book.closed")
                                .font(.system(size: 45))

                            Text("No Courses Available")
                                .font(.headline)

                            Text("Please check again later.")
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        ScrollView {
                            VStack(spacing: 15) {
                                ForEach(courses) { course in
                                    NavigationLink {
                                        CourseDetailView(course: course)
                                    } label: {
                                        CourseCard(course: course)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Course Explorer")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CourseCard: View {

    var course: Course

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            HStack {
                Image(systemName: "book.fill")
                    .font(.title2)
                    .foregroundColor(.blue)

                Spacer()

                Text(course.status)
                    .font(.caption)
                    .padding(8)
                    .background(Color.blue.opacity(0.12))
                    .foregroundColor(.blue)
                    .cornerRadius(8)
            }

            Text(course.name)
                .font(.title3)
                .bold()
                .foregroundColor(.primary)

            Text(course.category)
                .font(.subheadline)
                .foregroundColor(.secondary)

            HStack {
                Label(course.duration, systemImage: "clock")

                Spacer()

                Text("View Details")
                    .foregroundColor(.blue)
            }
            .font(.caption)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct CourseDetailView: View {

    var course: Course

    var body: some View {
        List {

            Section("Course Information") {
                Text(course.name)
                    .font(.title2)
                    .bold()

                Text("Category: \(course.category)")

                Text("Duration: \(course.duration)")

                Text("Level: \(course.status)")
            }

            Section("Description") {
                Text(course.description)
            }

            Section("What You Will Learn") {
                Text("Basic concepts")
                Text("Practical examples")
                Text("Hands-on learning")
            }
        }
        .navigationTitle("Course Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ContentView()
}