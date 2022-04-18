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
    
    private var smallView: UIView?
    private var smallFrame: CGRect?
    private var bigFrame: CGRect?
    
    private let photoTapGestureRecognizer = UITapGestureRecognizer()
    
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
//        setupGesture()

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
        bigFrame = view.frame
        self.view.addSubview(collectionView)
        
        let galleryConstraints = [
            collectionView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: -8),
        ]
        
        NSLayoutConstraint.activate(galleryConstraints)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupGesture() {
        self.photoTapGestureRecognizer.addTarget(self, action: #selector(self.handlePhotoTap(_:)))
        collectionView.addGestureRecognizer(photoTapGestureRecognizer)
    }
    
    @objc private func viewTapped() {
        UIView.animate(withDuration: 1, animations: { [weak self] in
            guard let smallFrame = self?.smallFrame else { return }
            self?.smallView?.frame = smallFrame
        }) { [weak self] _ in
            self?.smallView?.removeFromSuperview()
            self?.collectionView.isUserInteractionEnabled = true
        }
    }
    
    @objc private func handlePhotoTap(_ gestureRecognizer: UITapGestureRecognizer) {
        guard self.photoTapGestureRecognizer === gestureRecognizer else { return }
        
        guard let targetIndexPath = collectionView.indexPathForItem(at: photoTapGestureRecognizer.location(in: collectionView)) else { return }
        let qwe = photoGallery[targetIndexPath.row]
        print("targetIndexPath: \(qwe.name)")
        
//        UIView.animate(withDuration: 0.3) {
//            self.logInView.logInButtonTopAnchor?.constant = self.logInView.errorLabel.isHidden ? 16 : 40
//            self.view.layoutIfNeeded()
//        }
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
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        smallFrame = collectionView.convert(cell.frame, to: view)
        smallView = cell.copyView()
        guard let smallFrame = smallFrame, let smallView = smallView else { return }
        smallView.frame = smallFrame
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        smallView.addGestureRecognizer(tapGestureRecognizer)
        view.addSubview(smallView)
        collectionView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 1, animations: { [weak self] in
            guard let frame = self?.bigFrame else { return }
            self?.smallView?.frame = frame
        })
    }
    
}

extension UIView
{
    func copyView<T: UIView>() -> T {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
    }
}
