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
        
        viewModel = NewIdeaViewModel(withIdeaForm: IdeaForm.form)
        
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
    
    @IBAction func onSaveButtonPressed(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        viewModel.saveIdea(context: context)
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
extension NewIdeaViewController: TextFieldCellDelegate, TextViewCellDelegate {
    
    func textFieldCellTextDidChange(tag: Int, text: String) {
        viewModel.textDidChange(tag: tag, text: text)
    }
    
    func textViewCellTextDidChange(tag: Int, text: String) {
        viewModel.textDidChange(tag: tag, text: text)
    }
}
