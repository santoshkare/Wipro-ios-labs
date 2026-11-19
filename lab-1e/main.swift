
import Foundation

print("========== STRUCT: VALUE TYPE ==========")

struct Course {
    var name: String
    var duration: Int
}

var course1 = Course(name: "Swift", duration: 30)


var course2 = course1


course2.name = "Java"
course2.duration = 45

print("Original Course:", course1.name, course1.duration)
print("Copied Course:", course2.name, course2.duration)


print("\n========== CLASS: REFERENCE TYPE ==========")

class CourseManager {

    var courseName: String

    init(courseName: String) {
        self.courseName = courseName
    }

    deinit {
        print("CourseManager object released")
    }
}

var manager1: CourseManager? = CourseManager(
    courseName: "Swift"
)


var manager2 = manager1


manager2?.courseName = "Advanced Swift"

print("Manager 1:", manager1?.courseName ?? "Unknown")
print("Manager 2:", manager2?.courseName ?? "Unknown")


manager1 = nil
manager2 = nil



print("\n========== TEACHER AND CLASSROOM ==========")

class Teacher {

    let name: String

    init(name: String) {
        self.name = name
    }

    deinit {
        print("Teacher \(name) released")
    }
}

class Classroom {

    let roomNumber: Int

    
    weak var teacher: Teacher?

    init(roomNumber: Int) {
        self.roomNumber = roomNumber
    }

    deinit {
        print("Classroom \(roomNumber) released")
    }
}

do {

    let teacher = Teacher(name: "Mr. Sharma")
    let classroom = Classroom(roomNumber: 101)

    classroom.teacher = teacher

    print("Teacher:", classroom.teacher?.name ?? "No Teacher")
    print("Classroom:", classroom.roomNumber)
}



print("\n========== STRONG REFERENCE CYCLE ==========")

class CourseDetails {

    let name: String

    var completionHandler: (() -> Void)?

    init(name: String) {
        self.name = name
    }

    func setupHandler() {

        

        completionHandler = {
            print("Course:", self.name)
        }
    }

    deinit {
        print("CourseDetails released")
    }
}

var courseDetails: CourseDetails? = CourseDetails(
    name: "iOS Development"
)

courseDetails?.setupHandler()

courseDetails = nil

print("CourseDetails reference set to nil")
print("Deinit will not execute because of retain cycle")



print("\n========== FIXING RETAIN CYCLE ==========")

class SafeCourseDetails {

    let name: String

    var completionHandler: (() -> Void)?

    init(name: String) {
        self.name = name
    }

    func setupHandler() {

        

        completionHandler = { [weak self] in

            guard let self = self else {
                print("Course object no longer exists")
                return
            }

            print("Course:", self.name)
        }
    }

    deinit {
        print("SafeCourseDetails released")
    }
}

var safeCourse: SafeCourseDetails? = SafeCourseDetails(
    name: "Swift Programming"
)

safeCourse?.setupHandler()
safeCourse?.completionHandler?()

safeCourse = nil

print("SafeCourse reference set to nil")

print("\n========== DEINIT DEMONSTRATION ==========")

class Student {

    let name: String

    init(name: String) {
        self.name = name
        print("Student \(name) created")
    }

    deinit {
        print("Student \(name) destroyed")
    }
}

var student: Student? = Student(name: "Dhruv")

student = nil

print("Program completed")