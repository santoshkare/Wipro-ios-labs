
import SwiftUI

struct ContentView: View {

    @State private var name = ""
    @State private var result = ""

    var body: some View {
        VStack(spacing: 20) {

            Text("Welcome App")
                .font(.largeTitle)
                .bold()

            TextField("Enter your name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Submit") {
                if name.isEmpty {
                    result = "Please enter your name"
                } else {
                    result = "Hello, \(name)!"
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            Text(result)
                .font(.title3)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}