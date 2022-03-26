//
//  LogInViewController.swift
//  Navigation
//
//  Created by  Alena Sabadash on 22.03.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
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
    
    private func setupGesture() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    private func setupView() {
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
        
        logInView.logInButton.addTarget(self, action: #selector(logInButtonPressed), for: UIControl.Event.touchUpInside)
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
        
        view.frame.origin.y = 0 - keyboardSize.height
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
    @objc func logInButtonPressed()  {
        let profileVC = ProfileViewController()
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
}
