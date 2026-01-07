import UIKit

/// Production-quality Home (Dashboard) screen for HEALITH mobile app (UIKit, iOS 15+, programmatic)
class HomeViewController: UIViewController {
    // MARK: - Mock Data
    private let userName = "Alex"
    private let steps = "6,420"
    private let caloriesBurned = "310"
    private let caloriesEaten = "1,320"
    private let waterIntake = "1.5L"
    private let insightMsg = "Your sleep dropped 20% this week. Try resting earlier tonight."
    private let upcomingWorkout = "Upper Body Strength @ 6:00pm"
    private let upcomingMeal = "Dinner @ 7:30pm"
    private let hasPlanned = true
    private let streakCount = 5
    private let streakMsg = "🔥 5-Day Activity Streak\nKeep going! You're on track."
    private let reminders = ["Drink water", "Evening workout", "Sleep reminder"]

    // MARK: - Header
    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Good morning,"
        label.font = UIFont.systemFont(ofSize: 21, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 27, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let headerSubLabel: UILabel = {
        let label = UILabel()
        label.text = "Let’s take care of your health today"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor(white: 0.45, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let profileImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "person.crop.circle.fill"))
        iv.contentMode = .scaleAspectFill
        iv.tintColor = UIColor(red: 2/255, green: 115/255, blue: 86/255, alpha: 0.22)
        iv.layer.cornerRadius = 27
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    // MARK: - Scroll and Content
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.alwaysBounceVertical = true
        sv.showsVerticalScrollIndicator = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    private let contentStack: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.spacing = 26
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    // MARK: - Dashboard Cards
    private lazy var overviewCard = CardView(title: "Today's Overview", content: makeOverviewContent())
    private lazy var insightCard = CardView(title: "Today's Insight", content: makeInsightContent(), style: .highlighted)
    private lazy var quickActionsSection = makeQuickActionsSection()
    private lazy var upcomingCard = CardView(title: "Today's Plan", content: makeUpcomingContent(), extraButtonTitle: "View details")
    private lazy var streaksCard = MiniCardView(icon: "flame.fill", text: streakMsg)
    private lazy var remindersSection = makeRemindersSection()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        nameLabel.text = userName
        setupViews()
        setupConstraints()
        setupActions()
    }

    // MARK: - Setup Views
    private func setupViews() {
        // Header
        view.addSubview(scrollView)
        scrollView.addSubview(contentStack)
        let headerStack = UIStackView(arrangedSubviews: [
            VStackView([greetingLabel, nameLabel, headerSubLabel], spacing: 3), profileImageView
        ])
        headerStack.axis = .horizontal
        headerStack.spacing = 12
        headerStack.alignment = .center
        headerStack.distribution = .fill
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.addArrangedSubview(headerStack)
        // Cards
        contentStack.addArrangedSubview(overviewCard)
        contentStack.addArrangedSubview(insightCard)
        contentStack.addArrangedSubview(quickActionsSection)
        contentStack.addArrangedSubview(upcomingCard)
        contentStack.addArrangedSubview(streaksCard)
        contentStack.addArrangedSubview(remindersSection)
    }

    // MARK: - Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 34),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -34),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),

