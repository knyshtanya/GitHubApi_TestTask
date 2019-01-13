//
//  Organization.swift
//  GitHubApi_TestTask
//
//  Created by Tatiana Knysh on 13.01.2019.
//  Copyright © 2019 Tatiana Knysh. All rights reserved.
//

import Foundation

struct Organization: Codable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
    }
}
