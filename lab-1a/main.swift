
import Foundation

let studentName: String = "Santosh Kare"
let rollNumber: Int = 101

let subject1: Int = 85
let subject2: Int = 78
let subject3: Int = 90
let subject4: Int = 75
let subject5: Int = 88

let attendance: Double = 85.0

print("Student Details")
print("--------------------")
print("Name: \(studentName)")
print("Roll Number: \(rollNumber)")
print("Subject 1: \(subject1)")
print("Subject 2: \(subject2)")
print("Subject 3: \(subject3)")
print("Subject 4: \(subject4)")
print("Subject 5: \(subject5)")
print("Attendance: \(attendance)%")



// Task 2: Calculate Total, Average, Percentage and Pass/Fail

let totalMarks = subject1 + subject2 + subject3 + subject4 + subject5

let average = Double(totalMarks) / 5

let percentage = (Double(totalMarks) / 500) * 100

let isPass = subject1 >= 35 &&
             subject2 >= 35 &&
             subject3 >= 35 &&
             subject4 >= 35 &&
             subject5 >= 35

print("\nAcademic Result")
print("--------------------")
print("Total Marks: \(totalMarks) / 500")
print("Average Marks: \(average)")
print("Percentage: \(percentage)%")
print("Result: \(isPass ? "PASS" : "FAIL")")


// Task 3: Swift Operators

print("\nSwift Operators")
print("--------------------")

// 1. Arithmetic Operators
let a = 20
let b = 10

print("\n1. Arithmetic Operators")
print("Addition: \(a + b)")
print("Subtraction: \(a - b)")
print("Multiplication: \(a * b)")
print("Division: \(a / b)")
print("Remainder: \(a % b)")

// 2. Comparison Operators
print("\n2. Comparison Operators")
print("Equal: \(a == b)")
print("Not Equal: \(a != b)")
print("Greater Than: \(a > b)")
print("Less Than: \(a < b)")
print("Greater Than or Equal: \(a >= b)")
print("Less Than or Equal: \(a <= b)")

// 3. Logical Operators
let hasPassed = true
let attendanceEligible = true

print("\n3. Logical Operators")
print("AND: \(hasPassed && attendanceEligible)")
print("OR: \(hasPassed || attendanceEligible)")
print("NOT: \(!hasPassed)")

// 4. Compound Assignment Operators
var marks = 50

marks += 10
print("\n4. Compound Assignment Operators")
print("After += 10: \(marks)")

marks -= 5
print("After -= 5: \(marks)")

// 5. Nil-Coalescing Operator
let optionalName: String? = nil
let student = optionalName ?? "Unknown Student"

print("\n5. Nil-Coalescing Operator")
print("Student Name: \(student)")



// Task 4: If-Else and Switch Statements

var grade: String

// Using If-Else
if !isPass {
    grade = "F"
} else if percentage >= 90 {
    grade = "A+"
} else if percentage >= 80 {
    grade = "A"
} else if percentage >= 70 {
    grade = "B"
} else if percentage >= 60 {
    grade = "C"
} else if percentage >= 50 {
    grade = "D"
} else {
    grade = "F"
}

// Using Switch
print("\n4. Grade and Formatted Result")
print("--------------------")

switch grade {
case "A+":
    print("Excellent Performance")
case "A":
    print("Very Good Performance")
case "B":
    print("Good Performance")
case "C":
    print("Average Performance")
case "D":
    print("Below Average Performance")
case "F":
    print("Failed")
default:
    print("Invalid Grade")
}

print("\nStudent Result Card")
print("--------------------")
print("Name: \(studentName)")
print("Total Marks: \(totalMarks)/500")
print("Percentage: \(percentage)%")
print("Grade: \(grade)")
print("Result: \(isPass ? "PASS" : "FAIL")")



// Task 5: Boundary Value Validation

print("\n5. Boundary Value Validation")
print("--------------------")

// Test 1: Minimum Marks (0)
let minimumMarks = 0
print("Minimum Marks (0): \(minimumMarks)")

// Test 2: Maximum Marks (100)
let maximumMarks = 100
print("Maximum Marks (100): \(maximumMarks)")

