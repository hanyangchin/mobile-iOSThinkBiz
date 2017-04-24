//
//  NewIdeaViewController.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 20/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit

class NewIdeaViewController: UIViewController, NewIdeaViewModelControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: NewIdeaViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ideaForm: IdeaForm = IdeaForm(nameLabelText: "Name", namePlaceholderText: "e.g ThinkBiz, Google, Starbucks, IKEA", ideaLabelText: "Description", ideaPlaceholderText: "Short description of your business idea. e.g ThinkBiz helps store and manage your business ideas for entrepreneurs", notesLabelText: "Notes", notesPlaceholderText: "Other information such as target audience, busniess model...")
        viewModel = NewIdeaViewModel(withIdeaForm: ideaForm)
        
        tableView.delegate = self
        tableView.dataSource = self

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Button handler

    @IBAction func onCancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension NewIdeaViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = viewModel.reuseIdentifierForCellItem(inSection: indexPath.section, at: indexPath.row)
        
        if reuseIdentifier == ID_TEXTFIELDCELL {
            if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? TextFieldTableViewCell {
                cell.viewModel = viewModel.viewModelForCell(inSection: indexPath.section, at: indexPath.row) as! TextFieldCellViewModel
                return cell
            }
        } else if reuseIdentifier == ID_TEXTVIEWCELL {
            if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? TextViewTableViewCell {
                cell.viewModel = viewModel.viewModelForCell(inSection: indexPath.section, at: indexPath.row) as! TextViewCellViewModel
                return cell
            }
        }
        

        return tableView.dequeueReusableCell(withIdentifier: ID_TEXTFIELDCELL, for: indexPath)
    }
}
