//
//  Utilities.swift
//  BooksApp
//
//  Created by Aravind on 9/7/17.
//  Copyright © 2017 HCL. All rights reserved.
//

import UIKit

class Utilities: NSObject {
    class func showActivityIndicator(indicator:UIActivityIndicatorView, inView: UIView) {
        inView.isUserInteractionEnabled = false
        indicator.startAnimating()
        indicator.alpha = 1
    }
    class func hideActivityIndicator(indicator:UIActivityIndicatorView, inView: UIView) {
        inView.isUserInteractionEnabled = true
        indicator.stopAnimating()
        indicator.alpha = 0
    }
}
