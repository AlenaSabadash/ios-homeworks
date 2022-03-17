//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by  Alena Sabadash on 10.03.2022.
//

import UIKit

class ProfileHeaderView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var showStatusButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        Bundle.main.loadNibNamed("ProfileHeaderView", owner: self, options: nil)
        addSubview(contentView)
        addSubview(avatar)

        contentView.backgroundColor = .lightGray

        avatar.image = UIImage(named: "doggie")
        avatar.frame.size.width = 150
        avatar.frame.size.height = 150
        avatar.layer.borderWidth = 3
        avatar.layer.masksToBounds = false
        avatar.layer.borderColor = UIColor.white.cgColor
        avatar.layer.cornerRadius = avatar.frame.size.width / 2
        avatar.clipsToBounds = true

        username.text = "Hipster Cat"
        username.textColor = .black
        username.font = UIFont.boldSystemFont(ofSize: 18.0)

        status.text = "Doing something..."
        status.textColor = .gray
        status.font = UIFont.systemFont(ofSize: 14.0)

        showStatusButton.setTitle("Show status", for: .normal)
        showStatusButton.setTitleColor(.white, for: .normal)
        showStatusButton.backgroundColor = UIColor.systemBlue
        showStatusButton.titleLabel?.textColor = .white
        showStatusButton.layer.cornerRadius = 4
        showStatusButton.layer.shadowColor = UIColor.black.cgColor
        showStatusButton.layer.shadowOpacity = 0.7
        showStatusButton.layer.shadowRadius = 4
        showStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        showStatusButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        showStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }

    @objc func buttonPressed() {
        let status = status.text ?? ""
        print("Status: \(status)")
    }

}