// Test 3: Failing Marks
let failingMarks = 30
let failingResult = failingMarks >= 35 ? "PASS" : "FAIL"
print("Failing Marks (30): \(failingResult)")

// Test 4: Invalid Attendance
let invalidAttendance = 105.0

if invalidAttendance >= 0 && invalidAttendance <= 100 {
    print("Attendance: Valid")
} else {
    print("Attendance: Invalid")
}

// Test 5: Valid Attendance
let validAttendance = 85.0

if validAttendance >= 0 && validAttendance <= 100 {
    print("Attendance: Valid")
} else {
    print("Attendance: Invalid")
}








// Automated Testing: All 8 Test Cases

func calculateTestResult(marks: [Int]) -> (total: Int, average: Double, percentage: Double, passed: Bool) {
    let total = marks.reduce(0, +)
    let average = Double(total) / 5.0
    let percentage = (Double(total) / 500.0) * 100.0
    let passed = marks.allSatisfy { $0 >= 35 && $0 <= 100 }

    return (total, average, percentage, passed)
}

func runMarksTest(
    testName: String,
    marks: [Int],
    expectedTotal: Int,
    expectedPercentage: Double,
    expectedPass: Bool
) {
    let result = calculateTestResult(marks: marks)

    let isCorrect =
        result.total == expectedTotal &&
        result.percentage == expectedPercentage &&
        result.passed == expectedPass

    print("\n\(testName)")
    print("Input Marks: \(marks)")
    print("Total: \(result.total)")
    print("Average: \(result.average)")
    print("Percentage: \(result.percentage)%")
    print("Result: \(result.passed ? "PASS" : "FAIL")")
    print("Test Status: \(isCorrect ? "PASS" : "FAIL")")
}

// TC-01: Normal Marks
runMarksTest(
    testName: "TC-01: Normal Marks",
    marks: [85, 78, 90, 75, 88],
    expectedTotal: 416,
    expectedPercentage: 83.2,
    expectedPass: true
)

// TC-02: Minimum Marks
runMarksTest(
    testName: "TC-02: Minimum Marks",
    marks: [0, 0, 0, 0, 0],
    expectedTotal: 0,
    expectedPercentage: 0.0,
    expectedPass: false
)

// TC-03: Maximum Marks
runMarksTest(
    testName: "TC-03: Maximum Marks",
    marks: [100, 100, 100, 100, 100],
    expectedTotal: 500,
    expectedPercentage: 100.0,
    expectedPass: true
)

// TC-04: Failing Marks
runMarksTest(
    testName: "TC-04: Failing Marks",
    marks: [30, 80, 80, 80, 80],
    expectedTotal: 350,
    expectedPercentage: 70.0,
    expectedPass: false
)

// TC-05: Passing Boundary
runMarksTest(
    testName: "TC-05: Passing Boundary",
    marks: [35, 35, 35, 35, 35],
    expectedTotal: 175,
    expectedPercentage: 35.0,
    expectedPass: true
)

// TC-06: Invalid Attendance
let testAttendance1 = 105.0
let attendanceResult1 = testAttendance1 >= 0 && testAttendance1 <= 100
let tc06Passed = attendanceResult1 == false

print("\nTC-06: Invalid Attendance")
print("Attendance: \(testAttendance1)%")
print("Actual Output: \(attendanceResult1 ? "Valid" : "Invalid Attendance")")
print("Test Status: \(tc06Passed ? "PASS" : "FAIL")")

// TC-07: Zero Attendance
let testAttendance2 = 0.0
let attendanceResult2 = testAttendance2 >= 0 && testAttendance2 <= 100
let tc07Passed = attendanceResult2 == true

print("\nTC-07: Zero Attendance")
print("Attendance: \(testAttendance2)%")
print("Actual Output: \(attendanceResult2 ? "Valid Attendance" : "Invalid")")
print("Test Status: \(tc07Passed ? "PASS" : "FAIL")")

// TC-08: Nil-Coalescing Operator
let testOptionalName: String? = nil
let testStudentName = testOptionalName ?? "Unknown Student"
let tc08Passed = testStudentName == "Unknown Student"

print("\nTC-08: Nil-Coalescing Operator")
print("Actual Output: Student Name: \(testStudentName)")
print("Test Status: \(tc08Passed ? "PASS" : "FAIL")")
