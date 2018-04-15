//
//  AppDelegate+DI.swift
//  GitHub-Users
//
//  Created by Дмитрий Полишенко on 4/15/18.
//  Copyright © 2018 Дмитрий Полишенко. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate {
    func injectDependencyInRootController() {
        if let navigationController = window?.rootViewController as? UINavigationController {
            if let navRootController = navigationController.visibleViewController as? UserListViewController {
                navRootController.usersFetcher = UsersFetchService(stringUrl: APILinks.gitHubUsers)
            }
        }
    }
}