            profileImageView.widthAnchor.constraint(equalToConstant: 54),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor)
        ])
    }

    // MARK: - Actions
    private func setupActions() {
        quickActionsSection.buttons.forEach { btn in
            btn.addTarget(self, action: #selector(handleQuickAction(_:)), for: .touchUpInside)
        }
        upcomingCard.extraButton?.addTarget(self, action: #selector(viewDetailsTapped), for: .touchUpInside)
    }

    @objc private func handleQuickAction(_ sender: UIButton) {
        let actions = ["Log Workout", "Log Meal", "Track Water", "Health Check-in"]
        let idx = sender.tag
        print("Quick Action Tapped: \(actions[safe: idx] ?? "Unknown")")
    }

    @objc private func viewDetailsTapped() {
        print("View details tapped on Today's Plan")
    }

    // MARK: - Section Builders
    private func makeOverviewContent() -> UIView {
        let icons = ["figure.walk", "flame.fill", "fork.knife", "drop.fill"]
        let values = [steps, caloriesBurned, caloriesEaten, waterIntake]
        let names = ["Steps", "Calories Burned", "Calories Eaten", "Water Intake"]
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 0
        for i in 0..<4 {
            let v = MetricView(icon: icons[i], value: values[i], label: names[i])
            stack.addArrangedSubview(v)
        }
        return stack
    }
    private func makeInsightContent() -> UIView {
        let icon = UIImageView(image: UIImage(systemName: "moon.zzz.fill"))
        icon.tintColor = UIColor(red: 0, green: 0.47, blue: 0.38, alpha: 1)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.widthAnchor.constraint(equalToConstant: 26).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 26).isActive = true
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 0, green: 0.35, blue: 0.28, alpha: 1)
        label.text = insightMsg
        let h = UIStackView(arrangedSubviews: [icon, label])
        h.axis = .horizontal
        h.alignment = .center
        h.spacing = 10
        h.translatesAutoresizingMaskIntoConstraints = false
        return h
    }
    private func makeQuickActionsSection() -> QuickActionsView {
        let actions = [
            ("Log Workout", "figure.strengthtraining.traditional"),
            ("Log Meal", "fork.knife.circle.fill"),
            ("Track Water", "drop.fill"),
            ("Health Check-in", "waveform.path.ecg")
        ]
        let qa = QuickActionsView(actions: actions)
        return qa
    }
    private func makeUpcomingContent() -> UIView {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 0, green: 0.32, blue: 0.19, alpha: 1)
        label.text = hasPlanned ? "\u2022 \(upcomingWorkout)\n\u2022 \(upcomingMeal)" : "No activities planned today"
        return label
    }
    private func makeRemindersSection() -> UIView {
        let v = CardView(title: "Reminders", style: .minimal)
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        reminders.forEach { str in
            let l = UILabel()
            l.text = "• " + str
            l.font = UIFont.systemFont(ofSize: 16)
            l.textColor = UIColor(red: 0, green: 0.34, blue: 0.23, alpha: 1)
            stack.addArrangedSubview(l)
        }
        v.setContent(stack)
        return v
    }
}

// MARK: - Helper Views and Extensions

/// Resilient array indexing
fileprivate extension Array {
    subscript(safe index: Int) -> Element? {
        (indices.contains(index)) ? self[index] : nil
    }
}

/// UIKit vertical stack helper (simulate SwiftUI's VStack)
fileprivate func VStackView(_ views: [UIView], spacing: CGFloat = 0) -> UIStackView {
    let sv = UIStackView(arrangedSubviews: views)
    sv.axis = .vertical
    sv.spacing = spacing
    sv.translatesAutoresizingMaskIntoConstraints = false
    return sv
}

/// Card style
fileprivate enum CardStyle { case normal, highlighted, minimal }

