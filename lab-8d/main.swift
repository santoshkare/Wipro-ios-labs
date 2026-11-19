
import SwiftUI

struct ContentView: View {

    @State private var name = ""
    @State private var email = ""
    @State private var selectedEvent = "Select Event"
    @State private var isAgree = false
    @State private var showAlert = false

    let events = [
        "Select Event",
        "iOS Development Workshop",
        "Web Development Workshop",
        "Python Programming Workshop",
        "AI and Machine Learning Seminar"
    ]

    var isFormValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        email.contains("@") &&
        email.contains(".") &&
        selectedEvent != "Select Event" &&
        isAgree
    }

    var body: some View {
        NavigationStack {
            Form {

                Section("Personal Information") {

                    TextField("Enter your name", text: $name)

                    TextField("Enter your email", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                }

                Section("Event Details") {

                    Picker("Select Event", selection: $selectedEvent) {
                        ForEach(events, id: \.self) { event in
                            Text(event).tag(event)
                        }
                    }

                    Toggle("I agree to the terms and conditions", isOn: $isAgree)
                }

                Section {
                    Button("Register Now") {
                        showAlert = true
                    }
                    .frame(maxWidth: .infinity)
                    .disabled(!isFormValid)
                }

            }
            .navigationTitle("Event Registration")
            .alert("Registration Successful", isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    name = ""
                    email = ""
                    selectedEvent = "Select Event"
                    isAgree = false
                }
            } message: {
                Text("Thank you \(name). You have successfully registered for \(selectedEvent).")
            }
        }
    }
}

#Preview {
    ContentView()
}