
import Foundation

struct Student {
    var name: String
    var marks: Int
}

let students = [
    Student(name: "Rahul", marks: 85),
    Student(name: "Aman", marks: 90),
    Student(name: "Rohit", marks: 75),
    Student(name: "Karan", marks: 80)
]

let sortedStudents = students.sorted {
    $0.marks > $1.marks
}

print("Students Sorted by Marks:")

for student in sortedStudents {
    print(student.name, "-", student.marks)
}

let sortedByName = students.sorted {
    firstStudent, secondStudent in
    return firstStudent.name < secondStudent.name
}

print("\nStudents Sorted by Name:")

for student in sortedByName {
    print(student.name)
}

func performTask(completion: () -> Void) {
    print("\nTask Started")
    print("Task Completed")
    completion()
}

performTask {
    print("Completion Message: Operation Successful")
}

let greet = {
    print("\nHello! Welcome to Swift Closures")
}

greet()

var count = 0

let counter = {
    count += 1
    return count
}

print("\nCounter:", counter())
print("Counter:", counter())
print("Counter:", counter())

class DownloadManager {

    var completion: (() -> Void)?

    func startDownload() {
        completion = { [weak self] in
            self?.showMessage()
        }
    }

    func showMessage() {
        print("\nDownload Completed Successfully")
    }
}

let manager = DownloadManager()

manager.startDownload()
manager.completion?()