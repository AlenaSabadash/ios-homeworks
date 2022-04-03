//
//  PhotoGalleryViewController.swift
//  Navigation
//
//  Created by  Alena Sabadash on 03.04.2022.
//

import UIKit

let photoGallery: [Photo] = [
    Photo(name: "kittie"),
    Photo(name: "cat1"),
    Photo(name: "cat2"),
    Photo(name: "cat3"),
    Photo(name: "cat4"),
    Photo(name: "cat5"),
    Photo(name: "cat6"),
    Photo(name: "cat7"),
    Photo(name: "cat8"),
    Photo(name: "cat9"),
    Photo(name: "cat10"),
    Photo(name: "cat11"),
    Photo(name: "cat12"),
    Photo(name: "cat13"),
    Photo(name: "cat14"),
    Photo(name: "cat15"),
    Photo(name: "cat16"),
    Photo(name: "cat17"),
    Photo(name: "cat18"),
    Photo(name: "cat19")
]

class PhotoGalleryViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        layout.minimumLineSpacing = 8
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotoGalleryCollectionViewCell.self, forCellWithReuseIdentifier: PhotoGalleryCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Photo Gallery"
        self.view.backgroundColor = .lightGray
        setupView()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private func setupView() {
        self.view.addSubview(collectionView)
        
        let galleryConstraints = [
            collectionView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: -8),
        ]
        
        NSLayoutConstraint.activate(galleryConstraints)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}

extension PhotoGalleryViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoGallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoGalleryCollectionViewCell.identifier, for: indexPath) as? PhotoGalleryCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(with: photoGallery[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width / 3) - 12
        return CGSize(width: width, height: width)
    }

}
