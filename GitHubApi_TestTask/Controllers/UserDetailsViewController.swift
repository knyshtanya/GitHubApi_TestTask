//
//  UserDetailsViewController.swift
//  GitHubApi_TestTask
//
//  Created by Tatiana Knysh on 13.01.2019.
//  Copyright © 2019 Tatiana Knysh. All rights reserved.
//

import UIKit
import Kingfisher

class UserDetailsViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var organizationLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    
    public var user: User?
    private let userDetailsViewModel = UserDetailsViewModel()
    
    private var aspectConstraint : NSLayoutConstraint? {
        didSet {
            if let old = oldValue {
                avatarImageView.removeConstraint(old)
            }
            if let new = aspectConstraint {
                avatarImageView.addConstraint(new)
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserDetails()
        fetchAvatar(user?.avatar)
        guard let user = user else { return }
        navigationItem.title = "\(user.name)"
    }
    
    // MARK: - Fetch user's details
    
    private func fetchUserDetails() {
        userDetailsViewModel.requestUserDetails(user: user) { [weak self] result in
            let userDetails = result
            self?.fetchOrganizations(userDetails.organization)

            DispatchQueue.main.async {
                self?.nameLabel.text = userDetails.name
                self?.emailLabel.text = userDetails.email
                self?.followingLabel.text = "\(userDetails.following)"
                self?.followersLabel.text = "\(userDetails.followers)"
                let creationDate = UserDetailsViewModel.formatter.string(from: userDetails.createdAt)
                self?.createdLabel.text = creationDate
            }
        }
    }
    
    // MARK: - Fetch user's organizations
    
    private func fetchOrganizations(_ url: URL?) {
        guard let url = url else { return }
        userDetailsViewModel.requestOrganizations(url) { [weak self] result in
            DispatchQueue.main.async {
                self?.organizationLabel.text = result.map { $0.name }.joined(separator: ", ")
            }
        }
    }

    // MARK: - Fetch user's avatar
    
    private func fetchAvatar(_ url: URL?) {
        guard let url = user?.avatar else { return }
        userDetailsViewModel.requestAvatar(url, user: user, avatarImageView: avatarImageView) { [weak self] (constraint) in
            self?.aspectConstraint = constraint
        }
    }
}
