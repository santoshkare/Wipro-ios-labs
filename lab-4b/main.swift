import UIKit

func currentTime() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss.SSS"
    return formatter.string(from: Date())
}

func writeLog(_ text: String) {
    print("\(currentTime()) | \(text)")
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        writeLog("Scene: willConnectTo")

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: FirstViewController())
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        writeLog("Scene: sceneDidDisconnect")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        writeLog("Scene: sceneDidBecomeActive")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        writeLog("Scene: sceneWillResignActive")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        writeLog("Scene: sceneWillEnterForeground")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        writeLog("Scene: sceneDidEnterBackground")
    }
}

class LoggedViewController: UIViewController {

    var screenName: String {
        return "Screen"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        writeLog("\(screenName): viewDidLoad")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        writeLog("\(screenName): viewWillAppear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        writeLog("\(screenName): viewDidAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        writeLog("\(screenName): viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        writeLog("\(screenName): viewDidDisappear")
    }
}

class FirstViewController: LoggedViewController {

    override var screenName: String {
        return "First"
    }

    let appearLabel = UILabel()
    let refreshLabel = UILabel()
    let draftView = UITextView()
    let nextButton = UIButton(type: .system)

    var appearCount = 0
    let draftKey = "savedDraft"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "First Screen"
        view.backgroundColor = .white

        draftView.layer.borderWidth = 1
        draftView.layer.borderColor = UIColor.gray.cgColor
        draftView.font = UIFont.systemFont(ofSize: 16)
        draftView.text = UserDefaults.standard.string(forKey: draftKey) ?? ""

        nextButton.setTitle("Go to Second Screen", for: .normal)
        nextButton.addTarget(self, action: #selector(openSecond), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [appearLabel, refreshLabel, draftView, nextButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            draftView.heightAnchor.constraint(equalToConstant: 120)
        ])

        NotificationCenter.default.addObserver(self, selector: #selector(saveDraft),
                                               name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(restoreDraft),
                                               name: UIApplication.willEnterForegroundNotification, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appearCount += 1
        appearLabel.text = "This screen appeared \(appearCount) time(s)"
        refreshLabel.text = "Last refreshed: \(currentTime())"
    }

    @objc func openSecond() {
        navigationController?.pushViewController(SecondViewController(), animated: true)
    }

    @objc func saveDraft() {
        UserDefaults.standard.set(draftView.text, forKey: draftKey)
        writeLog("First: draft saved")
    }

    @objc func restoreDraft() {
        if let saved = UserDefaults.standard.string(forKey: draftKey) {
            draftView.text = saved
            writeLog("First: draft restored")
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

class SecondViewController: LoggedViewController {

    override var screenName: String {
        return "Second"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Second Screen"
        view.backgroundColor = .systemYellow

        let label = UILabel()
        label.text = "This is the second screen"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}