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
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: IdeaDetailViewModel! {
        didSet {
            configureViews()
        }
    }

    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        let textFieldNib = UINib(nibName: "TextFieldCell", bundle: nil)
        tableView.register(textFieldNib, forCellReuseIdentifier: ID_TEXTFIELDCELL)
        
        let textViewNib = UINib(nibName: "TextViewCell", bundle: nil)
        tableView.register(textViewNib, forCellReuseIdentifier: ID_TEXTVIEWCELL)
        
        tableView.estimatedRowHeight = 10000
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.setNeedsLayout()
        self.tableView.layoutIfNeeded()
    }
    
    // MARK: - Functions
    
    func configureViews() {
        
    }

    @IBAction func onBackButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension IdeaDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = viewModel.reuseIdentifierForCellItem(inSection: indexPath.section, at: indexPath.row)
        
        if reuseIdentifier == ID_TEXTFIELDCELL {
            if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? TextFieldCell {
                cell.viewModel = viewModel.viewModelForCell(inSection: indexPath.section, at: indexPath.row) as! TextFieldCellViewModel
                cell.delegate = self
                cell.textField.tag = indexPath.row
                return cell
            }
        } else if reuseIdentifier == ID_TEXTVIEWCELL {
            if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? TextViewCell {
                cell.viewModel = viewModel.viewModelForCell(inSection: indexPath.section, at: indexPath.row) as! TextViewCellViewModel
                cell.delegate = self
                cell.textView.tag = indexPath.row
                return cell
            }
        }
        
        return tableView.dequeueReusableCell(withIdentifier: ID_TEXTFIELDCELL, for: indexPath)
    }
}

// MARK: - TextFieldCellDelegate, TextViewCellDelegate
extension IdeaDetailViewController: TextFieldCellDelegate, TextViewCellDelegate {
    
    func textFieldCellTextDidChange(tag: Int, text: String) {
        viewModel.textDidChange(tag: tag, text: text)
    }
    
    func textViewCellTextDidChange(tag: Int, text: String) {
        viewModel.textDidChange(tag: tag, text: text)
    }
}
