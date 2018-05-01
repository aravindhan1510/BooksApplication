//
//  BookClient.swift
//  BooksApp
//
//  Created by Aravindhan on 06/09/17.
//  Copyright © 2017 HCL. All rights reserved.
//

import Foundation
import UIKit
class BookClient: NSObject {
    // This method is responsible for calling books API ,parsing it's data and passing back to caller.
    func fetchBooks(resoureceUrl:String, completion: @escaping ([Book]?,_ error: Error?) -> ()) {
        let url = URL(string: resoureceUrl)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url!, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                completion(nil,nil)
                return
            }
            if let httpURLResponse = response as? HTTPURLResponse {
                if httpURLResponse.statusCode != 200 {
                    let responseError: NSError = NSError(domain: (httpURLResponse.url?.host)!, code: httpURLResponse.statusCode, userInfo: nil)
                    completion(nil,responseError)

                } else {
                    do {
                        if let json = try  JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary,
                            let books = json.value(forKeyPath: Constants.KEY_ITEMS) as? [NSDictionary] {
                            completion(BookClientParser.generateBooks(data: books), nil)
                            return
                        }
                    } catch {
                        completion(nil,error)
                        return
                    }
                }
            }
        })
        task.resume()
    }
}
