//
//  DataModel.swift
//  GitHubApi_TestTask
//
//  Created by Tatiana Knysh on 14.01.2019.
//  Copyright © 2019 Tatiana Knysh. All rights reserved.
//

import Foundation

class UsersViewModel {
    
    var users = [User]()
    var usersCount: Int {
        return users.count
    }

    func requestData(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://api.github.com/users") else { return }
        Loader.fetchEntity(url: url, entity: [User].self) { [weak self] result in
            if let result = result {
                self?.users = result
                completion()
            }
        }
    }
}
