//
//  InfoViewController.swift
//  Navigation
//
//  Created by  Alena Sabadash on 05.03.2022.
//

import UIKit

class InfoViewController: UIViewController {

    private lazy var alertButton: UIButton = {
        let button = UIButton()
        button.setTitle("alert", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(didTapInfoButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let alertController = UIAlertController(
        title: "Alert title",
        message: "Message to display",
        preferredStyle: .alert
    )

    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        print("Ok button tapped");
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { _ in
        print("Cancel button tapped");
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(alertButton)
        self.alertButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.alertButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.alertButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.alertButton.heightAnchor.constraint(equalToConstant: 250).isActive = true
        self.alertController.addAction(okAction)
        self.alertController.addAction(cancelAction)
    }

    @objc private func didTapInfoButton() {
        present(alertController, animated: true, completion: nil)
    }

}
