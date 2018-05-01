//
//  BooksViewModel.swift
//  BooksApp
//
//  Created by Aravindhan on 06/09/17.
//  Copyright © 2017 HCL. All rights reserved.
//

import Foundation
import UIKit

enum BookReadStatus: String {
    case READ = "Readed"
    case UNREAD = "Pending"
}
class BooksViewModel: NSObject {
    @IBOutlet var bookClient: BookClient!
    var books = [Book]()
    var filteredList: [Book]?
    var isFilterApplied: Bool = false
   
    func configureBookURL(searchKey:String,startIndex:Int,maxResult:Int) -> String {
        var searchQuery = Constants.KEY_QUERY_URI
        searchQuery = searchQuery + searchKey
        searchQuery = searchQuery + "\(Constants.KEY_START_INDEX)\(startIndex)\(Constants.KEY_MAX_RESULTS)\(maxResult)"
        let resoureceUrl = Constants.BASE_URL + Constants.VOLUME_URI + searchQuery
        return resoureceUrl
    }
    // Fetch the book from the BookClient
    func fetchBooks(searchKey:String,startIndex:Int?,maxResult:Int?, completion: @escaping () -> ()) {
        let resultUrl = self.configureBookURL(searchKey:searchKey,startIndex:startIndex ?? 0,maxResult:maxResult ?? 10)
        bookClient.fetchBooks(resoureceUrl: resultUrl, completion: { (books, error)  in
            if let bookDetails = books {
                for book in bookDetails {
                    self.books.append(book)
                }
                completion()
            }
        })
    }
    // Returns title for the table view cell
    func titleForItemAtIndexPath(_ indexPath: IndexPath) -> String {
        if isFilterApplied {
            return (filteredList?[indexPath.row].title)!
        } else {
            return (books[indexPath.row].title)!
        }
    }
    // Returns title for the table view cell
    func authorNameItemAtIndexPath(_ indexPath: IndexPath) -> String {
        if isFilterApplied {
            return (filteredList?[indexPath.row].author)!
        } else {
            return (books[indexPath.row].author)!
        }
    }
    // Returns the image URL
    func imageUrlItemAtIndexPath(_ indexPath: IndexPath) -> String {
        if isFilterApplied {
            return (filteredList?[indexPath.row].imageUrl)!
        } else {
            return (books[indexPath.row].imageUrl)!
        }
    }
     // Returns number of sections for table view cell
    func numberOfItemsInSection(_ section: Int) -> Int {
         if isFilterApplied {
            return filteredList?.count ?? 0
         } else {
            return books.count
        }
    }
    // Filters the Books based on the rating
    func setFilter(rating:Double,tableView:UITableView) {
        filteredList = books.filter({
            $0.rating! >= rating
        })    
       
        isFilterApplied = true
        tableView.reloadData()
    }
    // Removes the filter
    func removeFilter(tableView:UITableView) {
        filteredList = []
        isFilterApplied = false
        tableView.reloadData()
    }
    // Returns the books count
    func booksCount() -> Int {
        if isFilterApplied {
            return filteredList?.count ?? 0
        } else {
            return books.count 
        }
    }
    // Get Book at Indexpath
    func getBookAtIndexPath(_ indexPath: IndexPath) -> Book {
        if isFilterApplied {
            return (filteredList?[indexPath.row])!
        } else {
            return (books[indexPath.row])
        }
    }
    // Returns the Book Id for the Books
    func bookIdForItemAtIndexPath(_ indexPath: IndexPath) -> String {
        if isFilterApplied {
            return (filteredList?[indexPath.row].id)!
        } else {
            return (books[indexPath.row].id)!
        }
    }
    // Fetches the read / pending status of the books from Keychain
    func getBookReadStatusAtIndexPath(_ indexPath: IndexPath) -> Bool {
        var isBookRead = false
        var  bookReadStatusString :String?
        if isFilterApplied {
            bookReadStatusString = KeychainHandler.shared[(filteredList?[indexPath.row].id)!] as String? // Fetch
        } else {
            bookReadStatusString = KeychainHandler.shared[(books[indexPath.row].id)!] as String? // Fetch
        }
        if(bookReadStatusString?.caseInsensitiveCompare(BookReadStatus.UNREAD.rawValue) == ComparisonResult.orderedSame){
            isBookRead = false
        }else if(bookReadStatusString?.caseInsensitiveCompare(BookReadStatus.READ.rawValue) == ComparisonResult.orderedSame){
            isBookRead = true
        }
        return isBookRead
        
    }
    // Saves the value to the keychain
    func saveToKeychain(key:String,value:String) {
        KeychainHandler.shared[key] = value// Store
    }
}
