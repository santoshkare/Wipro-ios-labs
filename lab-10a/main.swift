
import Foundation

struct GradeCalculator {

    func calculateGrade(marks: Int) -> String {
        if marks < 0 || marks > 100 {
            return "Invalid"
        } else if marks >= 90 {
            return "A"
        } else if marks >= 75 {
            return "B"
        } else if marks >= 50 {
            return "C"
        } else {
            return "F"
        }
    }
}

struct FormValidator {

    func validate(name: String, email: String) -> Bool {
        if name.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }

        if !email.contains("@") || !email.contains(".") {
            return false
        }

        return true
    }
}

class CourseViewModel {

    private(set) var courses: [String] = []

    func addCourse(name: String) {
        let courseName = name.trimmingCharacters(in: .whitespaces)

        if !courseName.isEmpty {
            courses.append(courseName)
        }
    }

    func removeCourse(name: String) {
        courses.removeAll { $0 == name }
    }
}