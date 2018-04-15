//
//  User.swift
//  GitHub-Users
//
//  Created by Дмитрий Полишенко on 4/14/18.
//  Copyright © 2018 Дмитрий Полишенко. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int
    let login: String
    let imageURL: String
    let profileURL: String
    let followersURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, login
        case imageURL = "avatar_url"
        case profileURL = "html_url"
        case followersURL = "followers_url"
    }
}
