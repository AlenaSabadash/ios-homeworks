//
//  LogInView.swift
//  Navigation
//
//  Created by  Alena Sabadash on 22.03.2022.
//

import UIKit

class LogInView: UIView {

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.image = UIImage(named: "logo")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email or phone"
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.backgroundColor = UIColor.systemGray6.cgColor
        textField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16)
        textField.autocorrectionType = .no
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.backgroundColor = UIColor.systemGray6.cgColor
        textField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        textField.textColor = .black
        textField.isSecureTextEntry = true
        textField.font = .systemFont(ofSize: 16)
        textField.autocorrectionType = .no
        return textField
    }()
    
    private lazy var loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 120
        return stackView
    }()
    
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    lazy var logInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "VkColorSet")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LogInView {
    private func setupView() {
        self.addSubview(loginStackView)
        self.addSubview(logInButton)
        self.loginStackView.addArrangedSubview(logoImageView)
        self.loginStackView.addArrangedSubview(textFieldsStackView)
        self.textFieldsStackView.addArrangedSubview(loginTextField)
        self.textFieldsStackView.addArrangedSubview(passwordTextField)
        
        let logoViewAspectRatio = self.logoImageView.heightAnchor.constraint(equalTo: self.logoImageView.widthAnchor, multiplier: 1.0)
        
        let topConstraint = self.loginStackView.topAnchor.constraint(equalTo: self.topAnchor)
        let leadingConstraint = self.loginStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let trailingConstraint = self.loginStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        
        let logInButtonTopConstraint = self.logInButton.topAnchor.constraint(equalTo: self.textFieldsStackView.bottomAnchor, constant: 16)

        let leadingButtonConstraint = self.logInButton.leadingAnchor.constraint(equalTo: self.textFieldsStackView.leadingAnchor)
        let trailingButtonConstraint = self.logInButton.trailingAnchor.constraint(equalTo: self.textFieldsStackView.trailingAnchor)
        let bottomButtonConstraint = self.logInButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        
        NSLayoutConstraint.activate([
            logoViewAspectRatio,
            topConstraint,
            leadingConstraint,
            trailingConstraint,
            logInButtonTopConstraint,
            leadingButtonConstraint,
            trailingButtonConstraint,
            bottomButtonConstraint,
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 120),
            textFieldsStackView.heightAnchor.constraint(equalToConstant: 100),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}