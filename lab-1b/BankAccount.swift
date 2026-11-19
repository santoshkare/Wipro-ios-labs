
import Foundation

public class BankAccount {

    private var balance: Double

    public init?(initialBalance: Double) {
        if initialBalance < 0 {
            print("Invalid account setup")
            return nil
        }

        self.balance = initialBalance
    }

    public func deposit(amount: Double) {
        if amount <= 0 {
            print("Invalid deposit amount")
        } else {
            balance += amount
            print("Deposited: \(amount)")
        }
    }

    public func withdraw(amount: Double) {
        if amount <= 0 {
            print("Invalid withdrawal amount")
        } else if amount > balance {
            print("Insufficient balance")
        } else {
            balance -= amount
            print("Withdrawn: \(amount)")
        }
    }

    public func checkBalance() -> Double {
        return balance
    }
}
