//
//  ProfileGalleryView.swift
//  Navigation
//
//  Created by  Alena Sabadash on 03.04.2022.
//

import UIKit

class ProfileGalleryHeaderView: UIView {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        let buttonImage = UIImage(systemName: "arrow.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24))
        button.setImage(buttonImage, for: .normal)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.tintColor = .black
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [label, button])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
