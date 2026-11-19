
import Foundation

print("BANK ACCOUNT VALIDATION TESTS")
print("------------------------------")

// Test 1: Valid Account
print("\nTC-01: Valid Account")
if let account = BankAccount(initialBalance: 1000) {
    print("Account Created Successfully")
    print("Balance: \(account.checkBalance())")
}

// Test 2: Zero Deposit
print("\nTC-02: Zero Deposit")
if let account = BankAccount(initialBalance: 1000) {
    account.deposit(amount: 0)
    print("Balance: \(account.checkBalance())")
}

// Test 3: Negative Deposit
print("\nTC-03: Negative Deposit")
if let account = BankAccount(initialBalance: 1000) {
    account.deposit(amount: -500)
    print("Balance: \(account.checkBalance())")
}

// Test 4: Zero Withdrawal
print("\nTC-04: Zero Withdrawal")
if let account = BankAccount(initialBalance: 1000) {
    account.withdraw(amount: 0)
    print("Balance: \(account.checkBalance())")
}

// Test 5: Negative Withdrawal
print("\nTC-05: Negative Withdrawal")
if let account = BankAccount(initialBalance: 1000) {
    account.withdraw(amount: -200)
    print("Balance: \(account.checkBalance())")
}

// Test 6: Insufficient Balance
print("\nTC-06: Excess Withdrawal")
if let account = BankAccount(initialBalance: 1000) {
    account.withdraw(amount: 1500)
    print("Balance: \(account.checkBalance())")
}

// Test 7: Negative Initial Balance
print("\nTC-07: Invalid Account Setup")
let invalidAccount = BankAccount(initialBalance: -500)

if invalidAccount == nil {
    print("Account Creation Rejected")
}




print("\nACCESS MODIFIER DEMONSTRATION")
print("------------------------------")

let demo = AccessDemo()

demo.showPrivateValue()
demo.showFilePrivateValue()

print(demo.internalValue)
print(demo.publicValue)



print("\nTASK 4: ENCAPSULATION TEST")
print("------------------------------")

if let account = BankAccount(initialBalance: 2000) {
    print("Initial Balance: \(account.checkBalance())")

    account.deposit(amount: 500)
    account.withdraw(amount: 300)

    print("Final Balance: \(account.checkBalance())")
    print("Balance can only be changed through public methods.")
}