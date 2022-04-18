//
//  PostViewController.swift
//  Navigation
//
//  Created by  Alena Sabadash on 04.03.2022.
//

import UIKit


class PostViewController: UIViewController {

    var post: Post!
    var cell: PostPreviewTableViewCell!
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var postTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        post?.views += 1
        cell.configure(with: post)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupView()
        self.title = post?.title ?? "No title"

        var menuItems: [UIAction] {
            return [
                UIAction(title: "Информация", image: UIImage(systemName: "info.circle"), handler: { _ in
                    self.didTapInfoMenuItem()
                })
            ]
        }

        var menu: UIMenu {
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Меню", image: nil, primaryAction: nil, menu: menu)
    }
    
    private func setupView() {
        view.addSubview(postTitleLabel)
        view.addSubview(postImageView)
        view.addSubview(descriptionLabel)
        
        let postTitleLabelConstraints = [
            postTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            postTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            postTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ]
        let postImageViewConstraints = [
            postImageView.topAnchor.constraint(equalTo: postTitleLabel.bottomAnchor, constant: 12),
            postImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: 200)
        ]
        let descriptionLabelConstraints = [
            descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            
        ]
        
        NSLayoutConstraint.activate(postTitleLabelConstraints + postImageViewConstraints + descriptionLabelConstraints)
    }
    
    public func configure(with cell: PostPreviewTableViewCell) {
        self.cell = cell
        self.post = cell.post
        postTitleLabel.text = post.title
        postImageView.image = UIImage(named: post.title)
        descriptionLabel.text = post.description
    }
    
    @objc private func didTapInfoMenuItem() {
        let infoVC = InfoViewController()
        present(infoVC, animated: true, completion: nil)
    }

}
