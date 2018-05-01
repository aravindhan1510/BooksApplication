//
//  BookDetailViewController.swift
//  BooksApp
//
//  Created by Aravindhan on 06/09/17.
//  Copyright © 2017 HCL. All rights reserved.
//

import UIKit

class BookDetailsViewController: UIViewController {
    let bookDetailsModel = BookDetailViewModel()
    @IBOutlet weak var bookThumbnail: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var averageRatingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var textSnippetLabel: UILabel!
    
    @IBOutlet weak var showMoreButton: UIButton!
    
    fileprivate let customPresentAnimationController = CustomPresentAnimationController()
    fileprivate let customDismissAnimationController = CustomDismissAnimationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateUI()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.BAR_BUTTON_TITLE, style: .plain, target: self, action: #selector(previewTapped))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK:- Action Methods
    @objc fileprivate func previewTapped(_ button:UIBarButtonItem!){
        self.performSegue(withIdentifier: Constants.KEY_PREVIEW_SEGUE_IDENTIFIER, sender: nil)
    }
    @IBAction func showMoreButtonTapped(_ sender: Any) {
        descriptionLabel.numberOfLines = 0
        showMoreButton.alpha = 0
    }
    fileprivate func updateUI() {
        self.title = bookDetailsModel.getBookTitle()
        titleLabel.text = bookDetailsModel.getBookTitle()
        authorLabel.text = bookDetailsModel.getAuthor()
        subTitleLabel.text = bookDetailsModel.getSubTitle()
        textSnippetLabel.text = bookDetailsModel.getTextSnippet()
        averageRatingLabel.text = bookDetailsModel.getAverageRating()
        descriptionLabel.text = bookDetailsModel.getDescription()
        bookThumbnail.downloadImageFrom(link: bookDetailsModel.getThumbnail(), contentMode: UIViewContentMode.scaleAspectFit)
    }
}
extension BookDetailsViewController : UIViewControllerTransitioningDelegate,UINavigationControllerDelegate{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.KEY_PREVIEW_SEGUE_IDENTIFIER {
            let previewController = segue.destination as! PreviewViewController
            previewController.previewModel.previewLink = bookDetailsModel.getPreviewLink()
            
            let toViewController = segue.destination as UIViewController
            toViewController.transitioningDelegate = self
        }
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customPresentAnimationController
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customDismissAnimationController
        
    }
}
