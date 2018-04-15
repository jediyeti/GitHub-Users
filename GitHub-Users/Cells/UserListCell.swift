//
//  UserListCell.swift
//  GitHub-Users
//
//  Created by Дмитрий Полишенко on 4/14/18.
//  Copyright © 2018 Дмитрий Полишенко. All rights reserved.
//

import Foundation
import UIKit

class UserListCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var profileLinkLabel: UILabel!
    
    func configure(with user: User) {
        avatarImageView.imageFromServerURL(urlString: user.imageURL)
        loginLabel.text = user.login
        profileLinkLabel.text = user.profileURL
    }
}
