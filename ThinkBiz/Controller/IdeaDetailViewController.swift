//
//  IdeaDetailViewController.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 26/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit

class IdeaDetailViewController: UIViewController, IdeaDetailViewModelControllerDelegate {
    
    // MARK: - Properties
    
    var viewModel: IdeaDetailViewModel! {
        didSet {
            configureViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Functions
    
    func configureViews() {
        
    }

    @IBAction func onBackButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
