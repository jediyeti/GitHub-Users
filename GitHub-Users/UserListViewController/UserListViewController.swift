//
//  UserListViewController.swift
//  GitHub-Users
//
//  Created by Дмитрий Полишенко on 4/14/18.
//  Copyright © 2018 Дмитрий Полишенко. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {
    enum DataType {
        case users
        case followers
    }
    
    @IBOutlet private weak var usersTableView: UITableView!
    
    var usersFetcher: UsersFetchService?
    var type: DataType = .users
    
    private var users = [User]()
    private var selectedUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadUsers()
        setupTableView()
    }
    
    private func downloadUsers() {
        usersFetcher?.downloadUsers { (downloadedUsers) in
            if !downloadedUsers.isEmpty {
                self.users.append(contentsOf: downloadedUsers)
                
                DispatchQueue.main.async {
                    self.usersTableView.reloadData()
                }
            }
        }
    }
    
    private func setupTableView() {
        if type == .followers {
            usersTableView.allowsSelection = false
        }
    }
}

//MARK: - UITableViewDataSource & UITableViewDelegate methods
extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == users.count - 6 {
            downloadUsers()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserListCell", for: indexPath) as? UserListCell else { return UITableViewCell() }
        cell.configure(with: users[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if type == .users {
            selectedUser = users[indexPath.row]
            performSegue(withIdentifier: "followersSegue", sender: self)
        }
    }
}

//MARK: - Navigation
extension UserListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "followersSegue" {
            if let destinationController = segue.destination as? UserListViewController, let selectedUser = selectedUser {
                destinationController.usersFetcher = UsersFetchService(stringUrl: selectedUser.followersURL)
                destinationController.type = .followers
            }
        }
    }
}
