//
//  DataModel.swift
//  GitHubApi_TestTask
//
//  Created by Tatiana Knysh on 14.01.2019.
//  Copyright © 2019 Tatiana Knysh. All rights reserved.
//

import Foundation

class DataModel {
    
    var users = [User]()

    func requestData(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://api.github.com/users") else { return }
        Loader.fetchEntity(url: url, entity: [User].self) { [weak self] result in
            if let result = result {
                self?.users = result
                completion()
            }
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return users.count
    }
}
