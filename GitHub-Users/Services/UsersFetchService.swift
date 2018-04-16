//
//  UsersFetchService.swift
//  GitHub-Users
//
//  Created by Дмитрий Полишенко on 4/14/18.
//  Copyright © 2018 Дмитрий Полишенко. All rights reserved.
//

import Foundation
import WebLinking

class UsersFetchService {
    private var downloadURL: String?
    
    init(stringUrl: String) {
        downloadURL = stringUrl
    }
    
    func downloadUsers(completion: @escaping (_ users: [User]) -> Void) {
        guard let nextURL = downloadURL else {
            print("no next download link")
            completion([])
            return
        }
        
        guard let url = URL(string: nextURL) else {
            print("invalid users download url")
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let requestError = error {
                    print(requestError)
                    completion([])
                }
                guard let usersData = data, let httpResponse = response as? HTTPURLResponse else {
                    print("user data or response is nil")
                    completion([])
                    return
                }
                
                self.downloadURL = httpResponse.findLink(relation: "next")?.uri ?? nil
                
                let users = try JSONDecoder().decode([User].self, from: usersData)
                completion(users)
            } catch let error as NSError {
                print(error)
                completion([])
            }
        }.resume()
    }
}
