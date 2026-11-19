
import Foundation

struct Student {
    var name: String
    var marks: Int
}

struct Transaction {
    var title: String
    var amount: Double
    var type: String
}

func calculateMean(numbers: [Double]) -> Double {
    if numbers.isEmpty {
        return 0
    }

    let total = numbers.reduce(0, +)
    return total / Double(numbers.count)
}

func findMaximum(numbers: [Int]) -> Int? {
    if numbers.isEmpty {
        return nil
    }

    var maximum = numbers[0]

    for number in numbers {
        if number > maximum {
            maximum = number
        }
    }

    return maximum
}

func validateEmail(email: String) -> Bool {
    if email.contains("@") && email.contains(".") {
        return true
    } else {
        return false
    }
}

func formatName(name: String) -> String {
    return name.trimmingCharacters(in: .whitespaces).capitalized
}

func sortStudents(students: [Student]) -> [Student] {
    return students.sorted {
        if $0.marks == $1.marks {
            return $0.name < $1.name
        }

        return $0.marks > $1.marks
    }
}

let numbers: [Double] = [10, 20, 30, 40, 50]
let marks: [Int] = [45, 78, 90, 65, 88]

print("Mean:", calculateMean(numbers: numbers))

if let maximum = findMaximum(numbers: marks) {
    print("Maximum Marks:", maximum)
}

print("Email Valid:", validateEmail(email: "santosh@gmail.com"))
print("Formatted Name:", formatName(name: "  Santosh Kare  "))

let students = [
    Student(name: "Rahul", marks: 85),
    Student(name: "Aman", marks: 90),
    Student(name: "Rohit", marks: 85),
    Student(name: "Karan", marks: 75)
]

let sortedStudents = sortStudents(students: students)

print("\nStudents Sorted by Marks:")

for student in sortedStudents {
    print(student.name, "-", student.marks)
}

let transactions = [
    Transaction(title: "Food", amount: 500, type: "Expense"),
    Transaction(title: "Salary", amount: 15000, type: "Income"),
    Transaction(title: "Travel", amount: 300, type: "Expense"),
    Transaction(title: "Shopping", amount: 1000, type: "Expense")
]

let expenses = transactions.filter {
    $0.type == "Expense"
}

let expenseAmounts = expenses.map {
    $0.amount
}

let totalExpenses = expenseAmounts.reduce(0, +)

print("\nExpense Amounts:", expenseAmounts)
print("Total Expenses:", totalExpenses)


var loopTotal = 0.0

for transaction in transactions {
    if transaction.type == "Expense" {
        loopTotal += transaction.amount
    }
}

print("Total Expenses using Loop:", loopTotal)