//
//  BookClientParser.swift
//  BooksApp
//
//  Created by Aravind on 06/09/17.
//  Copyright © 2017 HCL. All rights reserved.
//

import UIKit
// Will parse the data for the BookClient
class BookClientParser: NSObject {
    class func generateBooks(data: [NSDictionary])->[Book] {
        var books = [Book]()
        for result in data {
            let book = Book()
            book.title = (result.value(forKeyPath: Constants.KEY_BOOK_TITLE) as? String) ?? ""
            book.rating = (result.value(forKeyPath: Constants.KEY_AVERAGE_RATING) as? Double) ?? 0
            book.imageUrl = (result.value(forKeyPath: Constants.KEY_IMAGE_URL) as? String) ?? ""
            book.author = (result.value(forKeyPath: Constants.KEY_AUTHOR) as? [String])?.first ?? ""
            book.description = (result.value(forKeyPath: Constants.KEY_DESCRIPTION) as? String) ?? ""
            book.subTitle = (result.value(forKeyPath: Constants.KEY_BOOK_SUBTITLE) as? String) ?? ""
            book.textSnippet = (result.value(forKeyPath: Constants.KEY_TEXT_SNIPPET) as? String) ?? ""
            book.id = (result.value(forKeyPath: Constants.KEY_BOOK_ID) as? String) ?? ""
            book.previewLink = (result.value(forKeyPath: Constants.KEY_PREVIEW_LINK) as? String) ?? ""
            books.append(book)
        }
        return books
    }
}
