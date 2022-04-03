//
//  PostViewController.swift
//  Navigation
//
//  Created by  Alena Sabadash on 04.03.2022.
//

import UIKit

struct Post {
    var title: String
}

class PostViewController: UIViewController {

    var post: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
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

    @objc private func didTapInfoMenuItem() {
        print("#function")
        let infoVC = InfoViewController()
        present(infoVC, animated: true, completion: nil)
    }

}
