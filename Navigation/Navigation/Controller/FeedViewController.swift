//
//  PostViewController.swift
//  Navigation
//
//  Created by  Alena Sabadash on 04.03.2022.
//

import UIKit

let posts: [Post] = [
    Post(title: "kittie"),
    Post(title: "cat1"),
    Post(title: "cat2"),
    Post(title: "cat3"),
    Post(title: "cat4"),
    Post(title: "cat5"),
    Post(title: "cat6"),
    Post(title: "cat7"),
    Post(title: "cat8"),
    Post(title: "cat9"),
    Post(title: "cat10"),
    Post(title: "cat11"),
    Post(title: "cat12"),
    Post(title: "cat13"),
    Post(title: "cat14"),
    Post(title: "cat15"),
    Post(title: "cat16"),
    Post(title: "cat17"),
    Post(title: "cat18"),
    Post(title: "cat19")
]

class FeedViewController: UIViewController {
    
    private lazy var postsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.allowsSelection = false
        tableView.register(PostPreviewTableViewCell.self, forCellReuseIdentifier: PostPreviewTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.title = "Лента"
        
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        postsTableView.frame = view.bounds
    }
    
    private func setupView() {
        self.view.addSubview(postsTableView)
        
        postsTableView.delegate = self
        postsTableView.dataSource = self
    }

    @objc private func didTapInfoMenuItem() {
        let infoVC = InfoViewController()
        present(infoVC, animated: true, completion: nil)
    }

}


extension FeedViewController: UITableViewDelegate, UITableViewDataSource, PostPreviewTableViewCellDelegate {
    
    func didTapPost(_ cell: PostPreviewTableViewCell) {
        let vc = PostViewController()
        vc.configure(with: cell)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapLike(_ cell: PostPreviewTableViewCell) {
        cell.post.likes += 1
        cell.configure(with: cell.post)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostPreviewTableViewCell.identifier, for: indexPath) as? PostPreviewTableViewCell else { return UITableViewCell() }
        cell.configure(with: posts[indexPath.row])
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        350
    }
    
}
