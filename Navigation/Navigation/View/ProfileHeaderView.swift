//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by  Alena Sabadash on 10.03.2022.
//

import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "ProfileHeaderView"
    
    private var statusText: String?
    
    var errorLabelTopAnchor: NSLayoutConstraint?
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "doggie")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame.size.width = 200
        imageView.frame.size.height = 200
        imageView.layer.borderWidth = 3
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.frame.size.width / 3
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hipster Cat"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.text = "Doing something..."
        return label
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Указать статус"
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.backgroundColor = UIColor.white.cgColor
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 15)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        return textField
    }()
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    private func setupView() {
        self.addSubview(infoStackView)
        self.addSubview(setStatusButton)
        self.infoStackView.addArrangedSubview(avatarImageView)
        self.infoStackView.addArrangedSubview(labelsStackView)
        self.labelsStackView.addArrangedSubview(fullNameLabel)
        self.labelsStackView.addArrangedSubview(statusLabel)
        self.labelsStackView.addArrangedSubview(statusTextField)
        
        let imageViewAspectRatio = self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1.0)
        
        let topConstraint = self.infoStackView.topAnchor.constraint(equalTo: self.topAnchor)
        let leadingConstraint = self.infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        let trailingConstraint = self.infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        
        let buttonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 20)
        
        let leadingButtonConstraint = self.setStatusButton.leadingAnchor.constraint(equalTo: self.infoStackView.leadingAnchor)
        let trailingButtonConstraint = self.setStatusButton.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor)
        let bottomButtonConstraint = self.setStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        
        NSLayoutConstraint.activate([
            imageViewAspectRatio,
            topConstraint,
            leadingConstraint,
            trailingConstraint,
            buttonTopConstraint,
            leadingButtonConstraint,
            trailingButtonConstraint,
            bottomButtonConstraint,
            self.errorLabelTopAnchor
        ].compactMap({ $0 }))
    }

    @objc func buttonPressed() {
        if statusTextField.text?.count == 0 {
            UIView.animate(withDuration: 0.3) {
                self.statusTextField.layer.borderColor = UIColor.systemRed.cgColor
                self.contentView.layoutIfNeeded()
            }
        } else {
            statusLabel.text = statusText
            statusTextField.text = ""
        }
    }

    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text
        UIView.animate(withDuration: 0.3) {
            self.statusTextField.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
}
