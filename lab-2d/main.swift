
import Foundation

enum ValidationError: Error {
    case emptyName
    case invalidMark
    case invalidID
}

struct Student {
    var name: String
    var marks: Int
    var id: Int
}

func registerStudent(name: String, marks: Int, id: Int) throws -> Student {

    if name.trimmingCharacters(in: .whitespaces).isEmpty {
        throw ValidationError.emptyName
    }

    if marks < 0 || marks > 100 {
        throw ValidationError.invalidMark
    }

    if id <= 0 {
        throw ValidationError.invalidID
    }

    return Student(name: name, marks: marks, id: id)
}

func findStudent(id: Int, students: [Student]) -> Student? {
    return students.first {
        $0.id == id
    }
}

func getStudentResult(name: String, marks: Int, id: Int) -> Result<Student, ValidationError> {

    if name.trimmingCharacters(in: .whitespaces).isEmpty {
        return .failure(.emptyName)
    }

    if marks < 0 || marks > 100 {
        return .failure(.invalidMark)
    }

    if id <= 0 {
        return .failure(.invalidID)
    }

    let student = Student(name: name, marks: marks, id: id)
    return .success(student)
}

do {
    let student = try registerStudent(name: "Santosh Kare", marks: 85, id: 101)

    print("Student Registered Successfully")
    print("Name:", student.name)
    print("Marks:", student.marks)
    print("ID:", student.id)

} catch ValidationError.emptyName {
    print("Error: Student name cannot be empty")

} catch ValidationError.invalidMark {
    print("Error: Marks must be between 0 and 100")

} catch ValidationError.invalidID {
    print("Error: Student ID must be greater than 0")

} catch {
    print("Something went wrong")
}

let students = [
    Student(name: "Rahul", marks: 80, id: 102),
    Student(name: "Aman", marks: 90, id: 103),
    Student(name: "Rohit", marks: 75, id: 104)
]

print("\nSearching Student:")

if let foundStudent = findStudent(id: 103, students: students) {
    print("Student Found:", foundStudent.name)
} else {
    print("Student Not Found")
}

print("\nResult Example:")

let result = getStudentResult(name: "Aman", marks: 90, id: 105)

switch result {
case .success(let student):
    print("Registration Successful:", student.name)

case .failure(let error):
    switch error {
    case .emptyName:
        print("Error: Empty Name")
    case .invalidMark:
        print("Error: Invalid Marks")
    case .invalidID:
        print("Error: Invalid ID")
    }
}

print("\nTesting Invalid Inputs:")

do {
    let student = try registerStudent(name: "", marks: 80, id: 106)
    print(student.name)
} catch ValidationError.emptyName {
    print("Empty name is not allowed")
} catch ValidationError.invalidMark {
    print("Invalid marks")
} catch ValidationError.invalidID {
    print("Invalid ID")
} catch {
    print("Unknown Error")
}

do {
    let student = try registerStudent(name: "Rahul", marks: 120, id: 107)
    print(student.name)
} catch ValidationError.invalidMark {
    print("Marks must be between 0 and 100")
} catch {
    print("Registration Failed")
}

do {
    let student = try registerStudent(name: "Rohit", marks: 75, id: 0)
    print(student.name)
} catch ValidationError.invalidID {
    print("Invalid Student ID")
} catch {
    print("Registration Failed")
}