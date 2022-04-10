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
        layout.itemSize = CGSize(width: width / 4, height: width / 4)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProfilePhotosGalleryCollectionViewCell.self, forCellWithReuseIdentifier: ProfilePhotosGalleryCollectionViewCell.identifier)
        return collectionView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.font = .boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        let buttonImage = UIImage(systemName: "arrow.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24))
        button.setImage(buttonImage, for: .normal)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 12
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellStackView)
        cellStackView.addArrangedSubview(headerStackView)
        cellStackView.addArrangedSubview(collectionView)
        headerStackView.addArrangedSubview(label)
        headerStackView.addArrangedSubview(button)

        NSLayoutConstraint.activate([
            cellStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            cellStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            cellStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            cellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
        
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
        self.collectionView.reloadData()
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