/// Generic card with title & custom content
fileprivate class CardView: UIView {
    let titleLabel = UILabel()
    let container = UIView()
    weak var extraButton: UIButton?
    var buttons: [UIButton] = []
    init(title: String, content: UIView? = nil, style: CardStyle = .normal, extraButtonTitle: String? = nil) {
        super.init(frame: .zero)
        backgroundColor = (style == .highlighted) ? UIColor(red: 243/255, green: 253/255, blue: 249/255, alpha: 1) : .white
        layer.cornerRadius = 21
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = (style == .minimal) ? 0.10 : 0.13
        layer.shadowOffset = CGSize(width: 0, height: 7)
        layer.shadowRadius = 17
        layer.masksToBounds = false
        translatesAutoresizingMaskIntoConstraints = false
        // Title
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textColor = UIColor(red: 10/255, green: 63/255, blue: 52/255, alpha: 1)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        // Content container
        container.translatesAutoresizingMaskIntoConstraints = false
        if let c = content { container.addSubview(c) }
        // Layout
        addSubview(titleLabel)
        addSubview(container)
        if let btnTitle = extraButtonTitle {
            let btn = UIButton(type: .system)
            btn.setTitle(btnTitle, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            btn.setTitleColor(UIColor(named: "OnboardingGreen2") ?? UIColor(red: 2/255, green: 115/255, blue: 86/255, alpha: 1), for: .normal)
            btn.contentHorizontalAlignment = .right
            btn.translatesAutoresizingMaskIntoConstraints = false
            addSubview(btn)
            extraButton = btn
            NSLayoutConstraint.activate([
                btn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
                btn.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                btn.heightAnchor.constraint(equalToConstant: 28)
            ])
        }
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -18),
            container.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 13),
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        if let c = content {
            NSLayoutConstraint.activate([
                c.topAnchor.constraint(equalTo: container.topAnchor),
                c.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                c.trailingAnchor.constraint(equalTo: container.trailingAnchor),
                c.bottomAnchor.constraint(equalTo: container.bottomAnchor)
            ])
        }
    }
    func setContent(_ v: UIView) {
        container.subviews.forEach { $0.removeFromSuperview() }
        container.addSubview(v)
        NSLayoutConstraint.activate([
            v.topAnchor.constraint(equalTo: container.topAnchor),
            v.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            v.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

/// For metrics in overview section
fileprivate class MetricView: UIView {
    init(icon: String, value: String, label: String) {
        super.init(frame: .zero)
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        let iconView = UIImageView(image: UIImage(systemName: icon))
        iconView.tintColor = UIColor(red: 2/255, green: 115/255, blue: 86/255, alpha: 1)
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 28),
            iconView.heightAnchor.constraint(equalToConstant: 28)
        ])
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        valueLabel.textAlignment = .center
        valueLabel.textColor = .black
        let nameLabel = UILabel()
        nameLabel.text = label
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        nameLabel.textColor = UIColor(white: 0.43, alpha: 1)
        nameLabel.textAlignment = .center
        let stack = UIStackView(arrangedSubviews: [iconView, valueLabel, nameLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 2
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

/// 2x2 Quick Actions grid
fileprivate class QuickActionsView: UIView {
    let buttons: [UIButton]
    init(actions: [(String, String)]) {
        self.buttons = actions.enumerated().map { idx, tuple in
            let btn = UIButton(type: .system)
            btn.setTitle(tuple.0, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            btn.setTitleColor(UIColor(red: 11/255, green: 63/255, blue: 40/255, alpha: 1), for: .normal)
            btn.backgroundColor = UIColor(red: 234/255, green: 253/255, blue: 241/255, alpha: 1)
            btn.layer.cornerRadius = 18
            btn.titleLabel?.textAlignment = .center
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.tag = idx
            let icon = UIImageView(image: UIImage(systemName: tuple.1))
            icon.tintColor = UIColor(red: 2/255, green: 115/255, blue: 86/255, alpha: 1)
            icon.contentMode = .scaleAspectFit
            icon.translatesAutoresizingMaskIntoConstraints = false
            btn.addSubview(icon)
            NSLayoutConstraint.activate([
                icon.topAnchor.constraint(equalTo: btn.topAnchor, constant: 13),
                icon.centerXAnchor.constraint(equalTo: btn.centerXAnchor),
                icon.widthAnchor.constraint(equalToConstant: 28),
                icon.heightAnchor.constraint(equalToConstant: 28),
                btn.titleLabel!.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 2)
            ])
            return btn
        }
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        let grid = UIStackView()
        grid.axis = .vertical
        grid.spacing = 13
        grid.translatesAutoresizingMaskIntoConstraints = false
        for row in 0..<2 {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 13
            rowStack.distribution = .fillEqually
            rowStack.translatesAutoresizingMaskIntoConstraints = false
            for col in 0..<2 { rowStack.addArrangedSubview(buttons[row*2 + col]) }
            grid.addArrangedSubview(rowStack)
        }
        addSubview(grid)
        NSLayoutConstraint.activate([
            grid.topAnchor.constraint(equalTo: topAnchor),
            grid.leadingAnchor.constraint(equalTo: leadingAnchor),
            grid.trailingAnchor.constraint(equalTo: trailingAnchor),
            grid.bottomAnchor.constraint(equalTo: bottomAnchor),
            grid.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

/// Streak/mini motivation card
fileprivate class MiniCardView: UIView {
    init(icon: String, text: String) {
        super.init(frame: .zero)
        backgroundColor = .white
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.10
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        layer.masksToBounds = false
        translatesAutoresizingMaskIntoConstraints = false
        let iconView = UIImageView(image: UIImage(systemName: icon))
        iconView.tintColor = UIColor(red: 2/255, green: 115/255, blue: 86/255, alpha: 1)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 2
        label.textColor = UIColor(red: 10/255, green: 63/255, blue: 52/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        let hstack = UIStackView(arrangedSubviews: [iconView, label])
        hstack.axis = .horizontal
        hstack.spacing = 10
        hstack.alignment = .center
        hstack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(hstack)
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 30),
            iconView.heightAnchor.constraint(equalToConstant: 30),
            hstack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            hstack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            hstack.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            hstack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11)
        ])
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

