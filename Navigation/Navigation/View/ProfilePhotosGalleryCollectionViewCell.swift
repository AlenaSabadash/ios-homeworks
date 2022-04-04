//
//  ProfilePhotosGalleryCollectionViewCell.swift
//  Navigation
//
//  Created by  Alena Sabadash on 02.04.2022.
//

import UIKit

class ProfilePhotosGalleryCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProfilePhotosGalleryCollectionViewCell"
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.frame = contentView.bounds
    }
    
    public func configure(with model: Photo) {
        photoImageView.image = UIImage(named: model.name)
    }
}
