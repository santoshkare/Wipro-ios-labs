import UIKit

func logThread(_ text: String) {
    let threadName = Thread.isMainThread ? "Main Thread" : "Background Thread"
    print("[\(threadName)] \(text)")
}

class LoadingViewController: UIViewController {

    let statusLabel = UILabel()
    let spinner = UIActivityIndicatorView(style: .medium)
    let loadButton = UIButton(type: .system)
    let delayButton = UIButton(type: .system)
    let twoOpsButton = UIButton(type: .system)

    var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        statusLabel.text = "Press a button"
        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 0

        loadButton.setTitle("Load Data (background work)", for: .normal)
        loadButton.addTarget(self, action: #selector(loadTapped), for: .touchUpInside)

        delayButton.setTitle("Delayed Response (asyncAfter)", for: .normal)
        delayButton.addTarget(self, action: #selector(delayTapped), for: .touchUpInside)

        twoOpsButton.setTitle("Run Two Operations Together", for: .normal)
        twoOpsButton.addTarget(self, action: #selector(twoOpsTapped), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [statusLabel, spinner, loadButton, delayButton, twoOpsButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    func startLoading() {
        isLoading = true
        loadButton.isEnabled = false
        delayButton.isEnabled = false
        twoOpsButton.isEnabled = false
        spinner.startAnimating()
        statusLabel.text = "Loading..."
    }

    func stopLoading(message: String) {
        isLoading = false
        loadButton.isEnabled = true
        delayButton.isEnabled = true
        twoOpsButton.isEnabled = true
        spinner.stopAnimating()
        statusLabel.text = message
    }

    @objc func loadTapped() {
        if isLoading { return }
        startLoading()
        logThread("Load button tapped")

        DispatchQueue.global(qos: .userInitiated).async {
            logThread("Slow work started")
            Thread.sleep(forTimeInterval: 3)
            let message = "Loaded 25 items"
            logThread("Slow work finished")

            DispatchQueue.main.async {
                logThread("Updating the UI")
                self.stopLoading(message: message)
            }
        }
    }

    @objc func delayTapped() {
        if isLoading { return }
        startLoading()
        logThread("Delay button tapped")

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            logThread("Delayed response arrived")
            self.stopLoading(message: "Delayed response received")
        }
    }

    @objc func twoOpsTapped() {
        if isLoading { return }
        startLoading()

        let group = DispatchGroup()
        let resultQueue = DispatchQueue(label: "results.queue")
        var results: [String] = []

        DispatchQueue.global().async(group: group) {
            logThread("Operation 1 started")
            Thread.sleep(forTimeInterval: 2)
            resultQueue.sync {
                results.append("Marks loaded")
            }
        }

        DispatchQueue.global().async(group: group) {
            logThread("Operation 2 started")
            Thread.sleep(forTimeInterval: 3)
            resultQueue.sync {
                results.append("Attendance loaded")
            }
        }

        group.notify(queue: .main) {
            logThread("Both operations finished")
            self.stopLoading(message: results.joined(separator: " + "))
        }
    }
}