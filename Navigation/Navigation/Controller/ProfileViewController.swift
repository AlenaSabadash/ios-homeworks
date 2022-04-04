//
//  ProfileViewController.swift
//  Navigation
//
//  Created by  Alena Sabadash on 04.03.2022.
//

import UIKit

let tablePhotos: [Photo] = [
    Photo(name: "kittie"),
    Photo(name: "cat1"),
    Photo(name: "cat2"),
    Photo(name: "cat3")
]

class ProfileViewController: UIViewController {

    private lazy var profileHeaderView: ProfileHeaderView = {
        let profileHeaderView = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 350))
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        return profileHeaderView
    }()
    
    private lazy var photosTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(ProfilePhotoGalleryTableViewCell.self, forCellReuseIdentifier: ProfilePhotoGalleryTableViewCell.identifier)
        return tableView
    }()
    
    private lazy var collectionHeaderView: ProfileGalleryHeaderView = {
        let headerView = ProfileGalleryHeaderView()
        headerView.backgroundColor = .red
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Профиль"
        self.view.backgroundColor = .lightGray
        setupView()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        photosTableView.frame = view.bounds
    }
    
    private func setupView() {
        self.view.addSubview(photosTableView)
        self.view.addSubview(profileHeaderView)
        
        let profileHeaderViewConstraints = [
            self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.profileHeaderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(profileHeaderViewConstraints)
        
        photosTableView.delegate = self
        photosTableView.dataSource = self
        photosTableView.tableHeaderView = profileHeaderView

    }
    
    @objc func galleryButtonPressed()  {
        DispatchQueue.main.async { [weak self] in
            let vc = PhotoGalleryViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource, PhotosTableViewCellDelegate {
    
    func photosTableViewCellDidTapCell(_ cell: ProfilePhotoGalleryTableViewCell) {
        DispatchQueue.main.async { [weak self] in
            let vc = PhotoGalleryViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfilePhotoGalleryTableViewCell.identifier, for: indexPath) as? ProfilePhotoGalleryTableViewCell else { return UITableViewCell() }
        cell.configure(with: tablePhotos)
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        header.addSubview(collectionHeaderView.stackView)
        
        collectionHeaderView.button.addTarget(self, action: #selector(galleryButtonPressed), for: UIControl.Event.touchUpInside)
        
        NSLayoutConstraint.activate([
            collectionHeaderView.stackView.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 12),
            collectionHeaderView.stackView.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -12),
            collectionHeaderView.stackView.topAnchor.constraint(equalTo: header.topAnchor)
        ])
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
}
