//
//  WebViewController.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 19/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    var viewModel: WebViewViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.delegate = self
        
        loadURL()
    }

    func loadURL() {
        if viewModel == nil {
            return
        }
        if let urlPath = viewModel.url {
            if let url = URL(string: urlPath) {
                
                // Set title
                print("Title is \(viewModel.title!)")
                if let webTitle = viewModel.title {
                    self.title = webTitle
                }
                let request = URLRequest(url: url)
                webView.loadRequest(request)
            }
        }

    }

}
