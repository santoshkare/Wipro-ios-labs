
import Foundation


var availableCourses = ["iOS", "HTML", "Python", "Kotlin"]

print("===== COURSE LIST =====")
print("Available Courses:", availableCourses)


availableCourses.insert("Swift", at: 1)
print("After Insertion:", availableCourses)


if let index = availableCourses.firstIndex(of: "HTML") {
    availableCourses.remove(at: index)
}
print("After Deletion:", availableCourses)


availableCourses.sort()
print("Alphabetical Order:", availableCourses)


let longCourseNames = availableCourses.filter {
    $0.count > 4
}
print("Long Course Names:", longCourseNames)


if availableCourses.contains("Swift") {
    print("Swift is available in the course list")
} else {
    print("Swift is not available")
}


print("\n===== STUDENT ID RECORDS =====")

var registeredIDs: Set<Int> = [201, 202, 203, 201, 204]

print("Registered IDs:", registeredIDs)
print("Unique ID Count:", registeredIDs.count)


registeredIDs.insert(205)
print("After Insertion:", registeredIDs)


registeredIDs.remove(202)
print("After Deletion:", registeredIDs)


if registeredIDs.contains(203) {
    print("ID 203 exists in the records")
} else {
    print("ID 203 does not exist")
}

print("\n===== STUDENT MARKS =====")

var marksRecord: [String: Int] = [
    "Dhruv": 88,
    "Neha": 92,
    "Arjun": 74,
    "Simran": 67,
    "Meera": 96
]


for (student, score) in marksRecord {
    print("\(student) scored \(score)")
}


marksRecord["Kabir"] = 81

print("\nAfter Adding Student:")
print(marksRecord)


marksRecord["Arjun"] = 84

print("\nAfter Updating Marks:")
print(marksRecord)


if let score = marksRecord["Santosh Kare"] {
    print("Dhruv's Marks:", score)
} else {
    print("Student record not found")
}


marksRecord.removeValue(forKey: "Simran")

print("\nAfter Removing Student:")
print(marksRecord)



var highestScore = -1
var highestScorer = ""

for (student, score) in marksRecord {
    if score > highestScore {
        highestScore = score
        highestScorer = student
    }
}

print("\n===== TOPPER DETAILS =====")
print("Top Scorer:", highestScorer)
print("Highest Score:", highestScore)


print("\nStudents Scoring Below 80:")

for (student, score) in marksRecord {
    if score < 80 {
        print("\(student): \(score)")
    }
}

print("\n===== TASK PRIORITY =====")

enum PriorityLevel {
    case normal
    case important
    case urgent
}

let selectedPriority = PriorityLevel.urgent

switch selectedPriority {
case .normal:
    print("Priority: Normal")
case .important:
    print("Priority: Important")
case .urgent:
    print("Priority: Urgent")
}


print("\n===== DELIVERY INFORMATION =====")

enum DeliveryStatus {
    case processing
    case dispatched
    case completed
    case returned
}

let currentStatus = DeliveryStatus.dispatched

switch currentStatus {
case .processing:
    print("Order is being processed")
case .dispatched:
    print("Order is on the way")
case .completed:
    print("Order delivered successfully")
case .returned:
    print("Order has been returned")
}

print("\n===== FINAL SUMMARY =====")

print("Number of Courses:", availableCourses.count)
print("Unique Registered Students:", registeredIDs.count)
print("Total Student Records:", marksRecord.count)
print("Highest Scorer:", highestScorer)
print("Highest Score:", highestScore)

print("\nExecution Finished Successfully!")