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
//    let email: String
//    let organization: String
//    let followingCount: String
//    let followersCount: String
//    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatar = "avatar_url"
        case id
//        case email
//        case organization = "organizations_url"
//        case followingCount = "following_url"
//        case followersCount = "followers_url"
//        case createdAt = "created_at"
    }
    
    static func empty() -> User {
        return User(name: "", avatar: nil, id: 0)
    }
}
