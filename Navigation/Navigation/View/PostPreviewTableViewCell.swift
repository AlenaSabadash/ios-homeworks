//
//  PostPreviewTableViewCell.swift
//  Navigation
//
//  Created by  Alena Sabadash on 17.04.2022.
//

import UIKit

protocol PostPreviewTableViewCellDelegate: AnyObject {
    func didTapLike(_ cell: PostPreviewTableViewCell)
    func didTapPost(_ cell: PostPreviewTableViewCell)
}

class PostPreviewTableViewCell: UITableViewCell {
    
    static let identifier = "PostPreviewTableViewCell"
    
    weak var delegate: PostPreviewTableViewCellDelegate?
    
    var post: Post!
    
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
    
    private lazy var likeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.textAlignment = .right
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
    
    private lazy var bottomLabelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        setupGesture()
    }
    
    @objc func handleLike() {
        delegate?.didTapLike(self)
    }
    
    @objc func handlePostTap() {
        delegate?.didTapPost(self)
    }
    
    private func setupGesture() {
        likeLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLike)))
        postImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePostTap)))
    }
    
    private func setupConstraints() {
        contentView.addSubview(postTitleLabel)
        contentView.addSubview(postImageView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(bottomLabelsStackView)
        bottomLabelsStackView.addArrangedSubview(likeLabel)
        bottomLabelsStackView.addArrangedSubview(viewsLabel)
        
        let postTitleLabelConstraints = [
            postTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            postTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        let postImageViewConstraints = [
            postImageView.topAnchor.constraint(equalTo: postTitleLabel.bottomAnchor, constant: 12),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: 200)
        ]
        let descriptionLabelConstraints = [
            descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            
        ]
        let bottomLabelsConstraint = [
            bottomLabelsStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            bottomLabelsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bottomLabelsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(postTitleLabelConstraints + postImageViewConstraints + descriptionLabelConstraints + bottomLabelsConstraint)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postTitleLabel.text = nil
        postImageView.image = nil
    }
    
    public func configure(with post: Post) {
        self.post = post
        postTitleLabel.text = post.title
        postImageView.image = UIImage(named: post.title)
        descriptionLabel.text = post.description
        likeLabel.text = "Likes: \(post.likes)"
        viewsLabel.text = "Views: \(post.views)"
    }
    
}
