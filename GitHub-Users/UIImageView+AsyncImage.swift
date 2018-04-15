//
//  UIImageView+AsyncImage.swift
//  GitHub-Users
//
//  Created by Дмитрий Полишенко on 4/14/18.
//  Copyright © 2018 Дмитрий Полишенко. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        self.image = nil
        
        guard let url = URL(string: urlString) else {
            print("invalid url")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let requestError = error  {
                print(requestError)
                return
            }
            
            DispatchQueue.main.async {
                guard let imageData = data , let image = UIImage(data: imageData) else {
                    print("image creation error")
                    return
                }
                self.image = image
            }
        }.resume()
    }
}
