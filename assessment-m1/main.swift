import Foundation

var gradebook: [String: [Int]] = [
    "Riya": [85, 90, 78],
    "Aman": [60, 70],
    "Neha": []
]

func addMark(for student: String, mark: Int) {
    if gradebook[student] != nil {
        gradebook[student]?.append(mark)
    } else {
        gradebook[student] = [mark]
    }
}

func average(for student: String) -> Double? {
    guard let marks = gradebook[student], !marks.isEmpty else {
        return nil
    }
    let total = marks.reduce(0, +)
    return Double(total) / Double(marks.count)
}

addMark(for: "Karan", mark: 92)

for name in ["Riya", "Aman", "Neha", "Karan", "Unknown"] {
    if let avg = average(for: name) {
        print("\(name) average: \(avg)")
    } else {
        print("\(name): no marks available")
    }
}

struct Stack<T> {
    private var items: [T] = []

    var isEmpty: Bool { return items.isEmpty }

    mutating func push(_ item: T) {
        items.append(item)
    }

    mutating func pop() -> T? {
        return items.popLast()
    }

    func peek() -> T? {
        return items.last
    }
}

var numberStack = Stack<Int>()
numberStack.push(1)
numberStack.push(2)
print("\nInt stack top:", numberStack.peek() ?? 0)
print("Popped:", numberStack.pop() ?? 0)

var wordStack = Stack<String>()
wordStack.push("Swift")
wordStack.push("iOS")
print("String stack top:", wordStack.peek() ?? "")

class Teacher {
    var student: Learner?
    deinit { print("Teacher removed") }
}

class Learner {
    weak var teacher: Teacher?
    deinit { print("Learner removed") }
}

print("\nRetain cycle test:")
do {
    let t = Teacher()
    let l = Learner()
    t.student = l
    l.teacher = t
}

enum LoginError: Error {
    case emptyUsername
    case shortPassword
}

func validateLogin(username: String, password: String) throws {
    if username.isEmpty {
        throw LoginError.emptyUsername
    }
    if password.count < 6 {
        throw LoginError.shortPassword
    }
}

func tryLogin(username: String, password: String) {
    do {
        try validateLogin(username: username, password: password)
        print("Login OK for \(username)")
    } catch LoginError.emptyUsername {
        print("Username cannot be empty")
    } catch LoginError.shortPassword {
        print("Password must be at least 6 characters")
    } catch {
        print("Something went wrong")
    }
}

print("\nValidation test:")
tryLogin(username: "riya", password: "abc12345")
tryLogin(username: "", password: "abc12345")
tryLogin(username: "riya", password: "123")