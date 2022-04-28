//
//  PhotoGalleryDetailViewController.swift
//  Navigation
//
//  Created by  Alena Sabadash on 18.04.2022.
//

import UIKit

protocol PhotoGalleryDetailViewControllerDelegate: AnyObject {
    func photoDidTap()
}

class PhotoGalleryDetailViewController: UIViewController {
    
    weak var delegate: PhotoGalleryDetailViewControllerDelegate?

    lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePhotoTap)))
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(postImageView)
        
        NSLayoutConstraint.activate([
            postImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: self.view.bounds.height / 2),
            postImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    public func configure(with image: UIImage) {
        self.postImageView.image = image
    }
    
    @objc func handlePhotoTap() {
        self.delegate?.photoDidTap()
        dismiss(animated: true, completion: nil)
    }
    
}
