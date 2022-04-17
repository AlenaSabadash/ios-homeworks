//
//  AnimationViewController.swift
//  Navigation
//
//  Created by  Alena Sabadash on 06.04.2022.
//

import UIKit

class AnimationViewController: UIViewController {
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "doggie")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame.size.width = avatarDefaultWidth
        imageView.frame.size.height = avatarDefaultWidth
        imageView.layer.borderWidth = 3
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var dimmedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.isHidden = true
        view.alpha = 0
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        let buttonImage = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24))
        button.setImage(buttonImage, for: .normal)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.tintColor = .white
        button.isHidden = true
        button.alpha = 0
        button.addTarget(self, action: #selector(closeButtonPressed), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private let avatarTapGestureRecognizer = UITapGestureRecognizer()
    
    private var avatarWidthConstraint: NSLayoutConstraint?
    private var avatarHeightConstraint: NSLayoutConstraint?
    private var avatarImageViewTopAnchor: NSLayoutConstraint?
    private var avatarImageViewLeftAnchor: NSLayoutConstraint?
    private let avatarDefaultWidth: CGFloat = 200
    private var avatarPadding: CGFloat = 12
    private var isAvatarExpand = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        setupView()
        setupGesture()
    }
    
    private func setupView() {
        self.view.addSubview(avatarImageView)
        self.view.addSubview(dimmedView)
        self.view.addSubview(closeButton)
        self.view.bringSubviewToFront(avatarImageView)
        self.view.bringSubviewToFront(closeButton)
        
        self.avatarWidthConstraint = avatarImageView.widthAnchor.constraint(equalToConstant: avatarDefaultWidth)
        self.avatarHeightConstraint = avatarImageView.heightAnchor.constraint(equalToConstant: avatarDefaultWidth)
        
        self.avatarImageViewTopAnchor = avatarImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 12)
        self.avatarImageViewLeftAnchor = avatarImageView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 12)
        
        let dimmedViewConstraints = [
            dimmedView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            dimmedView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
        ]
        
        let closeButtonConstraint = [
            closeButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 12),
            closeButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -12),
        ]
        
        NSLayoutConstraint.activate([
            self.avatarWidthConstraint,
            self.avatarHeightConstraint,
            self.avatarImageViewTopAnchor,
            self.avatarImageViewLeftAnchor
        ].compactMap({ $0 }) + dimmedViewConstraints + closeButtonConstraint)
    }
    
    private func setupGesture() {
        self.avatarTapGestureRecognizer.addTarget(self, action: #selector(self.handleAvatarTap(_:)))
        self.avatarImageView.addGestureRecognizer(self.avatarTapGestureRecognizer)
    }

    @objc private func handleAvatarTap(_ gestureRecognizer: UITapGestureRecognizer) {
        guard self.avatarTapGestureRecognizer === gestureRecognizer else { return }
        
        self.isAvatarExpand.toggle()
        self.avatarImageView.isUserInteractionEnabled = false
        
        self.avatarWidthConstraint?.constant = self.isAvatarExpand ? self.view.bounds.width : avatarDefaultWidth
        self.avatarHeightConstraint?.constant = self.isAvatarExpand ? self.view.bounds.height / 2 : avatarDefaultWidth
        
        if self.isAvatarExpand {
            self.closeButton.isHidden = false
            self.dimmedView.isHidden = false
        }
        
        UIView.animate(withDuration: 0.5) {
            self.dimmedView.alpha = self.isAvatarExpand ? 0.5 : 0
            self.avatarImageView.layer.cornerRadius = 0
            self.avatarImageViewTopAnchor?.constant = 0
            self.avatarImageViewLeftAnchor?.constant = 0
            
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dimmedView.isHidden = !self.isAvatarExpand
            
            UIView.animate(withDuration: 0.3) {
                self.closeButton.alpha = self.isAvatarExpand ? 1 : 0
            } completion: { _ in
                self.closeButton.isHidden = !self.isAvatarExpand
            }
        }
        
    }
    
    @objc private func closeButtonPressed() {
        self.isAvatarExpand.toggle()
        self.avatarImageView.isUserInteractionEnabled = true
        
        UIView.animate(withDuration: 0.3) {
            self.closeButton.alpha = self.isAvatarExpand ? 1 : 0
        } completion: { _ in
            self.closeButton.isHidden = !self.isAvatarExpand

            UIView.animate(withDuration: 0.5) {
                self.avatarImageViewTopAnchor?.constant = self.avatarPadding
                self.avatarImageViewLeftAnchor?.constant = self.avatarPadding
                self.avatarWidthConstraint?.constant = self.isAvatarExpand ? self.view.bounds.width : self.avatarDefaultWidth
                self.avatarHeightConstraint?.constant = self.isAvatarExpand ? self.view.bounds.height : self.avatarDefaultWidth
                self.avatarImageView.layer.cornerRadius = self.avatarDefaultWidth / 2
                self.dimmedView.alpha = self.isAvatarExpand ? 0.5 : 0
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.dimmedView.isHidden = !self.isAvatarExpand
            }

        }

    }
}
        
