//
//  User.swift
//  GitHubApi_TestTask
//
//  Created by Tatiana Knysh on 12.01.2019.
//  Copyright © 2019 Tatiana Knysh. All rights reserved.
//

import Foundation

struct User: Codable {
    let name: String
    let avatar: URL?
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatar = "avatar_url"
        case id
    }
}
