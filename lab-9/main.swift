
import SwiftUI

struct Course: Identifiable {
    var id = UUID()
    var name: String
    var category: String
    var duration: String
    var description: String
    var isFavorite: Bool
}

struct ContentView: View {

    @State private var courses = [
        Course(
            name: "Swift Programming",
            category: "Programming",
            duration: "4 Weeks",
            description: "Learn Swift basics, variables, functions and object-oriented programming.",
            isFavorite: false
        ),
        Course(
            name: "iOS Development",
            category: "App Development",
            duration: "6 Weeks",
            description: "Learn to develop iOS applications using SwiftUI.",
            isFavorite: false
        ),
        Course(
            name: "Python Programming",
            category: "Programming",
            duration: "5 Weeks",
            description: "Learn Python basics and programming concepts.",
            isFavorite: false
        ),
        Course(
            name: "Web Development",
            category: "Development",
            duration: "8 Weeks",
            description: "Learn HTML, CSS and JavaScript.",
            isFavorite: false
        )
    ]

    var body: some View {
        NavigationStack {
            List {
                Section("All Courses") {
                    ForEach($courses) { $course in
                        NavigationLink {
                            CourseDetailView(course: $course)
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(course.name)
                                        .font(.headline)

                                    Text(course.category)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)

                                    Text(course.duration)
                                        .font(.caption)
                                }

                                Spacer()

                                Button {
                                    course.isFavorite.toggle()
                                } label: {
                                    Image(systemName: course.isFavorite ? "heart.fill" : "heart")
                                        .foregroundColor(.red)
                                }
                                .buttonStyle(.borderless)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }

                Section("My Favourites") {
                    if courses.contains(where: { $0.isFavorite }) {
                        ForEach(courses.filter { $0.isFavorite }) { course in
                            HStack {
                                Text(course.name)

                                Spacer()

                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                            }
                        }
                    } else {
                        Text("No favourite courses added.")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Course Explorer")
        }
    }
}

struct CourseDetailView: View {

    @Binding var course: Course

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {

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

            Button {
                course.isFavorite.toggle()
            } label: {
                Label(
                    course.isFavorite ? "Remove from Favourites" : "Add to Favourites",
                    systemImage: course.isFavorite ? "heart.fill" : "heart"
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