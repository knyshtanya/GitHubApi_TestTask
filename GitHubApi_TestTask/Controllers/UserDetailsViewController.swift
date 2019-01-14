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
    private var userDetails: UserDetails?
    private var fetchedOrganizations = [Organization]()
    
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
    
    // MARK: - Fetch users details
    
    private func fetchUserDetails() {
        guard let user = user else { return }
        guard let url = URL(string: "https://api.github.com/users/\(user.name)") else { return }
        Loader.fetchEntity(url: url, entity: UserDetails.self) { [weak self] result in
            guard let result = result else { return }
            self?.userDetails = result
            self?.fetchOrganizations(result.organization)
            
            DispatchQueue.main.async {
                guard let user = self?.userDetails else { return }
                self?.nameLabel.text = user.name
                self?.emailLabel.text = user.email
                self?.followingLabel.text = "\(user.following)"
                self?.followersLabel.text = "\(user.followers)"
                let dateformatter = DateFormatter()
                dateformatter.dateFormat = "dd-MM-YYYY"
                let creationDate = dateformatter.string(from: user.createdAt)
                self?.createdLabel.text = creationDate
            }
        }
    }
    
    // MARK: - Fetch user's organizations
    
    private func fetchOrganizations(_ url: URL?) {
        guard let url = url else { return }
        Loader.fetchEntity(url: url, entity: [Organization].self) { [weak self] result in
            if let result = result {
                self?.fetchedOrganizations = result
            }
            DispatchQueue.main.async {
                self?.organizationLabel.text = self?.fetchedOrganizations.map { $0.name }.joined(separator: ", ")
            }
        }
    }
    
    // MARK: - Fetch user's avatar
    
    private func fetchAvatar(_ url: URL?) {
        guard let url = user?.avatar else { return }
        avatarImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder.png")) { [weak self] (_, _, _, _) in
            self?.aspectConstraint = self?.avatarImageView.aspectConstraint
        }
    }
}
