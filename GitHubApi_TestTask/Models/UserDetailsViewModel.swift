//
//  UserDetailsViewModel.swift
//  GitHubApi_TestTask
//
//  Created by Tatiana Knysh on 14.01.2019.
//  Copyright © 2019 Tatiana Knysh. All rights reserved.
//

import UIKit

class UserDetailsViewModel {
    
    var fetchedOrganizations = [Organization]()
    
    static let formatter: DateFormatter = {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd-MM-YYYY"
        return dateformatter
    }()
    
    func requestUserDetails(user: User?, completion: @escaping (UserDetails) -> Void) {
        guard let user = user else { return }
        guard let url = URL(string: "https://api.github.com/users/\(user.name)") else { return }
        Loader.fetchEntity(url: url, entity: UserDetails.self) { result in
            guard let result = result else { return }
            completion(result)
        }
    }
    
    func requestOrganizations(_ url: URL?, completion: @escaping ([Organization]) -> Void) {
        guard let url = url else { return }
        Loader.fetchEntity(url: url, entity: [Organization].self) { result in
            guard let result = result else { return }
            completion(result)
        }
    }

    func requestAvatar(_ url: URL?, user: User?, avatarImageView: UIImageView, completion: @escaping (NSLayoutConstraint) -> Void) {
        guard let url = user?.avatar else { return }
        avatarImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder.png")) {(_, _, _, _) in
            guard let aspectConstraint = avatarImageView.aspectConstraint else { return }
            completion(aspectConstraint)
        }
    }
}
