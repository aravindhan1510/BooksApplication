//
//  BooksViewController.swift
//  BooksApp
//
//  Created by Aravindhan on 06/09/17.
//  Copyright © 2017 HCL. All rights reserved.
//

import UIKit

public class BookStatusButton: UIButton {
    var indexPath: IndexPath?
}
class BooksViewController: UIViewController, BookTableViewCellDelegate {
    @IBOutlet weak var booksSearchBar: UISearchBar!
    @IBOutlet var viewModel: BooksViewModel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var filterBarButton: UIBarButtonItem!
    fileprivate let customNavigationAnimationController = CustomNavigationAnimationController()
    fileprivate var bookStatus = false
    fileprivate var searchKey: String!
    fileprivate var filterApplied = false
    fileprivate var searchApplied = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        fetchDefaultBooks()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateUI()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK:- Action Methods
   fileprivate func updateUI() {
        booksSearchBar.delegate = self
        booksSearchBar.showsCancelButton = true
        tableView.tableFooterView = UIView()
    }
    // Method to the fetch the books
   fileprivate func fetchDefaultBooks() {
        weak var blockTableView = self.tableView
        Utilities.showActivityIndicator(indicator: activityIndicator, inView: self.view)
        viewModel.fetchBooks(searchKey:Constants.DEFAULT_SEARCH_KEY, startIndex: 0 ,maxResult: 10) {
            DispatchQueue.main.async(execute: {
                Utilities.hideActivityIndicator(indicator: self.activityIndicator, inView: self.view)
                blockTableView?.reloadData()
            })
        }
    }
    // Handles the book read / unread status
   internal func bookReadingStatusChanged(sender: BookStatusButton) {
        let bookReadStatus = viewModel.getBookReadStatusAtIndexPath(sender.indexPath!)
        let bookId = viewModel.bookIdForItemAtIndexPath(sender.indexPath!)
        if bookReadStatus {
            sender.setTitle(BookReadStatus.UNREAD.rawValue, for: .normal)
            viewModel.saveToKeychain(key: bookId, value: BookReadStatus.UNREAD.rawValue)
            
        }else{
            sender.setTitle(BookReadStatus.READ.rawValue, for: .normal)
            viewModel.saveToKeychain(key: bookId, value: BookReadStatus.READ.rawValue)
        }
    }
    // Handles the filter of top rated books
    @IBAction func filterBarButtonTapped(_ sender: UIBarButtonItem) {
        showActionSheet()
    }
    fileprivate func showActionSheet() {
        let optionMenu = UIAlertController(title: nil, message: Constants.FILTER_CHOOSE_OPTION, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: Constants.FILTER_ALL, style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.viewModel.removeFilter(tableView: self.tableView)
            self.filterBarButton.title = Constants.FILTER
            self.filterApplied = false
        })
        let saveAction = UIAlertAction(title: Constants.FILTER_TOP_RATED, style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.viewModel.setFilter(rating: 4.0,tableView: self.tableView)
            self.filterBarButton.title = Constants.FILTER_TOP_RATED_RESULT
            self.filterApplied = true
        })
        let cancelAction = UIAlertAction(title: Constants.FILTER_CANCEL, style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
}
// Extension for the TableView Delegate and Datasource
extension BooksViewController : UITableViewDataSource, UITableViewDelegate {
    //MARK: - Table view delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bookCell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL_IDENTIFIER_BOOK, for: indexPath) as! BookTableViewCell
        bookCell.delegate = self
        bookCell.bookTitle.text = viewModel.titleForItemAtIndexPath(indexPath)
        bookCell.authorName.text = viewModel.authorNameItemAtIndexPath(indexPath)
        bookCell.bookStatus.indexPath = indexPath

        bookCell.bookThumbnail.downloadImageFrom(link: viewModel.imageUrlItemAtIndexPath(indexPath), contentMode: UIViewContentMode.scaleAspectFit)
        let isBookRead = viewModel.getBookReadStatusAtIndexPath(indexPath)
        if isBookRead {
             bookCell.bookStatus.setTitle(BookReadStatus.READ.rawValue, for: .normal)
        }else{
           bookCell.bookStatus.setTitle(BookReadStatus.UNREAD.rawValue, for: .normal)
        }
        return bookCell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if filterApplied == false {
            var finalSearchKey = String()
            if searchApplied == true {
                finalSearchKey = searchKey
            } else {
                finalSearchKey = Constants.DEFAULT_SEARCH_KEY
            }
            weak var blockTableView = self.tableView
            if indexPath.row+1 == viewModel.booksCount() {
                // Fetching next set of Books for pagination
                Utilities.showActivityIndicator(indicator: activityIndicator, inView: self.view)
                viewModel.fetchBooks(searchKey:finalSearchKey, startIndex: viewModel.booksCount()+1 ,maxResult: 10) {
                    DispatchQueue.main.async(execute: {
                        Utilities.hideActivityIndicator(indicator: self.activityIndicator, inView: self.view)
                        blockTableView?.reloadData()
                    })
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         self.performSegue(withIdentifier: Constants.KEY_DETAILS_SEGUE_IDENTIFIER, sender: indexPath)
    }
    //MARK: - Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == Constants.KEY_DETAILS_SEGUE_IDENTIFIER) {
            let bookDetailsController = segue.destination as! BookDetailsViewController
            if let indexPath = sender as? IndexPath {
                 bookDetailsController.bookDetailsModel.book = viewModel.getBookAtIndexPath(indexPath)
            }
        }
    }
}
// Extension for UINavigationControllerDelegate - Custom Transition
extension BooksViewController : UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        customNavigationAnimationController.reverse = operation == .pop
        return customNavigationAnimationController
    }
}
// Extension for UISearchBarDelegate
extension BooksViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        weak var blockTableView = self.tableView
        Utilities.showActivityIndicator(indicator: activityIndicator, inView: self.view)
        searchApplied = false
        self.viewModel.books.removeAll()
        viewModel.filteredList?.removeAll()
        
        viewModel.fetchBooks(searchKey:Constants.DEFAULT_SEARCH_KEY, startIndex: 0 ,maxResult: 10) {
            DispatchQueue.main.async(execute: {
                Utilities.hideActivityIndicator(indicator: self.activityIndicator, inView: self.view)
                self.viewModel.isFilterApplied = false
                self.filterBarButton.title = Constants.FILTER
                self.booksSearchBar.text = ""
                self.booksSearchBar.endEditing(true)
                blockTableView?.reloadData()
            })
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Utilities.showActivityIndicator(indicator: activityIndicator, inView: self.view)
        if booksSearchBar.text?.isEmpty == false {
           
            searchApplied = true
            weak var blockTableView = self.tableView
            searchKey = booksSearchBar.text
            viewModel.books.removeAll()
            viewModel.filteredList?.removeAll()
            viewModel.isFilterApplied = false
            self.filterApplied = false
            self.filterBarButton.title = Constants.FILTER
            
            viewModel.fetchBooks(searchKey:searchKey, startIndex: 0, maxResult: 10 ) {
                DispatchQueue.main.async(execute: {
                    Utilities.hideActivityIndicator(indicator: self.activityIndicator, inView: self.view)
                    blockTableView?.reloadData()
                    self.booksSearchBar.endEditing(true)
                })
            }
        }
    }
}

