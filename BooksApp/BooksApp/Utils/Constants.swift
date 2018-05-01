//
//  Constants.swift
//  BooksApp
//
//  Created by Aravindhan on 06/09/17.
//  Copyright © 2017 HCL. All rights reserved.
//

struct Constants {
    
    static let BASE_URL = "https://www.googleapis.com/books"
    static let VOLUME_URI = "/v1/volumes?free-ebooks"
    static let DEFAULT_SEARCH_KEY = "Beautiful"
    static let KEY_QUERY_URI = "&q="
    static let KEY_START_INDEX = "&startIndex="
    static let KEY_MAX_RESULTS = "&maxResults="
    
    static let KEY_ITEMS = "items"
    static let KEY_BOOK_TITLE = "volumeInfo.title"
    static let KEY_BOOK_SUBTITLE = "volumeInfo.subtitle"
    static let KEY_AVERAGE_RATING = "volumeInfo.averageRating"
    static let KEY_DESCRIPTION = "volumeInfo.description"
    static let KEY_AUTHOR = "volumeInfo.authors"
    static let KEY_IMAGE_URL = "volumeInfo.imageLinks.thumbnail"
    static let KEY_TEXT_SNIPPET = "volumeInfo.searchInfo.textSnippet"
    static let KEY_PREVIEW_LINK = "volumeInfo.previewLink"
    static let KEY_BOOK_ID = "id"
    
    
    static let KEY_DETAILS_SEGUE_IDENTIFIER = "detailView"
    static let KEY_PREVIEW_SEGUE_IDENTIFIER = "previewBook"
    static let AVERAGE_RATING = "Average Rating"
   
    static let FILTER_CHOOSE_OPTION = "Choose Option"
    static let FILTER_ALL = "All"
    static let FILTER = "Filter"
    static let FILTER_TOP_RATED = "Top Rated"
    static let FILTER_TOP_RATED_RESULT = "Filter - Top Rated"
    static let FILTER_CANCEL = "Cancel"
    
    static let CELL_IDENTIFIER_BOOK = "bookCellIdentifier"
    static let BAR_BUTTON_TITLE = "Preview"
    
}
