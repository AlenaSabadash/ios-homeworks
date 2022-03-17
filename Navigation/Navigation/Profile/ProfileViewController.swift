//
//  ProfileViewController.swift
//  Navigation
//
//  Created by  Alena Sabadash on 04.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Профиль"
        self.view.backgroundColor = .lightGray
    }

    override func viewWillLayoutSubviews() {
        let headerView = ProfileHeaderView(frame: CGRect(x: 0, y: 100.0, width: view.bounds.width, height: view.bounds.height))
        self.view.addSubview(headerView)
    }
    
}
