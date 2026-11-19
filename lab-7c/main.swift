
import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    let nameTextField = UITextField()
    let notificationSwitch = UISwitch()
    let levelControl = UISegmentedControl(items: [
        "Beginner", "Intermediate", "Advanced"
    ])
    let hoursSlider = UISlider()

    let summaryLabel = UILabel()
    let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()

        print("viewDidLoad called")

        view.backgroundColor = .systemBackground
        title = "Course Preferences"

        setupUI()
        updateSummary()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear called")
        updateSummary()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear called")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear called")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear called")
    }

    func setupUI() {

        let nameLabel = UILabel()
        nameLabel.text = "Student Name"
        nameLabel.font = .boldSystemFont(ofSize: 17)

        nameTextField.placeholder = "Enter your name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.textContentType = .name
        nameTextField.accessibilityLabel = "Student Name"
        nameTextField.delegate = self
        nameTextField.addTarget(
            self,
            action: #selector(updateSummary),
            for: .editingChanged
        )

        let notificationLabel = UILabel()
        notificationLabel.text = "Enable Notifications"
        notificationLabel.font = .boldSystemFont(ofSize: 17)

        notificationSwitch.isOn = true
        notificationSwitch.accessibilityLabel = "Enable Notifications"
        notificationSwitch.addTarget(
            self,
            action: #selector(updateSummary),
            for: .valueChanged
        )

        let switchRow = UIStackView(arrangedSubviews: [
            notificationLabel,
            notificationSwitch
        ])

        switchRow.axis = .horizontal
        switchRow.distribution = .equalSpacing
        switchRow.alignment = .center

        let levelLabel = UILabel()
        levelLabel.text = "Select Course Level"
        levelLabel.font = .boldSystemFont(ofSize: 17)

        levelControl.selectedSegmentIndex = 0
        levelControl.accessibilityLabel = "Course Level"
        levelControl.addTarget(
            self,
            action: #selector(updateSummary),
            for: .valueChanged
        )

        let hoursLabel = UILabel()
        hoursLabel.text = "Daily Study Hours"
        hoursLabel.font = .boldSystemFont(ofSize: 17)

        hoursSlider.minimumValue = 1
        hoursSlider.maximumValue = 10
        hoursSlider.value = 5
        hoursSlider.accessibilityLabel = "Daily Study Hours"
        hoursSlider.addTarget(
            self,
            action: #selector(updateSummary),
            for: .valueChanged
        )

        let summaryTitle = UILabel()
        summaryTitle.text = "Your Summary"
        summaryTitle.font = .boldSystemFont(ofSize: 20)

        summaryLabel.numberOfLines = 0
        summaryLabel.font = .systemFont(ofSize: 16)

        let summaryStack = UIStackView(arrangedSubviews: [
            summaryTitle,
            summaryLabel
        ])

        summaryStack.axis = .vertical
        summaryStack.spacing = 12
        summaryStack.backgroundColor = .secondarySystemBackground
        summaryStack.layer.cornerRadius = 10
        summaryStack.isLayoutMarginsRelativeArrangement = true
        summaryStack.layoutMargins = UIEdgeInsets(
            top: 15,
            left: 15,
            bottom: 15,
            right: 15
        )

        let nextButton = UIButton(type: .system)
        nextButton.setTitle("Open Next Screen", for: .normal)
        nextButton.backgroundColor = .systemBlue
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.layer.cornerRadius = 8
        nextButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        nextButton.addTarget(
            self,
            action: #selector(openNextScreen),
            for: .touchUpInside
        )

        let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            nameTextField,
            switchRow,
            levelLabel,
            levelControl,
            hoursLabel,
            hoursSlider,
            summaryStack,
            nextButton
        ])

        stackView.axis = .vertical
        stackView.spacing = 18
        stackView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        NSLayoutConstraint.activate([

            scrollView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),

            scrollView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),

            scrollView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),

            scrollView.bottomAnchor.constraint(
                equalTo: view.keyboardLayoutGuide.topAnchor
            ),

            stackView.topAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.topAnchor,
                constant: 20
            ),

            stackView.leadingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.leadingAnchor,
                constant: 20
            ),

            stackView.trailingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.trailingAnchor,
                constant: -20
            ),

            stackView.bottomAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.bottomAnchor,
                constant: -20
            ),

            stackView.widthAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.widthAnchor,
                constant: -40
            )
        ])

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )

        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc func updateSummary() {

        let name = nameTextField.text?.isEmpty == false
            ? nameTextField.text!
            : "Not entered"

        let notifications = notificationSwitch.isOn ? "Enabled" : "Disabled"

        let levels = ["Beginner", "Intermediate", "Advanced"]
        let level = levels[levelControl.selectedSegmentIndex]

        let hours = Int(hoursSlider.value)

        summaryLabel.text = """
        Name: \(name)
        Notifications: \(notifications)
        Course Level: \(level)
        Study Hours: \(hours) hours per day
        """
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc func openNextScreen() {
        view.endEditing(true)

        let nextScreen = NextViewController()
        navigationController?.pushViewController(
            nextScreen,
            animated: true
        )
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

class NextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Next Screen"

        let label = UILabel()
        label.text = "This is the next screen"
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            label.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            )
        ])
    }
}