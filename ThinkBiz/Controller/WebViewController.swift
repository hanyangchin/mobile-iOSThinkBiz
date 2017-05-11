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
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: - Functions
    
    private func setupView() {
        setupNavigationBar()
        
        webView.delegate = self
        
        loadURL()
    }
    
    private func setupNavigationBar() {
        setupLeftBarButtonItem()
    }
    
    private func setupLeftBarButtonItem() {
        
        let backImage = UIImage(named: "left")
        backImage?.withRenderingMode(.alwaysTemplate)
        
        let backButton = UIButton(type: .system)
        backButton.setImage(backImage, for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        backButton.tintColor = Styles.white
        
        backButton.addTarget(self, action: #selector(WebViewController.onBackButtonPressed(_:)), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
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
    
    // MARK: - Action handlers

    @IBAction func onBackButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
