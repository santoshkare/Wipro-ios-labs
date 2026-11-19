
import UIKit

struct Course {
    var name: String
    var duration: String
    var description: String
}

class ViewController: UITableViewController {

    let courses = [
        Course(
            name: "Swift Programming",
            duration: "4 Weeks",
            description: "Learn the basics of Swift programming language."
        ),
        Course(
            name: "iOS Development",
            duration: "6 Weeks",
            description: "Learn to create applications for Apple devices."
        ),
        Course(
            name: "Web Development",
            duration: "5 Weeks",
            description: "Learn HTML, CSS and JavaScript."
        ),
        Course(
            name: "Python Programming",
            duration: "4 Weeks",
            description: "Learn Python programming from basics."
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Course List"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CourseCell")
    }

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return courses.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "CourseCell",
            for: indexPath
        )

        let course = courses[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = course.name
        content.secondaryText = course.duration
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

        let selectedCourse = courses[indexPath.row]

        let detailVC = CourseDetailViewController(course: selectedCourse)

        navigationController?.pushViewController(
            detailVC,
            animated: true
        )

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class CourseDetailViewController: UIViewController {

    var course: Course?

    let nameLabel = UILabel()
    let durationLabel = UILabel()
    let descriptionLabel = UILabel()

    init(course: Course) {
        self.course = course
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Course Details"

        setupUI()
        showCourseDetails()
    }

    func setupUI() {

        nameLabel.font = .boldSystemFont(ofSize: 25)
        nameLabel.numberOfLines = 0

        durationLabel.font = .systemFont(ofSize: 18)
        durationLabel.textColor = .secondaryLabel

        descriptionLabel.font = .systemFont(ofSize: 17)
        descriptionLabel.numberOfLines = 0

        let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            durationLabel,
            descriptionLabel
        ])

        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 30
            ),
            stackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 25
            ),
            stackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -25
            )
        ])
    }

    func showCourseDetails() {

        guard let course = course else {
            nameLabel.text = "Course information not available"
            durationLabel.text = ""
            descriptionLabel.text = ""
            return
        }

        nameLabel.text = course.name
        durationLabel.text = "Duration: \(course.duration)"
        descriptionLabel.text = course.description
    }
}