import Foundation

protocol Displayable {
    func display()
}

struct Student: Displayable {
    var name: String
    var marks: Int

    func display() {
        print("Student Name:", name)
        print("Student Marks:", marks)
    }
}

struct Course: Displayable {
    var courseName: String
    var duration: Int

    func display() {
        print("Course Name:", courseName)
        print("Duration:", duration, "months")
    }
}

extension String {
    var wordCount: Int {
        return self.split(separator: " ").count
    }
}

struct Stack<T> {
    var items: [T] = []

    mutating func push(_ item: T) {
        items.append(item)
    }

    mutating func pop() -> T? {
        if items.isEmpty {
            return nil
        }

        return items.removeLast()
    }

    func peek() -> T? {
        return items.last
    }

    var isEmpty: Bool {
        return items.isEmpty
    }
}

func showDetails<T: Displayable>(_ item: T) {
    item.display()
}

let student = Student(name: "Santosh Kare", marks: 85)
let course = Course(courseName: "Swift Programming", duration: 3)

print("Student Details:")
showDetails(student)

print("\nCourse Details:")
showDetails(course)

let message = "Learning Swift Programming"
print("\nWord Count:", message.wordCount)

var intStack = Stack<Int>()

intStack.push(10)
intStack.push(20)
intStack.push(30)

print("\nInteger Stack:")
print("Top Element:", intStack.peek() ?? 0)
print("Removed Element:", intStack.pop() ?? 0)
print("Stack Empty:", intStack.isEmpty)

var stringStack = Stack<String>()

stringStack.push("Apple")
stringStack.push("Banana")
stringStack.push("Mango")

print("\nString Stack:")
print("Top Element:", stringStack.peek() ?? "No Element")
print("Removed Element:", stringStack.pop() ?? "No Element")
print("Stack Empty:", stringStack.isEmpty)

print("\nStack Tests:")

var testStack = Stack<Int>()

print("Initially Empty:", testStack.isEmpty)

testStack.push(100)
print("After Push:", testStack.peek() ?? 0)

testStack.push(200)
print("After Second Push:", testStack.peek() ?? 0)

print("Pop:", testStack.pop() ?? 0)
print("Current Top:", testStack.peek() ?? 0)

testStack.pop()
print("After Removing All Elements:", testStack.isEmpty)