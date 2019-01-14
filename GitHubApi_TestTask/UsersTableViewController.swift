//
//  UsersTableViewController.swift
//  GitHubApi_TestTask
//
//  Created by Tatiana Knysh on 12.01.2019.
//  Copyright © 2019 Tatiana Knysh. All rights reserved.
//

import UIKit
import Kingfisher

class UsersTableViewController: UITableViewController {
    
    private var users = [User]()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "GitHub Users"
        tableView.register(UsersTableViewCell.self, forCellReuseIdentifier: UsersTableViewCell.reuseIdentifier)
        fetchUsers()
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    // MARK: - Actions
    
    @objc private func refresh() {
       fetchUsers()
    }
    
    // MARK: - Fetch users
    
    private func fetchUsers() {
        guard let url = URL(string: "https://api.github.com/users") else { return }
        Loader.fetchEntity(url: url, entity: [User].self) { [weak self] result in
            if let result = result {
                self?.users = result
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.refreshControl?.endRefreshing()
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UsersTableViewCell.reuseIdentifier, for: indexPath)
        guard let usersCell = cell as? UsersTableViewCell else { return UITableViewCell() }
        usersCell.user = users[indexPath.row]
        return usersCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let userDetailsVC = storyboard.instantiateViewController(withIdentifier: "UserDetailsVC") as? UserDetailsViewController else { return }
        userDetailsVC.user = users[indexPath.row]
        navigationController?.pushViewController(userDetailsVC, animated: true)
    }
}
