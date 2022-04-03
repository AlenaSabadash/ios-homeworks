//
//  ProfilePhotoGalleryTableViewCell.swift
//  Navigation
//
//  Created by  Alena Sabadash on 28.03.2022.
//

import UIKit

protocol PhotosTableViewCellDelegate: AnyObject {
    func photosTableViewCellDidTapCell(_ cell: ProfilePhotoGalleryTableViewCell)
}

class ProfilePhotoGalleryTableViewCell: UITableViewCell {
    
    private var photos: [Photo] = [Photo]()
    
    static var identifier = "ProfilePhotoGalleryTableViewCell"
    
    weak var delegate: PhotosTableViewCellDelegate?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        layout.itemSize = CGSize(width: width / 4, height: width / 4)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProfilePhotosGalleryCollectionViewCell.self, forCellWithReuseIdentifier: ProfilePhotosGalleryCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with photos: [Photo]) {
        self.photos = photos
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }

}

extension ProfilePhotoGalleryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfilePhotosGalleryCollectionViewCell.identifier, for: indexPath) as? ProfilePhotosGalleryCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(with: photos[indexPath.row])
 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("Selected photo is: \(photos[indexPath.row].name)")
        self.delegate?.photosTableViewCellDidTapCell(self)
    }
}

