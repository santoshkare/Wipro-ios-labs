import Foundation

class UnsafeCounter {
    var value = 0

    func increment() {
        value += 1
    }
}

actor SafeCounter {
    private(set) var value = 0

    func increment() {
        value += 1
    }
}

struct Score: Sendable {
    let name: String
    let points: Int
}

let numberOfTasks = 10
let incrementsPerTask = 10000

func runUnsafeCounter() async -> Int {
    let counter = UnsafeCounter()
    await withTaskGroup(of: Void.self) { group in
        for _ in 1...numberOfTasks {
            group.addTask {
                for _ in 1...incrementsPerTask {
                    counter.increment()
                }
            }
        }
    }
    return counter.value
}

func runSafeCounter() async -> Int {
    let counter = SafeCounter()
    await withTaskGroup(of: Void.self) { group in
        for _ in 1...numberOfTasks {
            group.addTask {
                for _ in 1...incrementsPerTask {
                    await counter.increment()
                }
            }
        }
    }
    return await counter.value
}

let expected = numberOfTasks * incrementsPerTask

print("Expected value: \(expected)")

print("\n--- Before (unsafe counter) ---")
for run in 1...3 {
    let result = await runUnsafeCounter()
    print("Run \(run): \(result)")
}

print("\n--- After (actor counter) ---")
for run in 1...3 {
    let result = await runSafeCounter()
    print("Run \(run): \(result)")
}

print("\n--- Sendable example ---")
let score = Score(name: "Riya", points: 90)
let sendTask = Task {
    return "\(score.name) scored \(score.points)"
}
print(await sendTask.value)