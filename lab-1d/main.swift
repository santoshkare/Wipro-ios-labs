
import Foundation

print("===== STUDENT INFORMATION =====")

let learnerName: String? = "Santosh Kare"
let learnerAge: Int? = 21
let learnerLocation: String? = nil

if let validName = learnerName {
    print("Name:", validName)
} else {
    print("Name information missing")
}

if let validAge = learnerAge {
    print("Age:", validAge)
} else {
    print("Age information missing")
}

if let validLocation = learnerLocation {
    print("Location:", validLocation)
} else {
    print("Location information missing")
}

print("\n===== DEFAULT VALUES =====")

let finalLocation = learnerLocation ?? "Mumbai"
let finalName = learnerName ?? "Guest"

print("Final Name:", finalName)
print("Final Location:", finalLocation)

print("\n===== MARKS SEARCH =====")

let examResults: [Int: Int] = [
    201: 88,
    202: 76,
    203: 95,
    204: 69
]

func findStudentMarks(id: Int) -> Int? {
    return examResults[id]
}

if let result = findStudentMarks(id: 201) {
    print("Student ID: 201")
    print("Obtained Marks:", result)
} else {
    print("No record found")
}

if let result = findStudentMarks(id: 210) {
    print("Marks:", result)
} else {
    print("Student ID 210 does not exist")
}

print("\n===== GUARD VALIDATION =====")

func displayResult(for id: Int) {

    guard let score = findStudentMarks(id: id) else {
        print("No student available with ID \(id)")
        return
    }

    print("Student ID:", id)
    print("Exam Score:", score)
}

displayResult(for: 202)
displayResult(for: 500)

print("\n===== STUDENT PROFILE =====")

struct Learner {
    var fullName: String
    var email: String?
    var contactNumber: String?
}

let learner = Learner(
    fullName: "Santosh Kare",
    email: nil,
    contactNumber: "9876543210"
)

print("Full Name:", learner.fullName)


if let emailAddress = learner.email {
    print("Email:", emailAddress)
} else {
    print("Email address not provided")
}


if let mobile = learner.contactNumber {
    print("Contact Number:", mobile)
} else {
    print("Contact number not provided")
}

let emailCount = learner.email?.count ?? 0

print("Email Character Count:", emailCount)

print("\n===== NAME VALIDATION =====")

let enteredName: String? = ""

if let nameValue = enteredName {

    if nameValue.isEmpty {
        print("Please enter a student name")
    } else {
        print("Entered Name:", nameValue)
    }

} else {
    print("Name value is nil")
}

print("\n===== STUDENT RECORD CHECK =====")

let checkingIDs = [201, 202, 205, 203, 210, 999]

for currentID in checkingIDs {

    if let score = findStudentMarks(id: currentID) {
        print("ID: \(currentID) | Marks: \(score)")
    } else {
        print("ID: \(currentID) | Record unavailable")
    }
}

print("\n===== FINAL REPORT =====")

print("Student:", finalName)
print("Location:", finalLocation)

if let finalScore = findStudentMarks(id: 201) {
    print("Marks:", finalScore)
} else {
    print("Marks not found")
}

print("\nProgram Executed Successfully!")