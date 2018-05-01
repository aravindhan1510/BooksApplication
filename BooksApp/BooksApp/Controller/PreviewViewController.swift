//
//  PreviewViewController.swift
//  BooksApp
//
//  Created by Aravindhan on 06/09/17.
//  Copyright © 2017 HCL. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var previewWebView: UIWebView!
    let previewModel = PreviewViewModal()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
        Utilities.showActivityIndicator(indicator: activityIndicator, inView: self.view)
        // Do any additional setup after loading the view.
    }
    fileprivate func loadWebView() {
        if let request = previewModel.getPreviewLink() {
            previewWebView.loadRequest(request)
            previewWebView.delegate = self
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func dismissButtonTapped(_ sender: Any) {
          self.dismiss(animated: true, completion: nil)
    }
}
extension PreviewViewController : UIWebViewDelegate
{
    //MARK: - WebViewDelegate
    public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    public func webViewDidStartLoad(_ webView: UIWebView) {
      
    }
    public func webViewDidFinishLoad(_ webView: UIWebView) {
         Utilities.hideActivityIndicator(indicator: self.activityIndicator, inView: self.view)
       
    }
    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
         Utilities.hideActivityIndicator(indicator: self.activityIndicator, inView: self.view)
    }
    
}
