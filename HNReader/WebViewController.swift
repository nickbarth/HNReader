//
//  WebViewController.swift
//  HNReader
//
//  Created by Nick on 4/21/15.
//  Copyright (c) 2015 Nick. All rights reserved.
//

import Foundation
import UIKit

class WebViewController: BaseViewController {
    var webView:UIWebView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = UIWebView()
        webView.frame = bounds()
        webView.scalesPageToFit = true
        
        view.addSubview(webView)
    }
    
    func goToURL(url:NSURL) {
        webView.loadRequest(NSURLRequest(URL: url))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.topItem?.title = "HNReader"
    }
}