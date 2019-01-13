//
//  UserDetails.swift
//  GitHubApi_TestTask
//
//  Created by Tatiana Knysh on 13.01.2019.
//  Copyright © 2019 Tatiana Knysh. All rights reserved.
//

import Foundation

struct UserDetails: Codable {
    let name: String
    let avatar: URL?
    let id: Int
    let email: String?
    let organization: URL?
    let following: Int
    let followers: Int
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatar = "avatar_url"
        case id
        case email
        case organization = "organizations_url"
        case following
        case followers
        case createdAt = "created_at"
    }
}
