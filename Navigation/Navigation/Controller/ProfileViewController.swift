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
        let profileHeaderView = ProfileHeaderView(frame: .zero)
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        return profileHeaderView
    }()
    
    private lazy var photosTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.allowsSelection = false
        tableView.register(ProfilePhotoGalleryTableViewCell.self, forCellReuseIdentifier: ProfilePhotoGalleryTableViewCell.identifier)
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.identifier)
        return tableView
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
        
        photosTableView.delegate = self
        photosTableView.dataSource = self
    }
    
    @objc func galleryButtonPressed()  {
        let vc = PhotoGalleryViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource, PhotosTableViewCellDelegate {
    
    func photosTableViewCellDidTapCell(_ cell: ProfilePhotoGalleryTableViewCell) {
        let vc = PhotoGalleryViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.identifier) as? ProfileHeaderView else { return nil }
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfilePhotoGalleryTableViewCell.identifier, for: indexPath) as? ProfilePhotoGalleryTableViewCell else { return UITableViewCell() }
        cell.configure(with: tablePhotos)
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PhotoGalleryViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        170
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        200
    }
}
