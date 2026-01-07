import UIKit

/// Production-ready Sign Up screen matching the provided UI design (programmatic UIKit, Auto Layout, iOS 15+)
class SignUpViewController: UIViewController {
    // MARK: - UI Components

    // Navigation section
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
        label.text = "Sign up"
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
        label.textColor = UIColor(white: 0.4, alpha: 1) // Light gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Form fields
    private let usernameField = SignUpField(label: "Username", placeholder: "John Doe", keyboardType: .default)
    private let emailField = SignUpField(label: "Email", placeholder: "example@gmail.com", keyboardType: .emailAddress)
    private let phoneField = SignUpField(label: "Phone number", placeholder: "+250 ***********", keyboardType: .phonePad)
    
    // Password field with show/hide
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

    // Terms and policies
    private let termsCheckbox: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "square"), for: .normal)
        btn.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        btn.tintColor = UIColor(white: 0.22, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    private let termsLabel: UILabel = {
        let label = UILabel()
        label.text = "I agree to terms and policies"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Signup Button
    private let signupButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Signup", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        btn.backgroundColor = UIColor(named: "OnboardingGreen2") ?? UIColor(red: 2/255, green: 115/255, blue: 86/255, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 28
        btn.isEnabled = false
        btn.alpha = 0.55
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    // Footer
    private let footerButton: UIButton = {
        let button = UIButton(type: .system)
        let attrStr = NSMutableAttributedString(
            string: "Already have an account? ",
            attributes: [
                .foregroundColor: UIColor.label,
                .font: UIFont.systemFont(ofSize: 16)
            ]
        )
        attrStr.append(NSAttributedString(
            string: "login",
            attributes: [
                .foregroundColor: UIColor(named: "OnboardingGreen2") ?? UIColor(red: 2/255, green: 115/255, blue: 86/255, alpha: 1),
                .font: UIFont.systemFont(ofSize: 16, weight: .semibold)
            ]))
        button.setAttributedTitle(attrStr, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // StackView for vertical fields
    private let fieldsStack: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.spacing = 20
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    // For responsive layout on smaller devices
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

    /// Adds views to the hierarchy and arranges them logically.
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        // Top bar (back + title + subtitle)
        contentView.addSubview(backButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)

        // Stack for all fields
        contentView.addSubview(fieldsStack)
        [usernameField, emailField, phoneField].forEach { fieldsStack.addArrangedSubview($0) }

        // Password field (label + field + eye)
        let pwStack = UIStackView(arrangedSubviews: [passwordLabel, passwordField])
        pwStack.axis = .vertical
        pwStack.spacing = 8
        pwStack.translatesAutoresizingMaskIntoConstraints = false
        fieldsStack.addArrangedSubview(pwStack)
        // Add eye icon inside password text field
        passwordField.rightView = passwordToggle
        passwordField.rightViewMode = .always

        // Terms row
        let termsRow = UIStackView(arrangedSubviews: [termsCheckbox, termsLabel])
        termsRow.axis = .horizontal
        termsRow.spacing = 12
        termsRow.alignment = .center
        termsRow.translatesAutoresizingMaskIntoConstraints = false
        fieldsStack.addArrangedSubview(termsRow)

        // Signup button
        contentView.addSubview(signupButton)
        // Footer
        contentView.addSubview(footerButton)
    }

    /// Sets up Auto Layout constraints for all UI elements
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // ScrollView full-screen
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

            // Fields stack (after subtitle)
            fieldsStack.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 34),
            fieldsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            fieldsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            // PasswordField height
            passwordField.heightAnchor.constraint(equalToConstant: 46),

            // Terms checkbox sizing
            termsCheckbox.widthAnchor.constraint(equalToConstant: 26),
            termsCheckbox.heightAnchor.constraint(equalToConstant: 26),

            // Signup button
            signupButton.topAnchor.constraint(equalTo: fieldsStack.bottomAnchor, constant: 34),
            signupButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            signupButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            signupButton.heightAnchor.constraint(equalToConstant: 56),

            // Footer
            footerButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 20),
            footerButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            footerButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -24)
        ])
    }

    /// Wires up interactive logic (checkbox, toggle password, button, etc.)
    private func setupActions() {
        // Dismiss keyboard on tap outside
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        tap.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(tap)

        // Checkbox
        termsCheckbox.addTarget(self, action: #selector(didTapCheckbox), for: .touchUpInside)
        // Password eye icon
        passwordToggle.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        // Form field change: check enable/disable signup
        [usernameField.textField, emailField.textField, phoneField.textField, passwordField].forEach {
            $0.addTarget(self, action: #selector(formChanged), for: .editingChanged)
        }
        // Signup tap
        signupButton.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)
        // Footer login
        footerButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }

    // MARK: - Actions
    @objc private func endEditing() { view.endEditing(true) }

    @objc private func didTapCheckbox() {
        termsCheckbox.isSelected.toggle()
        updateSignupButtonState()
    }
    
    @objc private func togglePasswordVisibility() {
        passwordField.isSecureTextEntry.toggle()
        let symbol = passwordField.isSecureTextEntry ? "eye.slash" : "eye"
        passwordToggle.setImage(UIImage(systemName: symbol), for: .normal)
    }

    @objc private func formChanged() { updateSignupButtonState() }

    @objc private func signupTapped() {
        view.endEditing(true)
        // Validate email & password
        guard let email = emailField.text, email.isValidEmail else {
            showAlert(message: "Please enter a valid email.")
            return
        }
        guard let password = passwordField.text, password.count >= 6 else {
            showAlert(message: "Password must be at least 6 characters.")
            return
        }
        print("Username:", usernameField.text ?? "")
        print("Email:", emailField.text ?? "")
        print("Phone:", phoneField.text ?? "")
        print("Password:", password) // In production, don't print sensitive info
        // TODO: Connect to backend / proceed to next flow
        showAlert(title: "Success", message: "Signed up successfully!")
    }

    @objc private func loginTapped() {
        // Handle login navigation
        print("Navigate to Login screen")
    }

    // MARK: - UI/Logic Helpers
    private func updateSignupButtonState() {
        let allFilled = [usernameField.text, emailField.text, phoneField.text, passwordField.text]
            .allSatisfy { !($0?.isEmpty ?? true) }
        let canSignup = termsCheckbox.isSelected && allFilled
        signupButton.isEnabled = canSignup
        signupButton.alpha = canSignup ? 1.0 : 0.55
    }

    private func showAlert(title: String = "", message: String) {
        let ac = UIAlertController(title: title.isEmpty ? nil : title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
    }
}

// MARK: - Helper Views
/// Single form field (label + rounded text field)
private class SignUpField: UIView {
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

