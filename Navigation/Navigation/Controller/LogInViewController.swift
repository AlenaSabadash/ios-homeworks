//
//  LogInViewController.swift
//  Navigation
//
//  Created by  Alena Sabadash on 22.03.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    var activeTextField : UITextField? = nil
    private let passwordMinLength = 8

    private lazy var logInView: LogInView = {
        let view = LogInView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let alertController = UIAlertController(
        title: "Ошибка авторизации",
        message: "Неверно указаны логин или пароль",
        preferredStyle: .alert
    )

    let okAction = UIAlertAction(title: "OK", style: .default)
    
    var activeField: UITextField?

    private func setupGesture() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.logInView.passwordTextField.addTarget(self, action: #selector(self.handlePasswordTextField), for: .editingChanged)
    }
    
    @objc private func handlePasswordTextField() {
        guard let password = self.logInView.passwordTextField.text else { return }
        
        switch password.count {
            case 0:
                logInView.errorLabel.isHidden = true
            case 1..<passwordMinLength:
                logInView.errorLabel.isHidden = false
                logInView.errorLabel.text = "Пароль меньше чем \(passwordMinLength) символов"
            default:
                logInView.errorLabel.isHidden = true
        }
        
        UIView.animate(withDuration: 0.3) {
            self.logInView.logInButtonTopAnchor?.constant = self.logInView.errorLabel.isHidden ? 16 : 40
            self.view.layoutIfNeeded()
        }
    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.logInView.loginTextField.delegate = self
        self.logInView.passwordTextField.delegate = self
    }

    private func setupView() {
        self.activeField = UITextField()

        view.addSubview(scrollView)
        scrollView.addSubview(logInView)

        let scrollViewTopConstraint = scrollView.topAnchor.constraint(equalTo: view.topAnchor)
        let scrollViewLeadingConstraint = scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let scrollViewTrailingConstraint = scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let scrollViewHeightConstraint = scrollView.heightAnchor.constraint(equalTo: view.heightAnchor)

        let logInViewTopConstraint = logInView.topAnchor.constraint(equalTo: scrollView.topAnchor)
        let logInViewLeadingConstraint = logInView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        let logInViewTrailingConstraint = logInView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        let logInViewHeightConstraint = logInView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)

        NSLayoutConstraint.activate([
            scrollViewTopConstraint,
            scrollViewLeadingConstraint,
            scrollViewTrailingConstraint,
            scrollViewHeightConstraint,
            logInViewTopConstraint,
            logInViewLeadingConstraint,
            logInViewTrailingConstraint,
            logInViewHeightConstraint
        ])

        logInView.loginTextField.delegate = self
        logInView.passwordTextField.delegate = self
        logInView.logInButton.addTarget(self, action: #selector(logInButtonPressed), for: UIControl.Event.touchUpInside)
        alertController.addAction(okAction)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        setupGesture()
        setupView()
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           return
        }

        var shouldMoveViewUp = false

        if let activeTextField = activeTextField {
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
            let topOfKeyboard = self.view.frame.height - keyboardSize.height

            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }

        if(shouldMoveViewUp) {
            self.view.frame.origin.y = 0 - keyboardSize.height
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }

    @objc func logInButtonPressed() {
        let isLoginValid = logInView.loginTextField.text?.elementsEqual("user")
        let isPasswordValid = logInView.passwordTextField.text?.elementsEqual("12345678")
        
        if let login = logInView.loginTextField.text, login.isEmpty,
           let password = logInView.passwordTextField.text, password.isEmpty {
            
            logInView.loginTextField.layer.borderColor = UIColor.systemRed.cgColor
            logInView.passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
            
        }
        
        if isLoginValid == false || isPasswordValid == false {
            present(alertController, animated: true, completion: nil)
        }
        else {
            let profileVC = ProfileViewController()
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
    
    private func isEmptyText(of textFields: [UITextField]) -> Bool {
        var notValidFields = [UITextField]()
        textFields.forEach({ field in
            if let text = field.text, text.isEmpty {
                notValidFields.append(field)
            }
        })
        
        if notValidFields.count > 0 {
            return true
        }
        
        return false
    }
}


extension LogInViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
      self.activeTextField = textField
    }
      
    func textFieldDidEndEditing(_ textField: UITextField) {
      self.activeTextField = nil
    }
  }
