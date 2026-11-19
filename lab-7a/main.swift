
import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    let titleLabel = UILabel()
    let nameTextField = UITextField()
    let emailTextField = UITextField()
    let courseTextField = UITextField()
    let submitButton = UIButton(type: .system)
    let messageLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        setupUI()
        setupKeyboard()
    }

    func setupUI() {

        titleLabel.text = "Profile Form"
        titleLabel.font = .boldSystemFont(ofSize: 28)
        titleLabel.textAlignment = .center

        nameTextField.placeholder = "Enter your name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.textContentType = .name
        nameTextField.accessibilityLabel = "Name"
        nameTextField.returnKeyType = .next
        nameTextField.delegate = self

        emailTextField.placeholder = "Enter your email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.keyboardType = .emailAddress
        emailTextField.textContentType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.accessibilityLabel = "Email"
        emailTextField.returnKeyType = .next
        emailTextField.delegate = self

        courseTextField.placeholder = "Enter your course"
        courseTextField.borderStyle = .roundedRect
        courseTextField.accessibilityLabel = "Course"
        courseTextField.returnKeyType = .done
        courseTextField.delegate = self

        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = .systemBlue
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 8
        submitButton.accessibilityLabel = "Submit Profile"
        submitButton.addTarget(self, action: #selector(submitForm), for: .touchUpInside)

        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0

        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            nameTextField,
            emailTextField,
            courseTextField,
            submitButton,
            messageLabel
        ])

        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([

            stackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 50
            ),

            stackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 25
            ),

            stackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -25
            ),

            nameTextField.heightAnchor.constraint(equalToConstant: 45),
            emailTextField.heightAnchor.constraint(equalToConstant: 45),
            courseTextField.heightAnchor.constraint(equalToConstant: 45),
            submitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func submitForm() {

        view.endEditing(true)

        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let course = courseTextField.text ?? ""

        if name.trimmingCharacters(in: .whitespaces).isEmpty {
            showMessage("Please enter your name")
        } else if email.trimmingCharacters(in: .whitespaces).isEmpty {
            showMessage("Please enter your email")
        } else if !email.contains("@") || !email.contains(".") {
            showMessage("Please enter a valid email")
        } else if course.trimmingCharacters(in: .whitespaces).isEmpty {
            showMessage("Please enter your course")
        } else {
            showMessage("Profile Submitted Successfully")
        }
    }

    func showMessage(_ message: String) {

        messageLabel.text = message

        if message == "Profile Submitted Successfully" {
            messageLabel.textColor = .systemGreen
        } else {
            messageLabel.textColor = .systemRed
        }
    }

    func setupKeyboard() {

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )

        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == nameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            courseTextField.becomeFirstResponder()
        } else {
            courseTextField.resignFirstResponder()
        }

        return true
    }
}