//
//  UserDetailsViewController.swift
//  GitHubApi_TestTask
//
//  Created by Tatiana Knysh on 13.01.2019.
//  Copyright © 2019 Tatiana Knysh. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var organizationLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    
    public var user: User?
    private var userDetails: UserDetails?
    private var organizationURL: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserDetails()
    }
    
    private func fetchUserDetails() {
        guard let user = user else { return }
        guard let url = URL(string: "https://api.github.com/users/\(user.name)") else { return }
        Loader.fetchEntity(url: url, entity: UserDetails.self) { [weak self] result in
            if let result = result {
                self?.userDetails = result
            }
            DispatchQueue.main.async {
                guard let user = self?.userDetails else { return }
                self?.nameLabel.text = user.name
                self?.emailLabel.text = user.email
                self?.organizationURL = user.organization
                self?.followingLabel.text = "\(user.following)"
                self?.followersLabel.text = "\(user.followers)"
                self?.createdLabel.text = user.createdAt
            }
        }
    }
    
    private func fetchOrganization() {
        
    }
}
