import UIKit
import Kingfisher

class UsersTableViewController: UITableViewController {
    
    private var usersModel = UsersModel()
    
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
        usersModel.requestUsers {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                self?.refreshControl?.endRefreshing()
                self?.tableView.tableFooterView = nil
            }
        }
    }
    
    private func fetchNextUsers() {
        usersModel.requestNextUsers() {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                self?.refreshControl?.endRefreshing()
                self?.tableView.tableFooterView = nil
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersModel.usersCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UsersTableViewCell.reuseIdentifier, for: indexPath)
        guard let usersCell = cell as? UsersTableViewCell else { return UITableViewCell() }
        usersCell.user = usersModel[indexPath.row]
        return usersCell
    }
    
    // MARK: - Scroll view delegate
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard tableView.contentSize.height > 0 else { return }
        guard tableView.tableFooterView == nil else { return }
        
        if tableView.contentOffset.y >= (tableView.contentSize.height - tableView.frame.size.height) {
            let spinner = UIActivityIndicatorView(style: .gray)
            spinner.color = UIColor.darkGray
            spinner.hidesWhenStopped = true
            spinner.startAnimating()
            tableView.tableFooterView = spinner
            fetchNextUsers()
        }
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let userDetailsVC = storyboard.instantiateViewController(withIdentifier: "UserDetailsVC") as? UserDetailsViewController else { return }
        userDetailsVC.user = usersModel[indexPath.row]
        navigationController?.pushViewController(userDetailsVC, animated: true)
    }
}
