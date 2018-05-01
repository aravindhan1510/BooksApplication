//
//  Extensions.swift
//  BooksApp
//
//  Created by Aravindhan on 06/09/17.
//  Copyright © 2017 HCL. All rights reserved.
//

import UIKit
// For loading the images in background
extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIViewContentMode) {
        if let imageURL = URL(string: link) {
            URLSession.shared.dataTask( with:imageURL , completionHandler: {
                (data, response, error) -> Void in
                DispatchQueue.main.async() {
                    self.contentMode =  contentMode
                    if let data = data { self.image = UIImage(data: data) }
                }
            }).resume()
        }
    }
}

