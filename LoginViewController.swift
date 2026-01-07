import UIKit

/// Production-ready Login screen matching the provided UI design (programmatic UIKit, Auto Layout, iOS 15+)
class LoginViewController: UIViewController {
    // MARK: - UI Components

    // Navigation/Top
    private let backButton: UIButton = {
        let btn = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)
        btn.setImage(UIImage(systemName: "chevron.left", withConfiguration: config), for: .normal)
        btn.tintColor = .label
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hi, welcome back to health"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor(white: 0.4, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Email field
    private let emailField = LoginField(label: "Email", placeholder: "example@gmail.com", keyboardType: .emailAddress)
    // Password field (with label and eye toggle)
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let passwordField: UITextField = {
        let tf = UITextField()
        tf.isSecureTextEntry = true
        tf.placeholder = "••••••••"
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.autocorrectionType = .no
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 40))
        tf.leftViewMode = .always
        tf.layer.cornerRadius = 9
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(white: 0.82, alpha: 1).cgColor
        tf.backgroundColor = .systemBackground
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return tf
    }()
    private let passwordToggle: UIButton = {
        let btn = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 19, weight: .regular)
        btn.setImage(UIImage(systemName: "eye.slash", withConfiguration: config), for: .normal)
        btn.tintColor = UIColor(white: 0.6, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    // Remember me & Forgot
    private let rememberCheckbox: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "square"), for: .normal)
        btn.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        btn.tintColor = UIColor(white: 0.22, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    private let rememberLabel: UILabel = {
        let label = UILabel()
        label.text = "Remember me"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let forgotButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Forgot password", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        btn.setTitleColor(UIColor(named: "OnboardingGreen2") ?? UIColor(red: 2/255, green: 115/255, blue: 86/255, alpha: 1), for: .normal)
        btn.contentHorizontalAlignment = .right
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    // Login Button
    private let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Login", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        btn.backgroundColor = UIColor(named: "OnboardingGreen2") ?? UIColor(red: 2/255, green: 115/255, blue: 86/255, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 28
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isEnabled = true
        btn.alpha = 1.0
        return btn
    }()

    // Or divider
    private let dividerLabel: UILabel = {
        let label = UILabel()
        label.text = "or"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(white: 0.57, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let leftDivider: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0.88, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    private let rightDivider: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0.88, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    // Social buttons
    private let googleButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign in with google", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        btn.backgroundColor = .white
        btn.setTitleColor(.label, for: .normal)
        btn.layer.cornerRadius = 25
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor(white: 0.82, alpha: 1).cgColor
        btn.contentHorizontalAlignment = .left
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 60)
        btn.translatesAutoresizingMaskIntoConstraints = false
        // Add Google logo via UIImageView on the right later
        return btn
    }()
    private let googleLogo: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "google"))
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let facebookButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign in with facebook", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        btn.backgroundColor = .white
        btn.setTitleColor(.label, for: .normal)
        btn.layer.cornerRadius = 25
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor(white: 0.82, alpha: 1).cgColor
        btn.contentHorizontalAlignment = .left
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 60)
        btn.translatesAutoresizingMaskIntoConstraints = false
        // Add Facebook logo via UIImageView on the right later
        return btn
    }()
    private let facebookLogo: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "facebook"))
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    // Footer
    private let footerButton: UIButton = {
        let btn = UIButton(type: .system)
        let attrStr = NSMutableAttributedString(
            string: "Don’t have an account? ",
            attributes: [
                .foregroundColor: UIColor.label,
                .font: UIFont.systemFont(ofSize: 16)
            ]
        )
        attrStr.append(NSAttributedString(
            string: "signup",
            attributes: [
                .foregroundColor: UIColor(named: "OnboardingGreen2") ?? UIColor(red: 2/255, green: 115/255, blue: 86/255, alpha: 1),
                .font: UIFont.systemFont(ofSize: 16, weight: .semibold)
            ]))
        btn.setAttributedTitle(attrStr, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    // StackView for form
    private let fieldsStack: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.spacing = 20
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    // Responsive layout
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.alwaysBounceVertical = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    private let contentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        setupConstraints()
        setupActions()
    }

    // MARK: - Setup Methods
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        // Top bar
        contentView.addSubview(backButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)

        // Form stack
        contentView.addSubview(fieldsStack)
        fieldsStack.addArrangedSubview(emailField)
        // Password (with label + field)
        let pwStack = UIStackView(arrangedSubviews: [passwordLabel, passwordField])
        pwStack.axis = .vertical
        pwStack.spacing = 8
        pwStack.translatesAutoresizingMaskIntoConstraints = false
        fieldsStack.addArrangedSubview(pwStack)
        // Add eye icon inside password text field
        passwordField.rightView = passwordToggle
        passwordField.rightViewMode = .always

        // Remember me & Forgot
        let rememberRow = UIStackView(arrangedSubviews: [rememberCheckbox, rememberLabel])
        rememberRow.axis = .horizontal
        rememberRow.spacing = 8
        let forgotSpacer = UIView()
        forgotSpacer.translatesAutoresizingMaskIntoConstraints = false
        forgotSpacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        let row = UIStackView(arrangedSubviews: [rememberRow, forgotSpacer, forgotButton])
        row.axis = .horizontal
        row.alignment = .center
        row.distribution = .fill
        row.translatesAutoresizingMaskIntoConstraints = false
        fieldsStack.addArrangedSubview(row)

        // Login button
        contentView.addSubview(loginButton)

        // Or divider row
        let dividerStack = UIStackView(arrangedSubviews: [leftDivider, dividerLabel, rightDivider])
        dividerStack.axis = .horizontal
        dividerStack.alignment = .center
        dividerStack.spacing = 10
        dividerStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dividerStack)

        // Social
        contentView.addSubview(googleButton)
        contentView.addSubview(facebookButton)
        googleButton.addSubview(googleLogo)
        facebookButton.addSubview(facebookLogo)

        // Footer
        contentView.addSubview(footerButton)
        // Tagging for reference in actions
        footerButton.accessibilityIdentifier = "signupFooter"
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // ScrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            // ContentView inside scrollView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            // Top bar
            backButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            backButton.widthAnchor.constraint(equalToConstant: 38),
            backButton.heightAnchor.constraint(equalToConstant: 36),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            subtitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            // Fields stack
            fieldsStack.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 34),
            fieldsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            fieldsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            // Password field height
            passwordField.heightAnchor.constraint(equalToConstant: 46),
            // Remember checkbox size
            rememberCheckbox.widthAnchor.constraint(equalToConstant: 22),
            rememberCheckbox.heightAnchor.constraint(equalToConstant: 22),

            // Login button
            loginButton.topAnchor.constraint(equalTo: fieldsStack.bottomAnchor, constant: 34),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 56),

            // Divider
            leftDivider.heightAnchor.constraint(equalToConstant: 1),
            rightDivider.heightAnchor.constraint(equalToConstant: 1),
            leftDivider.widthAnchor.constraint(greaterThanOrEqualToConstant: 20),
            rightDivider.widthAnchor.constraint(greaterThanOrEqualToConstant: 20),
            dividerLabel.centerYAnchor.constraint(equalTo: leftDivider.centerYAnchor),
            dividerStack.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 26),
            dividerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28),
            dividerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -28),

            // Google button
            googleButton.topAnchor.constraint(equalTo: dividerStack.bottomAnchor, constant: 24),
            googleButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            googleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            googleButton.heightAnchor.constraint(equalToConstant: 50),
            // Google logo
            googleLogo.widthAnchor.constraint(equalToConstant: 24),
            googleLogo.heightAnchor.constraint(equalToConstant: 24),
            googleLogo.trailingAnchor.constraint(equalTo: googleButton.trailingAnchor, constant: -22),
            googleLogo.centerYAnchor.constraint(equalTo: googleButton.centerYAnchor),

            // Facebook button
            facebookButton.topAnchor.constraint(equalTo: googleButton.bottomAnchor, constant: 16),
            facebookButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            facebookButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            facebookButton.heightAnchor.constraint(equalToConstant: 50),
            // Facebook logo
            facebookLogo.widthAnchor.constraint(equalToConstant: 24),
            facebookLogo.heightAnchor.constraint(equalToConstant: 24),
            facebookLogo.trailingAnchor.constraint(equalTo: facebookButton.trailingAnchor, constant: -22),
            facebookLogo.centerYAnchor.constraint(equalTo: facebookButton.centerYAnchor),

            // Footer
            footerButton.topAnchor.constraint(equalTo: facebookButton.bottomAnchor, constant: 22),
            footerButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            footerButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -24)
        ])
    }

    private func setupActions() {
        // Dismiss keyboard on tap outside
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        tap.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(tap)

        // Remember me
        rememberCheckbox.addTarget(self, action: #selector(toggleRememberMe), for: .touchUpInside)
        passwordToggle.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        forgotButton.addTarget(self, action: #selector(forgotTapped), for: .touchUpInside)
        footerButton.addTarget(self, action: #selector(signupFooterTapped), for: .touchUpInside)
    }

    // MARK: - Actions
    @objc private func endEditing() { view.endEditing(true) }

    @objc private func toggleRememberMe() { rememberCheckbox.isSelected.toggle() }
    
    @objc private func togglePasswordVisibility() {
        passwordField.isSecureTextEntry.toggle()
        let symbol = passwordField.isSecureTextEntry ? "eye.slash" : "eye"
        passwordToggle.setImage(UIImage(systemName: symbol), for: .normal)
    }

    @objc private func loginTapped() {
        view.endEditing(true)
        guard let email = emailField.text, email.isValidEmail else {
            showAlert(message: "Please enter a valid email.")
            return
        }
        guard let password = passwordField.text, password.count >= 6 else {
            showAlert(message: "Password must be at least 6 characters.")
            return
        }
        print("Email:", email)
        print("Password:", password)
        print("Remember me:", rememberCheckbox.isSelected)
        showAlert(title: "Success", message: "Login successful!")
    }
    @objc private func forgotTapped() {
        showAlert(message: "Forgot password tapped")
    }
    @objc private func signupFooterTapped() {
        // Handle SIGNUP navigation
        print("Navigate to Signup screen")
    }
    // MARK: - Helpers
    private func showAlert(title: String = "", message: String) {
        let ac = UIAlertController(title: title.isEmpty ? nil : title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

// MARK: - Helper Views
/// Single form field (label + rounded text field)
private class LoginField: UIView {
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let textField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.layer.cornerRadius = 9
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(white: 0.82, alpha: 1).cgColor
        tf.backgroundColor = .systemBackground
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 40))
        tf.leftViewMode = .always
        tf.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return tf
    }()
    
    var text: String? { textField.text }
    
    init(label: String, placeholder: String, keyboardType: UIKeyboardType) {
        super.init(frame: .zero)
        self.label.text = label
        textField.placeholder = placeholder
        textField.keyboardType = keyboardType
        addSubview(self.label)
        addSubview(textField)
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: topAnchor),
            self.label.leadingAnchor.constraint(equalTo: leadingAnchor),
            self.label.trailingAnchor.constraint(equalTo: trailingAnchor),

            textField.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 7),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 46),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - String Validator
private extension String {
    var isValidEmail: Bool {
        let regex = try! NSRegularExpression(pattern: "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")
        let range = NSRange(self.startIndex..., in: self)
        return regex.firstMatch(in: self, options: [], range: range) != nil
    }
}

