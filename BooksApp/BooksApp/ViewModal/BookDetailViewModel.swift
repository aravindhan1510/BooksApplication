//
//  BookDetailViewModel.swift
//  BooksApp
//
//  Created by Aravindhan on 06/09/17.
//  Copyright © 2017 HCL. All rights reserved.
//

import Foundation
import UIKit

class BookDetailViewModel: NSObject {
    var book: Book?
    // Returns the book title
    func getBookTitle() -> String {
        var resultString = ""
        if let result = book?.title {
            resultString = result
        }
        return resultString
    }
    // Returns the Author name
    func getAuthor() -> String {
        var resultString = ""
        if let result = book?.author {
            resultString = result
        }
        return resultString
    }
    // Returns the Subtitle
    func getSubTitle() -> String {
        var resultString = ""
        if let result = book?.subTitle {
            resultString = result
        }
        return resultString
    }
    // Returns the text snippet
    func getTextSnippet() -> String {
        var resultString = ""
        if let result = book?.textSnippet {
            resultString = result
        }
        return resultString
    }
    // Returns the average rating
    func getAverageRating() -> String {
        var resultString = ""
        if let result = book?.rating {
            resultString = String(format:"%@ - %.1f",Constants.AVERAGE_RATING,result)
        }
        return resultString
    }
    // Returns the description
    func getDescription() -> String {
        var resultString = ""
        if let result = book?.description {
            resultString = result
        }
        return resultString
    }
    // Returns the description
    func getThumbnail() -> String {
        var resultString = ""
        if let result = book?.imageUrl {
            resultString = result
        }
        return resultString
    }
    // Returns the description
    func getPreviewLink() -> String {
        var resultString = ""
        if let result = book?.previewLink {
            resultString = result
        }
        return resultString
    }
}
