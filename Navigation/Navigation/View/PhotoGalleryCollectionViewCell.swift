//
//  PhotoGalleryCollectionViewCell.swift
//  Navigation
//
//  Created by  Alena Sabadash on 03.04.2022.
//

import UIKit

class PhotoGalleryCollectionViewCell: UICollectionViewCell {
    static let identifier = "PhotoGalleryCollectionViewCell"
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
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
        print("photo name: \(model.name)")
        photoImageView.image = UIImage(named: model.name)
    }
}
