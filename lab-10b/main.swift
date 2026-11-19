
import SwiftUI

struct ContentView: View {

    @State private var name = ""
    @State private var email = ""
    @State private var message = ""
    @State private var showSuccess = false

    var isFormValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        email.contains("@") &&
        email.contains(".")
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Student Details") {
                    TextField("Enter Name", text: $name)
                        .accessibilityIdentifier("nameField")

                    TextField("Enter Email", text: $email)
                        .keyboardType(.emailAddress)
                        .accessibilityIdentifier("emailField")
                }

                Section {
                    Button("Submit") {
                        if isFormValid {
                            message = "Registration successful for \(name)"
                            showSuccess = true
                        } else {
                            message = "Please enter valid details."
                        }
                    }
                    .disabled(name.isEmpty || email.isEmpty)
                    .accessibilityIdentifier("submitButton")

                    if !isFormValid && (!name.isEmpty || !email.isEmpty) {
                        Text("Please enter a valid name and email.")
                            .foregroundColor(.red)
                            .accessibilityIdentifier("validationMessage")
                    }
                }

                if !message.isEmpty {
                    Section("Result") {
                        Text(message)
                            .accessibilityIdentifier("resultMessage")
                    }
                }
            }
            .navigationTitle("Student Registration")
            .alert("Success", isPresented: $showSuccess) {
                Button("OK") {
                    name = ""
                    email = ""
                    message = ""
                }
            } message: {
                Text(message)
            }
        }
    }
}

#Preview {
    ContentView()
}