//
//  PhotoGalleryViewController.swift
//  Navigation
//
//  Created by  Alena Sabadash on 03.04.2022.
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
    
    var photoImageView: UIView?
    var stratingPhotoImageViewFrame: CGRect?
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoGalleryCollectionViewCell else { return }
        
        if let photoImageViewFrame = cell.photoImageView.superview?.convert(cell.photoImageView.frame, to: nil) {
            stratingPhotoImageViewFrame = photoImageViewFrame
            
            photoImageView = UIView(frame: stratingPhotoImageViewFrame!)
            photoImageView?.backgroundColor = UIColor.white
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.photoImageView?.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height)
            }, completion: { completed in
                let vc = PhotoGalleryDetailViewController()
                vc.delegate = self
                vc.configure(with: cell.photoImageView.image!)
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overCurrentContext
                
                self.present(vc, animated: true, completion: nil)
            })
            
            view.addSubview(photoImageView!)
        }
    }

}

extension PhotoGalleryViewController: PhotoGalleryDetailViewControllerDelegate {
    func photoDidTap() {
        UIView.animate(withDuration: 0.3, animations: {
            self.photoImageView?.frame = self.stratingPhotoImageViewFrame!
        }, completion: { completed in
            self.photoImageView?.removeFromSuperview()
        })
    }
}
