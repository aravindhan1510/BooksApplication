//
//  PreviewViewModal.swift
//  BooksApp
//
//  Created by Aravindhan on 06/09/17.
//  Copyright © 2017 HCL. All rights reserved.
//

import Foundation
import UIKit
class PreviewViewModal: NSObject {
    var previewLink: String?
   // Returns the preview link
    func getPreviewLink() -> URLRequest? {
        var resultRequest : URLRequest?
        if let urlPath = self.previewLink {
            if let resultURL = URL(string: urlPath) {
                let request: URLRequest = URLRequest(url: resultURL)
                resultRequest = request
            }
        }
        return resultRequest
    }
}
